/* AUTO-GENERATED. DO NOT ALTER */
#import "FlipTheSwitch+Features.h"

@implementation FlipTheSwitch (Features)

+ (BOOL)isFirstFeatureEnabled
{
    return [[FlipTheSwitch sharedInstance] isFeatureEnabled:[self firstFeatureKey]];
}

+ (void)enableFirstFeature
{
    [[FlipTheSwitch sharedInstance] enableFeature:[self firstFeatureKey]];
}

+ (void)disableFirstFeature
{
    [[FlipTheSwitch sharedInstance] disableFeature:[self firstFeatureKey]];
}

+ (void)setFirstFeatureEnabled:(BOOL)enabled
{
    [[FlipTheSwitch sharedInstance] setFeature:[self firstFeatureKey] enabled:enabled];
}

+ (void)resetFirstFeature
{
    [[FlipTheSwitch sharedInstance] resetFeature:[self firstFeatureKey]];
}

+ (NSString *)firstFeatureKey
{
    return @"first_feature";
}

+ (BOOL)isSecondFeatureEnabled
{
    return [self isFirstFeatureEnabled] &&
        [[FlipTheSwitch sharedInstance] isFeatureEnabled:[self secondFeatureKey]];
}

+ (void)enableSecondFeature
{
    [[FlipTheSwitch sharedInstance] enableFeature:[self secondFeatureKey]];
}

+ (void)disableSecondFeature
{
    [[FlipTheSwitch sharedInstance] disableFeature:[self secondFeatureKey]];
}

+ (void)setSecondFeatureEnabled:(BOOL)enabled
{
    [[FlipTheSwitch sharedInstance] setFeature:[self secondFeatureKey] enabled:enabled];
}

+ (void)resetSecondFeature
{
    [[FlipTheSwitch sharedInstance] resetFeature:[self secondFeatureKey]];
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
