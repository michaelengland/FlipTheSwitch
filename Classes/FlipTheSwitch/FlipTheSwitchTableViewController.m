#import "FlipTheSwitchTableViewController.h"
#import "FlipTheSwitch.h"
#import "FlipTheSwitch+Plist.h"
#import "FlipTheSwitchCell.h"

@interface FlipTheSwitchTableViewController () <FlipTheSwitchCellDelegate>
@property (nonatomic) NSDictionary *dataSource;
@end

@implementation FlipTheSwitchTableViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource.allKeys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlipTheSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"featureCell"];
    NSString *feature = self.dataSource.allKeys[(NSUInteger)indexPath.row];
    [self presentCell:cell feature:feature enabled:[self.dataSource[feature] boolValue]];
    cell.delegate = self;
    return cell;
}

#pragma mark - FlipTheSwitchCellDelegate

- (void)flipTheSwitchCellDidToggleFeature:(FlipTheSwitchCell *)cell
{
    NSUInteger index = (NSUInteger)[self.tableView indexPathForCell:cell].row;
    [[FlipTheSwitch sharedInstance] setFeature:self.dataSource.allKeys[index]
                                       enabled:cell.toggle.on];
}

#pragma mark - Private

- (void)setupDataSource
{
    NSMutableDictionary *plistFeatures = [[[FlipTheSwitch sharedInstance] plistEnabledFeatures] mutableCopy];
    [plistFeatures enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        plistFeatures[key] = @([[FlipTheSwitch sharedInstance] isFeatureEnabled:key]);
    }];
    self.dataSource = plistFeatures;
}

- (void)presentCell:(FlipTheSwitchCell *)cell feature:(NSString *)feature enabled:(BOOL)enabled
{
    cell.feature.text = feature;
    [cell.toggle setOn:enabled animated:NO];
}

@end
