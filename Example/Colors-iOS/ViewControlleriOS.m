#import "ViewControlleriOS.h"

#import "FlipTheSwitch+Features.h"

@interface ViewControlleriOS ()
@property (nonatomic, weak) IBOutlet UIView *topColorView;
@property (nonatomic, weak) IBOutlet UILabel *topColorInfoTextView;
@property (nonatomic, weak) IBOutlet UIButton *topColorChangeButton;
@property (nonatomic, weak) IBOutlet UIView *bottomColorView;
@property (nonatomic, weak) IBOutlet UILabel *bottomColorInfoTextView;
@end

@implementation ViewControlleriOS

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Actions

- (IBAction)topColorChangeButtonTapped
{
    [self toggleRedFeature];
}

#pragma mark - Private

- (void)setupView
{
    [self setupTopView];
    [self setupBottomView];
}

- (void)setupTopView
{
    NSString *topColorName;
    UIColor *topColor;
    if ([FlipTheSwitch isRedColorEnabled]) {
        topColorName = @"Red";
        topColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    } else {
        topColorName = @"Green";
        topColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    }
    self.topColorInfoTextView.text = [NSString stringWithFormat:@"The top part of the screen is %@", topColorName];
    self.topColorView.backgroundColor = topColor;
}

- (void)setupBottomView
{
    NSString *bottomColorName;
    UIColor *bottomColor;
    if ([FlipTheSwitch isPurpleColorEnabled]) {
        bottomColorName = @"Purple";
        bottomColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:1];
    } else {
        bottomColorName = @"Yellow";
        bottomColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    }
    self.bottomColorInfoTextView.text = [NSString stringWithFormat:@"The bottom part of the screen is %@", bottomColorName];
    self.bottomColorView.backgroundColor = bottomColor;
}

- (void)toggleRedFeature
{
    if ([FlipTheSwitch isRedColorEnabled]) {
        [FlipTheSwitch disableRedColor];
    } else {
        [FlipTheSwitch enableRedColor];
    }
    [self setupView];
}

@end
