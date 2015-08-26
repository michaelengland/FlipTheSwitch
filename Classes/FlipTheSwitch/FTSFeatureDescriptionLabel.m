#import "FTSFeatureDescriptionLabel.h"

@implementation FTSFeatureDescriptionLabel

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.numberOfLines == 0 && bounds.size.width != self.preferredMaxLayoutWidth) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
    }
}

@end
