#import "FTSFeatureCell.h"

@implementation FTSFeatureCell

#pragma mark - Action

- (IBAction)featureToggled:(id)sender
{
    [self.delegate flipTheSwitchCellDidToggleFeature:self];
}

@end
