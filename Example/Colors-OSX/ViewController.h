#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSView *leftView;
@property (weak) IBOutlet NSView *rightView;
@property (weak) IBOutlet NSTextField *leftLabel;
@property (weak) IBOutlet NSTextField *rightLabel;

@property(nonatomic, strong) NSView *leftColoredView;
@property(nonatomic, strong) NSView *rightColoredView;

@end

