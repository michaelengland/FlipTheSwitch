/* AUTO-GENERATED. DO NOT ALTER */
#import <FlipTheSwitch/FlipTheSwitch.h>

@interface FlipTheSwitch (Features)
// This is the first feature
+ (BOOL)isFirstFeatureEnabled;
+ (void)enableFirstFeature;
+ (void)disableFirstFeature;
+ (void)setFirstFeatureEnabled:(BOOL)enabled;
+ (void)resetFirstFeature;
+ (NSString *)firstFeatureKey;

+ (BOOL)isSecondFeatureEnabled;
+ (void)enableSecondFeature;
+ (void)disableSecondFeature;
+ (void)setSecondFeatureEnabled:(BOOL)enabled;
+ (void)resetSecondFeature;
+ (NSString *)secondFeatureKey;

+ (void)resetAll;
@end
