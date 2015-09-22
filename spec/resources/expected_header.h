/* AUTO-GENERATED. DO NOT ALTER */
#import <FlipTheSwitch/FTSFlipTheSwitch.h>

@interface FTSFlipTheSwitch (Features)
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
