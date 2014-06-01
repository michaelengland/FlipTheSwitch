#import "FlipTheSwitch.h"

@interface FlipTheSwitch ()
@property (nonatomic, readonly) NSUserDefaults *userDefaults;
@end

@implementation FlipTheSwitch

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static FlipTheSwitch *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
    });
    return sharedInstance;
}

#pragma mark - Initialization

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
{
    self = [super init];
    if (self) {
        NSParameterAssert(userDefaults);
        _userDefaults = userDefaults;
    }
    return self;
}

#pragma mark - Public

- (BOOL)isFeatureEnabled:(NSString *)feature
{
    return [self.userDefaults boolForKey:[self keyForFeature:feature]];
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
    [self.userDefaults setBool:enabled forKey:[self keyForFeature:feature]];
    [self.userDefaults synchronize];
}

#pragma mark - Private

- (NSString *)keyForFeature:(NSString *)feature
{
    return [NSString stringWithFormat:@"FTS_FEATURE_%@", feature];
}

@end
