#import "PurpleView.h"

@implementation PurpleView

- (void)drawRect:(NSRect)dirtyRect {
    // Fill in background Color
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 0.2,0.2,1,1);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

@end
