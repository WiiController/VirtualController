FOUNDATION_EXTERN NSString *VCTDeviceVendorIDKey; // NSNumber (NSUInteger as uint32_t)
FOUNDATION_EXTERN NSString *VCTDeviceProductIDKey; // NSNumber (NSUInteger as uint32_t)
FOUNDATION_EXTERN NSString *VCTDeviceProductStringKey; // NSString
FOUNDATION_EXTERN NSString *VCTDeviceSerialNumberStringKey; // NSString

@interface VCTDevice : NSObject

+ (BOOL)prepare;

- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor;
- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor productString:(NSString *)productString;
- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor properties:(NSDictionary *)properties;

- (BOOL)updateHIDState:(NSData *)HIDState;

@end
