#import "FTSFeatureConfigurationViewController.h"
#import "FTSFlipTheSwitch.h"
#import "FTSFeatureCell.h"

static NSString * const FTSFeatureCellIdentifier = @"featureCell";

@interface FTSFeatureConfigurationViewController () <UITableViewDelegate, UITableViewDataSource, FlipTheSwitchCellDelegate>
@property (nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FTSFeatureConfigurationViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupDataSource];
}

#pragma mark - Actions

- (IBAction)doneButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetFeatures:(UIButton *)sender {
    [self resetFeatures];
}

- (void)resetFeatures{
    [[FTSFlipTheSwitch sharedInstance] resetAllFeatures];
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (void)reloadData
{
    [self loadFeatureData];
    [self.tableView reloadData];
}

- (void)setupDataSource
{
    [self loadFeatureData];
}

- (void)loadFeatureData{
    self.dataSource = [[FTSFlipTheSwitch sharedInstance] features];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForBasicCellAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureFeatureCell:self.sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:self.sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell
{
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(sizingCell.bounds));
    [sizingCell layoutIfNeeded];

    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // seperator
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self featureCellAtIndexPath:indexPath];
}
    
#pragma mark - FlipTheSwitchCellDelegate

- (void)flipTheSwitchCellDidToggleFeature:(FTSFeatureCell *)cell
{
    NSUInteger index = (NSUInteger)[self.tableView indexPathForCell:cell].row;
    FTSFeature *feature = self.dataSource[index];
    [[FTSFlipTheSwitch sharedInstance] setFeature:feature.name
                                          enabled:cell.toggle.on];
}

#pragma mark - Private

- (void)configureFeatureCell:(FTSFeatureCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    FTSFeature *feature = self.dataSource[(NSUInteger)indexPath.row];
    [self presentCell:cell withFeature:feature];
}

- (FTSFeatureCell *)featureCellAtIndexPath:(NSIndexPath *)indexPath
{
    FTSFeatureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:FTSFeatureCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [self configureFeatureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)presentCell:(FTSFeatureCell *)cell withFeature:(FTSFeature *)feature
{
    cell.featureNameLabel.text = feature.name;
    [cell.toggle setOn:feature.enabled animated:NO];
    cell.featureDescriptionLabel.text = feature.featureDescription;
}

- (FTSFeatureCell *)sizingCell
{
    static FTSFeatureCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:FTSFeatureCellIdentifier];
        // iOS bug fix to avoid breaking a by system added 'UIView-Encapsulated-Layout-Height' constraint
        sizingCell.frame = CGRectMake(0, 0, 100, 100);
        sizingCell.contentView.frame = sizingCell.frame;
    });
    return sizingCell;
}

@end
