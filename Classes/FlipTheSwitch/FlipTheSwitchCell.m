#import "FlipTheSwitchCell.h"

@implementation FlipTheSwitchCell

#pragma mark - Action

- (IBAction)featureToggled:(id)sender
{
    [self.delegate flipTheSwitchCellDidToggleFeature:self];
}

@end
