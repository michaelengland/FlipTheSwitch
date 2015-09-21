#import "FTSFeature.h"

@implementation FTSFeature

- (instancetype)initWithName:(NSString *)name enabled:(BOOL)enabled featureDescription:(NSString *)featureDescription
{
    self = [super init];
    if (self) {
        NSParameterAssert(name);
        _name = name;
        _featureDescription = featureDescription;
        _enabled = enabled;
    }
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (!other || ![[other class] isEqual:[self class]]) {
        return NO;
    }

    return [self isEqualToFeature:other];
}

- (BOOL)isEqualToFeature:(FTSFeature *)feature
{
    if (self == feature) {
        return YES;
    }
    if (feature == nil) {
        return NO;
    }
    if (self.name != feature.name && ![self.name isEqualToString:feature.name]) {
        return NO;
    }
    if (self.featureDescription != feature.featureDescription && ![self.featureDescription isEqualToString:feature.featureDescription]) {
        return NO;
    }
    if (self.enabled != feature.enabled) {
        return NO;
    }
    return YES;
}

- (NSUInteger)hash
{
    NSUInteger hash = [self.name hash];
    hash = hash * 31u + [self.featureDescription hash];
    hash = hash * 31u + self.enabled;
    return hash;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.name=%@", self.name];
    [description appendFormat:@", self.featureDescription=%@", self.featureDescription];
    [description appendFormat:@", self.enabled=%d", self.enabled];
    [description appendString:@">"];
    return description;
}

@end
