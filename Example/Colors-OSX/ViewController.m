#import "ViewController.h"
#import "RedView.h"
#import "PurpleView.h"
#import "YellowView.h"
#import "GreenView.h"


typedef enum Colors {
    Red,
    Yellow,
    Green,
    Purple
} Colors;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupStateChangeNotifications];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear {
    [super viewWillAppear];
}

- (void)setupStateChangeNotifications
{
    [self setupNotification:NSApplicationDidBecomeActiveNotification];
}

- (void)setupNotification:(NSString *)notification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationStateChanged:)
                                                 name:notification
                                               object:nil];
}

- (void)applicationStateChanged:(NSApplication *)application
{
    [self setupView];
}

- (void)setupView
{
    [self setupLeftView];
    [self setupRightView];
}

- (void)setupLeftView {

    if (self.leftColoredView) {
        [self.leftColoredView removeFromSuperview];
        [self.leftColoredView removeConstraints:[self.leftColoredView constraints]];
    }
    
    if (true) {
        self.leftColoredView = [self coloredViewForColor:Red];
        self.leftLabel.stringValue = @"The left view is red";
    } else {
        self.leftColoredView = [self coloredViewForColor:Green];
        self.leftLabel.stringValue = @"The left view is green";
    }
    
    [self setLayoutForLeftView];
}

- (void)setupRightView {
    
    if (self.rightColoredView) {
        [self.rightColoredView removeFromSuperview];
        [self.rightColoredView removeConstraints:[self.rightColoredView constraints]];
    }
    
    if (true) {
        self.rightColoredView = [self coloredViewForColor:Purple];
        self.rightLabel.stringValue = @"The right view is purple";
    } else {
        self.rightColoredView = [self coloredViewForColor:Yellow];
        self.rightLabel.stringValue = @"The right view is yellow";
    }
    [self setLayoutForRightView];
}

-(void) setLayoutForLeftView {
    
    NSDictionary *views = @{ @"inner": self.leftColoredView };
    [self.leftColoredView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.leftView addSubview:self.leftColoredView];
    [self.leftView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[inner]|"
                                                                          options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.leftView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[inner]|"
                                                                          options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

-(void) setLayoutForRightView {
    
    NSDictionary *views = @{ @"inner": self.rightColoredView };
    [self.rightColoredView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightView addSubview:self.rightColoredView];
    [self.rightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[inner]|"
                                                                          options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.rightView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[inner]|"
                                                                          options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

-(NSView *)coloredViewForColor:(Colors)color {
    NSView *coloredView;
    
    switch (color) {
        case Red:
            coloredView = [[RedView alloc] init];
            break;
        case Yellow:
            coloredView = [[YellowView alloc] init];
            break;
        case Green:
            coloredView = [[GreenView alloc] init];
            break;
        default:
            coloredView = [[PurpleView alloc] init];
            break;
    }
    return coloredView;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
