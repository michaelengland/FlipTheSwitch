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

+ (BOOL)isNoDescriptionFeatureEnabled
{
    return [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self noDescriptionFeatureKey]];
}

+ (void)enableNoDescriptionFeature
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self noDescriptionFeatureKey]];
}

+ (void)disableNoDescriptionFeature
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self noDescriptionFeatureKey]];
}

+ (void)setNoDescriptionFeatureEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self noDescriptionFeatureKey] enabled:enabled];
}

+ (void)resetNoDescriptionFeature
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self noDescriptionFeatureKey]];
}

+ (NSString *)noDescriptionFeatureKey
{
    return @"no_description_feature";
}

+ (BOOL)isLongDescriptionFeatureEnabled
{
    return [[FTSFlipTheSwitch sharedInstance] isFeatureEnabled:[self longDescriptionFeatureKey]];
}

+ (void)enableLongDescriptionFeature
{
    [[FTSFlipTheSwitch sharedInstance] enableFeature:[self longDescriptionFeatureKey]];
}

+ (void)disableLongDescriptionFeature
{
    [[FTSFlipTheSwitch sharedInstance] disableFeature:[self longDescriptionFeatureKey]];
}

+ (void)setLongDescriptionFeatureEnabled:(BOOL)enabled
{
    [[FTSFlipTheSwitch sharedInstance] setFeature:[self longDescriptionFeatureKey] enabled:enabled];
}

+ (void)resetLongDescriptionFeature
{
    [[FTSFlipTheSwitch sharedInstance] resetFeature:[self longDescriptionFeatureKey]];
}

+ (NSString *)longDescriptionFeatureKey
{
    return @"long_description_feature";
}

+ (void)resetAll
{
    [self resetFeaturesController];
    [self resetPurpleColor];
    [self resetRedColor];
    [self resetNoDescriptionFeature];
    [self resetLongDescriptionFeature];
}

@end
