@interface FlipTheSwitch : NSObject
- (instancetype)init __attribute__((unavailable("init not available ")));
+ (instancetype)sharedInstance;

- (BOOL)isFeatureEnabled:(NSString *)feature;
- (void)enableFeature:(NSString *)feature;
- (void)disableFeature:(NSString *)feature;
- (void)setFeature:(NSString *)feature enabled:(BOOL)enabled;
@end
