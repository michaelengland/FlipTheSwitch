@import Foundation;
@import UIKit;

@class FTSFeatureCell;
#import "FTSFeatureDescriptionLabel.h"

@protocol FlipTheSwitchCellDelegate <NSObject>
- (void)flipTheSwitchCellDidToggleFeature:(FTSFeatureCell *)cell;
@end

@interface FTSFeatureCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *featureNameLabel;
@property (nonatomic, weak) IBOutlet UISwitch *toggle;
@property (nonatomic, weak) IBOutlet FTSFeatureDescriptionLabel *featureDescriptionLabel;

@property (nonatomic, weak) id<FlipTheSwitchCellDelegate> delegate;
@end
