#import "FTSFeatureConfigurationViewController.h"
#import "FTSFlipTheSwitch.h"
#import "FTSFeatureCell.h"

@interface FTSFeatureConfigurationViewController () <FlipTheSwitchCellDelegate>
@property (nonatomic) NSArray *dataSource;
@end

@implementation FTSFeatureConfigurationViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupDataSource];
}

#pragma mark - Actions

- (IBAction)doneButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTSFeatureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"featureCell"];
    FTSFeature *feature = self.dataSource[(NSUInteger)indexPath.row];
    [self presentCell:cell withFeature:feature];
    cell.delegate = self;
    return cell;
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

- (void)setupDataSource
{
    self.dataSource = [[FTSFlipTheSwitch sharedInstance] features];
}

- (void)presentCell:(FTSFeatureCell *)cell withFeature:(FTSFeature *)feature
{
    cell.feature.text = feature.name;
    [cell.toggle setOn:feature.enabled animated:NO];
    cell.featureDescription.text = feature.featureDescription;
}

@end
