#import "ViewControlleriOS.h"

#import "FTSFlipTheSwitch+Features.h"

@interface ViewControlleriOS ()
@property (nonatomic, weak) IBOutlet UIView *topColorView;
@property (nonatomic, weak) IBOutlet UILabel *topColorInfoTextView;
@property (nonatomic, weak) IBOutlet UIButton *topColorChangeButton;
@property (nonatomic, weak) IBOutlet UIView *bottomColorView;
@property (nonatomic, weak) IBOutlet UILabel *bottomColorInfoTextView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *featuresButton;
@end

@implementation ViewControlleriOS

#pragma mark - Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupStateChangeNotifications];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupView];
}

#pragma mark - Actions

- (IBAction)topColorChangeButtonTapped
{
    [self toggleRedFeature];
}

- (IBAction)featuresButtonTapped:(id)sender
{
    [self openFeaturesController];
}

#pragma mark - Private

- (void)setupStateChangeNotifications
{
    [self setupNotification:UIApplicationWillEnterForegroundNotification];
    [self setupNotification:UIApplicationDidBecomeActiveNotification];
}

- (void)setupNotification:(NSString *)notification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationStateChanged:)
                                                 name:notification
                                               object:nil];
}

- (void)applicationStateChanged:(UIApplication *)application
{
    [self setupView];
}

- (void)setupView
{
    [self setupTopView];
    [self setupBottomView];
    [self setupFeaturesButton];
}

- (void)setupTopView
{
    NSString *topColorName;
    UIColor *topColor;
    if ([FTSFlipTheSwitch isRedColorEnabled]) {
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
    if ([FTSFlipTheSwitch isPurpleColorEnabled]) {
        bottomColorName = @"Purple";
        bottomColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:1];
    } else {
        bottomColorName = @"Yellow";
        bottomColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    }
    self.bottomColorInfoTextView.text = [NSString stringWithFormat:@"The bottom part of the screen is %@", bottomColorName];
    self.bottomColorView.backgroundColor = bottomColor;
}

- (void)setupFeaturesButton
{
    if (![FTSFlipTheSwitch isFeaturesControllerEnabled]) {
        self.navigationController.navigationBar.topItem.rightBarButtonItems = @[];
    }
}

- (void)toggleRedFeature
{
    if ([FTSFlipTheSwitch isRedColorEnabled]) {
        [FTSFlipTheSwitch disableRedColor];
    } else {
        [FTSFlipTheSwitch enableRedColor];
    }
    [self setupView];
}

- (void)openFeaturesController
{
    NSBundle *flipTheSwitchBundle = [self flipTheSwithBundle];
    UIStoryboard *flipTheSwitchStoryboard = [UIStoryboard storyboardWithName:@"FlipTheSwitch"
                                                                      bundle:flipTheSwitchBundle];
    UIViewController *flipTheSwitchController = [flipTheSwitchStoryboard instantiateInitialViewController];
    [self presentViewController:flipTheSwitchController
                       animated:YES
                     completion:nil];
}

- (NSBundle *)flipTheSwithBundle
{
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"FlipTheSwitch" ofType:@"bundle"]];
}

@end
