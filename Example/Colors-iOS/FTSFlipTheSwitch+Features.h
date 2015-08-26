/* AUTO-GENERATED. DO NOT ALTER */
#import <FlipTheSwitch/FTSFlipTheSwitch.h>

@interface FTSFlipTheSwitch (Features)
// Enable feature switching UI
+ (BOOL)isFeaturesControllerEnabled;
+ (void)enableFeaturesController;
+ (void)disableFeaturesController;
+ (void)setFeaturesControllerEnabled:(BOOL)enabled;
+ (void)resetFeaturesController;
+ (NSString *)featuresControllerKey;

// The color purple
+ (BOOL)isPurpleColorEnabled;
+ (void)enablePurpleColor;
+ (void)disablePurpleColor;
+ (void)setPurpleColorEnabled:(BOOL)enabled;
+ (void)resetPurpleColor;
+ (NSString *)purpleColorKey;

// The color red
+ (BOOL)isRedColorEnabled;
+ (void)enableRedColor;
+ (void)disableRedColor;
+ (void)setRedColorEnabled:(BOOL)enabled;
+ (void)resetRedColor;
+ (NSString *)redColorKey;

+ (BOOL)isNoDescriptionFeatureEnabled;
+ (void)enableNoDescriptionFeature;
+ (void)disableNoDescriptionFeature;
+ (void)setNoDescriptionFeatureEnabled:(BOOL)enabled;
+ (void)resetNoDescriptionFeature;
+ (NSString *)noDescriptionFeatureKey;

// The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother's keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.
+ (BOOL)isLongDescriptionFeatureEnabled;
+ (void)enableLongDescriptionFeature;
+ (void)disableLongDescriptionFeature;
+ (void)setLongDescriptionFeatureEnabled:(BOOL)enabled;
+ (void)resetLongDescriptionFeature;
+ (NSString *)longDescriptionFeatureKey;

+ (void)resetAll;
@end
