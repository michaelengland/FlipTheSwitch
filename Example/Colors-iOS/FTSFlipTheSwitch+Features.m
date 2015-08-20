/* AUTO-GENERATED. DO NOT ALTER */
#import "FTSFlipTheSwitch+Features.h"

@implementation FTSFlipTheSwitch (Features)

+ (BOOL)isFeaturesControllerEnabled
{
    return [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self featuresControllerKey]];
}

+ (void)enableFeaturesController
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self featuresControllerKey]];
}

+ (void)disableFeaturesController
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self featuresControllerKey]];
}

+ (void)setFeaturesControllerEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self featuresControllerKey] enabled:enabled];
}

+ (void)resetFeaturesController
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self featuresControllerKey]];
}

+ (NSString *)featuresControllerKey
{
    return @"features_controller";
}

+ (BOOL)isPurpleColorEnabled
{
    return [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self purpleColorKey]];
}

+ (void)enablePurpleColor
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self purpleColorKey]];
}

+ (void)disablePurpleColor
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self purpleColorKey]];
}

+ (void)setPurpleColorEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self purpleColorKey] enabled:enabled];
}

+ (void)resetPurpleColor
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self purpleColorKey]];
}

+ (NSString *)purpleColorKey
{
    return @"purple_color";
}

+ (BOOL)isRedColorEnabled
{
    return [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self redColorKey]];
}

+ (void)enableRedColor
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self redColorKey]];
}

+ (void)disableRedColor
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self redColorKey]];
}

+ (void)setRedColorEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self redColorKey] enabled:enabled];
}

+ (void)resetRedColor
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self redColorKey]];
}

+ (NSString *)redColorKey
{
    return @"red_color";
}

+ (void)resetAll
{
    [self resetFeaturesController];
    [self resetPurpleColor];
    [self resetRedColor];
}

@end
