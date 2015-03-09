/* AUTO-GENERATED. DO NOT ALTER */
#import "FlipTheSwitch+Features.h"

@implementation FlipTheSwitch (Features)

+ (BOOL)isFirstFeatureEnabled
{
    return [[FlipTheSwitch sharedInstance] isFeatureEnabled:@"first_feature"];
}

+ (void)enableFirstFeature
{
    [[FlipTheSwitch sharedInstance] enableFeature:@"first_feature"];
}

+ (void)disableFirstFeature
{
    [[FlipTheSwitch sharedInstance] disableFeature:@"first_feature"];
}

+ (void)setFirstFeatureEnabled:(BOOL)enabled
{
    [[FlipTheSwitch sharedInstance] setFeature:@"first_feature" enabled:enabled];
}

+ (void)resetFirstFeature
{
    [[FlipTheSwitch sharedInstance] resetFeature:@"first_feature"];
}

+ (BOOL)isSecondFeatureEnabled
{
    return [[FlipTheSwitch sharedInstance] isFeatureEnabled:@"second_feature"];
}

+ (void)enableSecondFeature
{
    [[FlipTheSwitch sharedInstance] enableFeature:@"second_feature"];
}

+ (void)disableSecondFeature
{
    [[FlipTheSwitch sharedInstance] disableFeature:@"second_feature"];
}

+ (void)setSecondFeatureEnabled:(BOOL)enabled
{
    [[FlipTheSwitch sharedInstance] setFeature:@"second_feature" enabled:enabled];
}

+ (void)resetSecondFeature
{
    [[FlipTheSwitch sharedInstance] resetFeature:@"second_feature"];
}

+ (void)resetAll
{
    [self resetFirstFeature];
    [self resetSecondFeature];
}

@end
