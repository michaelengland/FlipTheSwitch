#import "YellowView.h"

@implementation YellowView

- (void)drawRect:(NSRect)dirtyRect {
    // Fill in background Color
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 1,1,0.2,1);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

@end
