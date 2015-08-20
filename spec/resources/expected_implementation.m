/* AUTO-GENERATED. DO NOT ALTER */
#import "FTSFlipTheSwitch+Features.h"

@implementation FTSFlipTheSwitch (Features)

+ (BOOL)isFirstFeatureEnabled
{
    return [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self firstFeatureKey]];
}

+ (void)enableFirstFeature
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self firstFeatureKey]];
}

+ (void)disableFirstFeature
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self firstFeatureKey]];
}

+ (void)setFirstFeatureEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self firstFeatureKey] enabled:enabled];
}

+ (void)resetFirstFeature
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self firstFeatureKey]];
}

+ (NSString *)firstFeatureKey
{
    return @"first_feature";
}

+ (BOOL)isSecondFeatureEnabled
{
    return [self isFirstFeatureEnabled] &&
        [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self secondFeatureKey]];
}

+ (void)enableSecondFeature
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self secondFeatureKey]];
}

+ (void)disableSecondFeature
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self secondFeatureKey]];
}

+ (void)setSecondFeatureEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self secondFeatureKey] enabled:enabled];
}

+ (void)resetSecondFeature
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self secondFeatureKey]];
}

+ (NSString *)secondFeatureKey
{
    return @"second_feature";
}

+ (void)resetAll
{
    [self resetFirstFeature];
    [self resetSecondFeature];
}

@end
