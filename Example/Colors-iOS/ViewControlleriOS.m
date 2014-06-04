#import "ViewControlleriOS.h"

#import "FlipTheSwitch.h"

static NSString *const kRedColorFeature = @"red_color";

@interface ViewControlleriOS ()
@property (nonatomic, weak) IBOutlet UILabel *colorInfoTextView;
@property (nonatomic, weak) IBOutlet UIButton *colorChangeButton;
@end

@implementation ViewControlleriOS

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Actions

- (IBAction)colorChangeButtonTapped
{
    [self toggleFeature];
}

#pragma mark - Private

- (void)setupView
{
    NSString *colorName;
    UIColor *color;
    if ([self isRedFeatureEnabled]) {
        colorName = @"Red";
        color = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    } else {
        colorName = @"Green";
        color = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    }
    self.colorInfoTextView.text = [NSString stringWithFormat:@"The screen is %@", colorName];
    self.view.backgroundColor = color;
}

- (void)toggleFeature
{
    if ([self isRedFeatureEnabled]) {
        [self disableRedFeature];
    } else {
        [self enableRedFeature];
    }
    [self setupView];
}

- (BOOL)isRedFeatureEnabled
{
    return [[FlipTheSwitch sharedInstance] isFeatureEnabled:kRedColorFeature];
}

- (void)disableRedFeature
{
    [[FlipTheSwitch sharedInstance] disableFeature:kRedColorFeature];
}

- (void)enableRedFeature
{
    [[FlipTheSwitch sharedInstance] enableFeature:kRedColorFeature];
}

@end
