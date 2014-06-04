#import "ColorView.h"

@implementation ColorView

#pragma mark - Properties

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    if (backgroundColor != _backgroundColor) {
        _backgroundColor = backgroundColor;
        [self setNeedsDisplay:YES];
    }
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [self.backgroundColor set];
    NSRectFill([self bounds]);
}

@end
