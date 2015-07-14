#import "FlipTheSwitch.h"

@interface FlipTheSwitch (Spec)
- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
                              bundle:(NSBundle *)bundle
                  notificationCenter:(NSNotificationCenter *)notificationCenter;
@end

SpecBegin(FlipTheSwitch)
    __block FlipTheSwitch *subject;

    __block NSUserDefaults *userDefaults;

    __block NSString *standardFeature;
    __block NSString *plistEnabledFeature;

    before(^{
        userDefaults = [[NSUserDefaults alloc] init];
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

        standardFeature = @"standard_feature";
        plistEnabledFeature = @"plist_enabled_feature";

        subject = [[FlipTheSwitch alloc] initWithUserDefaults:userDefaults
                                                       bundle:bundle
                                           notificationCenter:notificationCenter];
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

    context(@"when feature is manually disabled", ^{
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

    context(@"when feature is reset", ^{
        before(^{
            [subject enableFeature:standardFeature];
            [subject enableFeature:plistEnabledFeature];
            [subject resetFeature:standardFeature];
            [subject resetFeature:plistEnabledFeature];
        });

        it(@"is in their original state (plist or false)", ^{
            expect([subject isFeatureEnabled:standardFeature]).to.beFalsy();
            expect([subject isFeatureEnabled:plistEnabledFeature]).to.beTruthy();
        });

        it(@"sends a notification about the change", ^{
            NSNotification *notification = [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                                                         object:subject
                                                                       userInfo:@{
                                                                               FTSFeatureStatusChangedNotificationFeatureKey : standardFeature,
                                                                               FTSFeatureStatusChangedNotificationEnabledKey : @NO
                                                                       }];
            expect(^{ [subject resetFeature:standardFeature]; }).to.notify(notification);
        });
    });

    describe(@"notifications", ^{
        context(@"when feature already enabled", ^{
            before(^{
                [subject setFeature:standardFeature enabled:YES];
            });

            context(@"when feature re-enabled", ^{
                it(@"does nothing", ^{
                    expect(^{ [subject setFeature:standardFeature enabled:YES]; }).toNot.notify(FTSFeatureStatusChangedNotification);
                });
            });

            context(@"when feature disabled", ^{
                it(@"sends a notification about the change", ^{
                    NSNotification *enabledNotification = [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                                                                        object:subject
                                                                                      userInfo:@{
                                                                                          FTSFeatureStatusChangedNotificationFeatureKey : standardFeature,
                                                                                          FTSFeatureStatusChangedNotificationEnabledKey : @NO
                                                                                      }];
                    expect(^{ [subject setFeature:standardFeature enabled:NO]; }).to.notify(enabledNotification);
                });
            });
        });

        context(@"when feature already disabled", ^{
            before(^{
                [subject setFeature:standardFeature enabled:NO];
            });

            context(@"when feature re-disabled", ^{
                it(@"does nothing", ^{
                    expect(^{ [subject setFeature:standardFeature enabled:NO]; }).toNot.notify(FTSFeatureStatusChangedNotification);
                });
            });

            context(@"when feature enabled", ^{
                it(@"sends a notification about the change", ^{
                    NSNotification *enabledNotification = [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                                                                        object:subject
                                                                                      userInfo:@{
                                                                                          FTSFeatureStatusChangedNotificationFeatureKey : standardFeature,
                                                                                          FTSFeatureStatusChangedNotificationEnabledKey : @YES
                                                                                      }];
                    expect(^{ [subject setFeature:standardFeature enabled:YES]; }).to.notify(enabledNotification);
                });

            });
        });
    });

    describe(@"specifying plist files", ^{
        context(@"when no name is specified", ^{
            it(@"defaults to Features.plist", ^{
                expect([subject isFeatureEnabled:plistEnabledFeature]).to.beTruthy();
            });
        });

        context(@"when a custom plist name is specified", ^{
            before(^{
                [userDefaults setObject:@"OtherFeatures" forKey:FTSFeaturePlistNameKey];
            });

            it(@"uses the settings from that plist", ^{
                expect([subject isFeatureEnabled:@"other_feature"]).to.beTruthy();
            });
        });
    });

SpecEnd
