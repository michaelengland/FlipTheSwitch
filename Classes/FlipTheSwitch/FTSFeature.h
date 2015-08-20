@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface FTSFeature : NSObject
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, nullable) NSString *featureDescription;
@property (nonatomic, readonly) BOOL enabled;

- (id)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name enabled:(BOOL)enabled featureDescription:(NSString *)featureDescription;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToFeature:(FTSFeature *)feature;

- (NSUInteger)hash;

- (NSString *)description;
@end

NS_ASSUME_NONNULL_END
