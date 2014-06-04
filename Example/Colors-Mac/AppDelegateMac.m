#import "AppDelegateMac.h"

#import "ViewControllerMac.h"

@interface AppDelegateMac ()
@property (nonatomic) ViewControllerMac *viewControllerMac;
@property (nonatomic, assign) IBOutlet NSWindow *window;
@end

@implementation AppDelegateMac

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    self.viewControllerMac = [[ViewControllerMac alloc] initWithNibName:@"MainView" bundle:nil];
    [self.window.contentView addSubview:self.viewControllerMac.view];
}

@end
