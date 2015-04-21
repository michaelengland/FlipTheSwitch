#import <Foundation/Foundation.h>

extern NSString *const FTSFeatureStatusChangedNotification;
extern NSString *const FTSFeatureStatusChangedNotificationFeatureKey;
extern NSString *const FTSFeatureStatusChangedNotificationEnabledKey;
extern NSString *const FTSFeaturePlistNameKey;

@interface FlipTheSwitch : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)sharedInstance;

- (BOOL)isFeatureEnabled:(NSString *)feature;
- (void)enableFeature:(NSString *)feature;
- (void)disableFeature:(NSString *)feature;
- (void)setFeature:(NSString *)feature enabled:(BOOL)enabled;
- (void)resetFeature:(NSString *)feature;
@end
