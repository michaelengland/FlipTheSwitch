# FlipTheSwitch [![Build Status](https://travis-ci.org/michaelengland/FlipTheSwitch.svg?branch=master)](https://travis-ci.org/michaelengland/FlipTheSwitch) [![Coverage Status](https://img.shields.io/coveralls/michaelengland/FlipTheSwitch.svg)](https://coveralls.io/r/michaelengland/FlipTheSwitch?branch=master) ![version](https://cocoapod-badges.herokuapp.com/v/FlipTheSwitch/badge.png) ![platform](https://cocoapod-badges.herokuapp.com/p/FlipTheSwitch/badge.png)

A feature switching/toggling/flipping library  for ObjectiveC.

# flip_the_switch [![Build Status](https://travis-ci.org/michaelengland/FlipTheSwitch.svg?branch=master)](https://travis-ci.org/michaelengland/FlipTheSwitch) [![Code Climate](https://codeclimate.com/github/michaelengland/FlipTheSwitch.png)](https://codeclimate.com/github/michaelengland/FlipTheSwitch) [![Code Climate](https://codeclimate.com/github/michaelengland/FlipTheSwitch/coverage.png)](https://codeclimate.com/github/michaelengland/FlipTheSwitch) [![Gem Version](https://badge.fury.io/rb/flip-the-switch.svg)](http://badge.fury.io/rb/flip-the-switch)

A gem command line tool for generating the `Features.plist` & `FlipTheSwitch+Features.{h,m}` categories to help with the corresponding Pod.

## The Problem

We have a a new feature we've been working on, `AmazingFeature`, and we've been building it inside a branch.
Now has come the time to finally merge it back in. This then takes us the next day, as the `MyApp.xcodeproj/project.pbxproj` file has a lot of conflicting changes, and we get things wrong a lot before we get them right.
We weren't able to rebase often, as multiple people were working on this branch, and so we also had to keep regularly merging in all of the other changes from the rest of the team, constantly losing focus of our goal.
We finally have it all merged and then... *everything breaks*!

The way to avoid all of these constant merges/rebases/context switches is to always have our code in the `master` branch, but we didn't want to affect the rest of the team while they released `QuickerFeature` in the next release cycle.

How can we get the benefits of working on `master` branch, while still not worrying about breaking the other features while we build `AmazingFeature`?

## Introducing FlipTheSwitch

With FlipTheSwitch, we can choose different code paths at runtime:

```objective-c
self.newFeatureButton.hidden = [[FlipTheSwitch sharedInstance] isFeatureEnabled:@"new_feature"];
```

The features can be enabled/disabled at runtime:

```objective-c
[[FlipTheSwitch sharedInstance] enableFeature:@"new_feature"];
```

```objective-c
[[FlipTheSwitch sharedInstance] disableFeature:@"new_feature"];
```

```objective-c
[[FlipTheSwitch sharedInstance] setFeature:@"new_feature" enabled:YES];
```

All enabled features will persist between app loads through `NSUserDefaults`.

The features can defaulted to enabled/disabled via a plist file `Features.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>enabled_feature</key>
    <true/>
    <key>disabled_feature</key>
    <false/>
</dict>
</plist>
```

## Command-Line-Interface

If you install the gem, you will be able to use the Command-Line-Interface.

The CLI consists of 2 commands:

 - `plist` - creates a `Features.plist` file for enabled/disabled features like that mentioned above.
 - `category` - creates `FlipTheSwitch+Features.{h,m}` files for features, thus giving compile-time checks for adding/removal of new features.
e.g:

```objective-c
/* AUTO-GENERATED. DO NOT ALTER */
#import <FlipTheSwitch/FlipTheSwitch.h>

@interface FlipTheSwitch (Features)

+ (BOOL)isAwesomeFeatureEnabled;
+ (void)enableAwesomeFeature;
+ (void)disableAwesomeFeature;
+ (void)setAwesomeFeatureEnabled:(BOOL)enabled;

@end
```

The features, along with their default enabled/disabled state, are read from a `features.yml` file. e.g.:

```yaml
awesome_feature: Yes
```

For more information, run `flip-the-switch help`

## How to install

Add `pod 'FlipTheSwitch'` to your Podfile

Add `gem 'flip-the-switch'` to your Gemfile

## Authors

  - [Michael England](https://github.com/michaelengland) @ [SoundCloud](https://github.com/soundcloud)
  - [Rob Siwek](https://github.com/nerdsRob) @ [SoundCloud](https://github.com/soundcloud)

## License

FlipTheSwitch is available under the MIT license. See the LICENSE file for more info.
