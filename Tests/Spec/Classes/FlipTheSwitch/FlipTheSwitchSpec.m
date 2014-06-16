#import "FlipTheSwitch.h"

@interface FlipTheSwitch (Spec)
- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
                              bundle:(NSBundle *)bundle;
@end

SpecBegin(FlipTheSwitch)
    __block FlipTheSwitch *subject;

    __block NSUserDefaults *userDefaults;

    __block NSString *standardFeature;
    __block NSString *plistEnabledFeature;

    before(^{
        userDefaults = [[NSUserDefaults alloc] init];

        standardFeature = @"standard_feature";
        plistEnabledFeature = @"plist_enabled_feature";

        subject = [[FlipTheSwitch alloc] initWithUserDefaults:userDefaults
                                                       bundle:[NSBundle bundleForClass:[self class]]];
    });

    after(^{
        for (NSString *key in [userDefaults dictionaryRepresentation]) {
            [userDefaults removeObjectForKey:key];
        }
        [userDefaults synchronize];
    });

    it(@"is a singleton", ^{
        expect([FlipTheSwitch sharedInstance]).to.beIdenticalTo([FlipTheSwitch sharedInstance]);
    });

    context(@"when feature is NOT set", ^{
        context(@"when feature defaults to enabled through plist", ^{
            it(@"is enabled", ^{
                expect([subject isFeatureEnabled:plistEnabledFeature]).to.beTruthy();
            });
        });

        context(@"when feature does not default to enabled through plist", ^{
            it(@"is disabled", ^{
                expect([subject isFeatureEnabled:standardFeature]).to.beFalsy();
            });
        });
    });

    context(@"when feature is manually enabled", ^{
        before(^{
            [subject enableFeature:standardFeature];
            [subject enableFeature:plistEnabledFeature];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:standardFeature]).to.beTruthy();
            expect([subject isFeatureEnabled:plistEnabledFeature]).to.beTruthy();
        });
    });

    context(@"when feature is manually enabled", ^{
        before(^{
            [subject enableFeature:standardFeature];
            [subject enableFeature:plistEnabledFeature];
            [subject disableFeature:standardFeature];
            [subject disableFeature:plistEnabledFeature];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:standardFeature]).to.beFalsy();
            expect([subject isFeatureEnabled:plistEnabledFeature]).to.beFalsy();
        });
    });

    context(@"when feature is manually set", ^{
        before(^{
            [subject setFeature:standardFeature enabled:YES];
            [subject setFeature:plistEnabledFeature enabled:YES];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:standardFeature]).to.beTruthy();
            expect([subject isFeatureEnabled:plistEnabledFeature]).to.beTruthy();
        });
    });
SpecEnd
