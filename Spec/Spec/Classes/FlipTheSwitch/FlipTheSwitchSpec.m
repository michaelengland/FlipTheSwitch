#import "FlipTheSwitch.h"

@interface FlipTheSwitch (Spec)
- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults;
@end

SpecBegin(FlipTheSwitch)
    __block FlipTheSwitch *subject;

    __block NSUserDefaults *userDefaults;
    __block NSString *feature;

    before(^{
        userDefaults = [[NSUserDefaults alloc] init];
        feature = @"feature";

        subject = [[FlipTheSwitch alloc] initWithUserDefaults:userDefaults];
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
        it(@"is disabled", ^{
            expect([subject isFeatureEnabled:feature]).to.beFalsy();
        });
    });

    context(@"when feature is manually enabled", ^{
        before(^{
            [subject enableFeature:feature];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:feature]).to.beTruthy();
        });
    });

    context(@"when feature is manually enabled", ^{
        before(^{
            [subject enableFeature:feature];
            [subject disableFeature:feature];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:feature]).to.beFalsy();
        });
    });

    context(@"when feature is manually set", ^{
        before(^{
            [subject setFeature:feature enabled:YES];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:feature]).to.beTruthy();
        });
    });
SpecEnd
