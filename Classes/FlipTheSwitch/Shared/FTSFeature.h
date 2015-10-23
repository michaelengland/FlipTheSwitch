@import Foundation;

@interface FTSFeature : NSObject
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *featureDescription;
@property (nonatomic, readonly) BOOL enabled;

- (id)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name enabled:(BOOL)enabled featureDescription:(NSString *)featureDescription;

@end
