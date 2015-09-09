#import "RedView.h"

@implementation RedView

- (void)drawRect:(NSRect)dirtyRect {
    // Fill in background Color
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 1,0.2,0.2,1);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

@end
