#import "FlipTheSwitch.h"

@interface FlipTheSwitch ()
@property (nonatomic, readonly) NSUserDefaults *userDefaults;
@property (nonatomic, readonly) NSBundle *bundle;
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
                                                     bundle:[NSBundle mainBundle]];
    });
    return sharedInstance;
}

#pragma mark - Initialization

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
                              bundle:(NSBundle *)bundle
{
    self = [super init];
    if (self) {
        NSParameterAssert(userDefaults);
        NSParameterAssert(bundle);
        _userDefaults = userDefaults;
        _bundle = bundle;
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
        return [[[self plistEnabledFeatures] objectForKey:feature] boolValue];
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
    [self.userDefaults setBool:enabled forKey:[self userKeyForFeature:feature]];
    [self.userDefaults synchronize];
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
    return [self.bundle pathForResource:@"Features" ofType:@"plist"];
}

@end
