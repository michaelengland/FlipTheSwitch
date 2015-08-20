#import "FTSFlipTheSwitch.h"
#import "FTSFeature.h"

@interface FTSFlipTheSwitch (Spec)
- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults
                              bundle:(NSBundle *)bundle
                  notificationCenter:(NSNotificationCenter *)notificationCenter;
@end

SpecBegin(FlipTheSwitch)
    __block FTSFlipTheSwitch *subject;

    __block NSUserDefaults *userDefaults;

    __block NSString *standardFeatureName;
    __block NSString *plistEnabledFeatureName;

    before(^{
        userDefaults = [[NSUserDefaults alloc] init];
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

        standardFeatureName = @"standard_feature";
        plistEnabledFeatureName = @"plist_enabled_feature";

        subject = [[FTSFlipTheSwitch alloc] initWithUserDefaults:userDefaults
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
        expect([FTSFlipTheSwitch sharedInstance]).to.beIdenticalTo([FTSFlipTheSwitch sharedInstance]);
    });

    it(@"returns a list of all features with their states", ^{
        FTSFeature *plistEnabledFeature = [[FTSFeature alloc] initWithName:@"plist_enabled_feature"
                                                                   enabled:YES
                                                        featureDescription:@"ein geiles Feature"];
        expect([subject features]).to.equal(@[ plistEnabledFeature ]);
    });

    context(@"when feature is NOT set", ^{
        context(@"when feature defaults to enabled through plist", ^{
            it(@"is enabled", ^{
                expect([subject isFeatureEnabled:plistEnabledFeatureName]).to.beTruthy();
            });
        });

        context(@"when feature does not default to enabled through plist", ^{
            it(@"is disabled", ^{
                expect([subject isFeatureEnabled:standardFeatureName]).to.beFalsy();
            });
        });
    });

    context(@"when feature is manually enabled", ^{
        before(^{
            [subject enableFeature:standardFeatureName];
            [subject enableFeature:plistEnabledFeatureName];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:standardFeatureName]).to.beTruthy();
            expect([subject isFeatureEnabled:plistEnabledFeatureName]).to.beTruthy();
        });
    });

    context(@"when feature is manually disabled", ^{
        before(^{
            [subject enableFeature:standardFeatureName];
            [subject enableFeature:plistEnabledFeatureName];
            [subject disableFeature:standardFeatureName];
            [subject disableFeature:plistEnabledFeatureName];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:standardFeatureName]).to.beFalsy();
            expect([subject isFeatureEnabled:plistEnabledFeatureName]).to.beFalsy();
        });
    });

    context(@"when feature is manually set", ^{
        before(^{
            [subject setFeature:standardFeatureName enabled:YES];
            [subject setFeature:plistEnabledFeatureName enabled:YES];
        });

        it(@"is enabled", ^{
            expect([subject isFeatureEnabled:standardFeatureName]).to.beTruthy();
            expect([subject isFeatureEnabled:plistEnabledFeatureName]).to.beTruthy();
        });
    });

    context(@"when feature is reset", ^{
        before(^{
            [subject enableFeature:standardFeatureName];
            [subject enableFeature:plistEnabledFeatureName];
            [subject resetFeature:standardFeatureName];
            [subject resetFeature:plistEnabledFeatureName];
        });

        it(@"is in their original state (plist or false)", ^{
            expect([subject isFeatureEnabled:standardFeatureName]).to.beFalsy();
            expect([subject isFeatureEnabled:plistEnabledFeatureName]).to.beTruthy();
        });

        it(@"sends a notification about the change", ^{
            NSNotification *notification = [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                                                         object:subject
                                                                       userInfo:@{
                                                                               FTSFeatureStatusChangedNotificationFeatureKey : standardFeatureName,
                                                                               FTSFeatureStatusChangedNotificationEnabledKey : @NO
                                                                       }];
            expect(^{ [subject resetFeature:standardFeatureName]; }).to.notify(notification);
        });
    });

    describe(@"notifications", ^{
        context(@"when feature already enabled", ^{
            before(^{
                [subject setFeature:standardFeatureName enabled:YES];
            });

            context(@"when feature re-enabled", ^{
                it(@"does nothing", ^{
                    expect(^{ [subject setFeature:standardFeatureName enabled:YES]; }).toNot.notify(FTSFeatureStatusChangedNotification);
                });
            });

            context(@"when feature disabled", ^{
                it(@"sends a notification about the change", ^{
                    NSNotification *enabledNotification = [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                                                                        object:subject
                                                                                      userInfo:@{
                                                                                          FTSFeatureStatusChangedNotificationFeatureKey : standardFeatureName,
                                                                                          FTSFeatureStatusChangedNotificationEnabledKey : @NO
                                                                                      }];
                    expect(^{ [subject setFeature:standardFeatureName enabled:NO]; }).to.notify(enabledNotification);
                });
            });
        });

        context(@"when feature already disabled", ^{
            before(^{
                [subject setFeature:standardFeatureName enabled:NO];
            });

            context(@"when feature re-disabled", ^{
                it(@"does nothing", ^{
                    expect(^{ [subject setFeature:standardFeatureName enabled:NO]; }).toNot.notify(FTSFeatureStatusChangedNotification);
                });
            });

            context(@"when feature enabled", ^{
                it(@"sends a notification about the change", ^{
                    NSNotification *enabledNotification = [NSNotification notificationWithName:FTSFeatureStatusChangedNotification
                                                                                        object:subject
                                                                                      userInfo:@{
                                                                                          FTSFeatureStatusChangedNotificationFeatureKey : standardFeatureName,
                                                                                          FTSFeatureStatusChangedNotificationEnabledKey : @YES
                                                                                      }];
                    expect(^{ [subject setFeature:standardFeatureName enabled:YES]; }).to.notify(enabledNotification);
                });

            });
        });
    });

    describe(@"specifying plist files", ^{
        context(@"when no name is specified", ^{
            it(@"defaults to Features.plist", ^{
                expect([subject isFeatureEnabled:plistEnabledFeatureName]).to.beTruthy();
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
