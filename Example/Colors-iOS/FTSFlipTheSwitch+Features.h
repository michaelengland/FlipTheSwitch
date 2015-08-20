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

+ (void)resetAll;
@end
