#import "VCTDevice.h"

#import "VCTDeviceImpl.h"

NSString *VCTDeviceVendorIDKey = @"VirtualControllerDeviceVendorIDKey";
NSString *VCTDeviceProductIDKey = @"VirtualControllerDeviceProductIDKey";
NSString *VCTDeviceProductStringKey = @"VirtualControllerDeviceProductStringKey";
NSString *VCTDeviceSerialNumberStringKey = @"VCTDeviceSerialNumberStringKey";

@implementation VCTDevice
{
    VCTDeviceImpl *_impl;
}

+ (BOOL)prepare
{
    return [VCTDeviceImpl prepare];
}

- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor
{
    return [self initWithHIDDescriptor:HIDDescriptor properties:nil];
}

- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor productString:(NSString *)productString
{
    NSDictionary *properties = @{ VCTDeviceProductStringKey : productString };

    return [self initWithHIDDescriptor:HIDDescriptor properties:properties];
}

- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor properties:(NSDictionary *)properties
{
    self = [super init];
    if (self == nil)
        return nil;

    uint32_t vendorID = [[properties objectForKey:VCTDeviceVendorIDKey] unsignedIntValue];
    uint32_t productID = [[properties objectForKey:VCTDeviceProductIDKey] unsignedIntValue];
    NSString *productString = [properties objectForKey:VCTDeviceProductStringKey];
    NSString *serialNumberString = [properties objectForKey:VCTDeviceSerialNumberStringKey];

    _impl = [[VCTDeviceImpl alloc] init];
    if (_impl == nil)
    {
        return nil;
    }

    if (productString != nil)
        [_impl setDeviceProductString:productString];

    if (serialNumberString != nil)
        [_impl setDeviceSerialNumberString:serialNumberString];

    if (vendorID != 0 || productID != 0)
        [_impl setDeviceVendorID:vendorID productID:productID];

    if (![_impl enable:HIDDescriptor])
    {
        return nil;
    }

    return self;
}

- (BOOL)updateHIDState:(NSData *)HIDState
{
    return [_impl updateState:HIDState];
}

@end
