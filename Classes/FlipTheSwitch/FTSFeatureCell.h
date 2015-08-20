@import Foundation;
@import UIKit;

@class FTSFeatureCell;

@protocol FlipTheSwitchCellDelegate <NSObject>
- (void)flipTheSwitchCellDidToggleFeature:(FTSFeatureCell *)cell;
@end

@interface FTSFeatureCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *feature;
@property (nonatomic, weak) IBOutlet UISwitch *toggle;
@property (weak, nonatomic) IBOutlet UILabel *featureDescription;

@property (nonatomic, weak) id<FlipTheSwitchCellDelegate> delegate;
@end
