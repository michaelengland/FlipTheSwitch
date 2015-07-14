#import "FlipTheSwitch.h"

NSString *const FTSFeatureStatusChangedNotification = @"FTSFeatureStatusChangedNotification";
NSString *const FTSFeatureStatusChangedNotificationFeatureKey = @"FTSFeatureStatusChangedNotificationFeatureKey";
NSString *const FTSFeatureStatusChangedNotificationEnabledKey = @"FTSFeatureStatusChangedNotificationEnabledKey";
NSString *const FTSFeaturePlistNameKey = @"FTSFeaturePlistNameKey";


@interface FlipTheSwitch ()
@property (nonatomic, readonly) NSUserDefaults *userDefaults;
@property (nonatomic, readonly) NSBundle *bundle;
@property (nonatomic, readonly) NSNotificationCenter *notificationCenter;
@end

@implementation FlipTheSwitch {
    NSDictionary *_plistEnabledFeatures;
}

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static FlipTheSwitch *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithUserDefaults:[NSUserDefaults standardUserDefaults]
                                                     bundle:[NSBundle mainBundle]
                                         notificationCenter:[NSNotificationCenter defaultCenter]];
    });
    return sharedInstance;
}

#pragma mark - Initialization

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
                              bundle:(NSBundle *)bundle
                  notificationCenter:(NSNotificationCenter *)notificationCenter
{
    self = [super init];
    if (self) {
        NSParameterAssert(userDefaults);
        NSParameterAssert(bundle);
        NSParameterAssert(notificationCenter);
        _userDefaults = userDefaults;
        _bundle = bundle;
        _notificationCenter = notificationCenter;
    }
    return self;
}

#pragma mark - Public

- (BOOL)isFeatureEnabled:(NSString *)feature
{
    NSNumber *userEnabledFeature = [self.userDefaults objectForKey:[self userKeyForFeature:feature]];
    if (userEnabledFeature) {
        return [userEnabledFeature boolValue];
    } else {
        return [[self plistEnabledFeatures][feature] boolValue];
    }
}

- (void)enableFeature:(NSString *)feature
{
    [self setFeature:feature enabled:YES];
}

- (void)disableFeature:(NSString *)feature
{
    [self setFeature:feature enabled:NO];
}

- (void)setFeature:(NSString *)feature enabled:(BOOL)enabled
{
    if (![self isFeatureEnabled:feature] == enabled) {
        [self.userDefaults setObject:@(enabled) forKey:[self userKeyForFeature:feature]];
        [self.userDefaults synchronize];
        [self.notificationCenter postNotification:[self statusChangeNotificationForFeature:feature
                                                                                   enabled:enabled]];
    }
}

- (void)resetFeature:(NSString *)feature
{
    [self.userDefaults removeObjectForKey:[self userKeyForFeature:feature]];
    [self.userDefaults synchronize];
    [self.notificationCenter postNotification:[self statusChangeNotificationForFeature:feature
                                                                               enabled:[self isFeatureEnabled:feature]]];
}

#pragma mark - Private

- (NSString *)userKeyForFeature:(NSString *)feature
{
    return [NSString stringWithFormat:@"FTS_FEATURE_%@", feature];
}

- (NSDictionary *)plistEnabledFeatures
{
    if (!_plistEnabledFeatures) {
        _plistEnabledFeatures = [[NSDictionary alloc] initWithContentsOfFile:[self featurePlistPath]];
    }
    return _plistEnabledFeatures;
}

- (NSString *)featurePlistPath
{
    NSString *plistName = [self.userDefaults objectForKey:FTSFeaturePlistNameKey];
    if (plistName == nil) {
      plistName = @"Features";
    }
    return [self.bundle pathForResource:plistName ofType:@"plist"];
}

- (NSNotification *)statusChangeNotificationForFeature:(NSString *)feature enabled:(BOOL)enabled
{
    return [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                         object:self
                                       userInfo:@{
                                           FTSFeatureStatusChangedNotificationFeatureKey : feature,
                                           FTSFeatureStatusChangedNotificationEnabledKey : @(enabled)
                                       }];
}

@end
