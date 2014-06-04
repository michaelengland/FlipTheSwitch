#import "ViewControllerMac.h"

#import "ColorView.h"
#import "FlipTheSwitch.h"

static NSString *const kRedColorFeature = @"red_color";

@interface ViewControllerMac ()
@property (nonatomic, weak) IBOutlet ColorView *colorView;
@property (nonatomic, weak) IBOutlet NSTextField *colorInfoTextView;
@property (nonatomic, weak) IBOutlet NSButton *colorChangeButton;
@end

@implementation ViewControllerMac

#pragma mark - NSViewController Lifecycle

- (void)loadView
{
    [super loadView];
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
    NSColor *color;
    if ([self isRedFeatureEnabled]) {
        colorName = @"Red";
        color = [NSColor colorWithSRGBRed:1 green:0 blue:0 alpha:1];
    } else {
        colorName = @"Green";
        color = [NSColor colorWithSRGBRed:0 green:1 blue:0 alpha:1];
    }
    self.colorInfoTextView.stringValue = [NSString stringWithFormat:@"The screen is %@", colorName];
//    self.colorView.backgroundColor = color;
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
