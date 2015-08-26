@import Foundation;
@import UIKit;

@class FTSFeatureCell;

@protocol FlipTheSwitchCellDelegate <NSObject>
- (void)flipTheSwitchCellDidToggleFeature:(FTSFeatureCell *)cell;
@end

@interface FTSFeatureCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *featureNameLabel;
@property (nonatomic, weak) IBOutlet UISwitch *toggle;
@property (weak, nonatomic) IBOutlet UILabel *featureDescriptionLabel;

@property (nonatomic, weak) id<FlipTheSwitchCellDelegate> delegate;
@end
