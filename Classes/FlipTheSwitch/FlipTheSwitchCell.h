@import Foundation;
@import UIKit;

@class FlipTheSwitchCell;

@protocol FlipTheSwitchCellDelegate <NSObject>
- (void)flipTheSwitchCellDidToggleFeature:(FlipTheSwitchCell *)cell;
@end

@interface FlipTheSwitchCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *feature;
@property (nonatomic, weak) IBOutlet UISwitch *toggle;

@property (nonatomic, weak) id<FlipTheSwitchCellDelegate> delegate;
@end
