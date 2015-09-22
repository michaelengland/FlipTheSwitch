@import Foundation;

#import "FTSFeature.h"

extern NSString *const FTSFeatureStatusChangedNotification;
extern NSString *const FTSFeatureStatusChangedNotificationFeatureKey;
extern NSString *const FTSFeatureStatusChangedNotificationEnabledKey;
extern NSString *const FTSFeaturePlistNameKey;

@interface FTSFlipTheSwitch : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)sharedInstance;

- (NSArray *)features;
- (BOOL)isFeatureEnabled:(NSString *)feature;
- (void)enableFeature:(NSString *)feature;
- (void)disableFeature:(NSString *)feature;
- (void)setFeature:(NSString *)feature enabled:(BOOL)enabled;
- (void)resetFeature:(NSString *)feature;
- (void)resetAllFeatures;
@end
