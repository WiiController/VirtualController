//
//  VirtualControllerDeviceImpl.m
//  driver
//
//  Created by alxn1 on 17.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import "VirtualControllerDeviceImpl.h"
#import "DextManager.h"

static char const *driverKitDriverUserClass = "ca_igregory_VirtualController";

@implementation VirtualControllerDeviceImpl

+ (BOOL)prepare
{
    return [VirtualControllerDeviceImpl loadDriver];
}

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;

    if (![VirtualControllerDeviceImpl prepare])
    {
        return nil;
    }

    _connection = [VirtualControllerDeviceImpl createNewConnection];
    if (_connection == IO_OBJECT_NULL)
    {
        return nil;
    }

    return self;
}

- (void)dealloc
{
    if (_connection != IO_OBJECT_NULL)
        IOServiceClose(_connection);
}

- (BOOL)call:(VirtualControllerDeviceMethodSelector)selector
{
    return [self call:selector data:nil];
}

- (BOOL)call:(VirtualControllerDeviceMethodSelector)selector data:(NSData *)data
{
    return (IOConnectCallMethod(_connection, selector, NULL, 0, [data bytes], [data length], NULL, NULL, NULL, NULL) == KERN_SUCCESS);
}

- (BOOL)call:(VirtualControllerDeviceMethodSelector)selector string:(NSString *)string
{
    const char *data = [string UTF8String];
    size_t size = strlen(data) + 1; // zero-terminator

    return [self call:selector data:[NSData dataWithBytes:data length:size]];
}

- (BOOL)setDeviceProductString:(NSString *)string
{
    return [self call:VirtualControllerDeviceMethodSelectorSetDeviceProductString string:string];
}

- (BOOL)setDeviceSerialNumberString:(NSString *)string
{
    return [self call:VirtualControllerDeviceMethodSelectorSetDeviceSerialNumberString string:string];
}

- (BOOL)setDeviceVendorID:(uint32_t)vendorID productID:(uint32_t)productID
{
    char data[sizeof(uint32_t) * 2] = { 0 };

    memcpy(data, &vendorID, sizeof(uint32_t));
    memcpy(data + sizeof(uint32_t), &productID, sizeof(uint32_t));

    return [self call:VirtualControllerDeviceMethodSelectorSetDeviceVendorAndProductID
                 data:[NSData dataWithBytes:data length:sizeof(data)]];
}

- (BOOL)enable:(NSData *)HIDDescriptor
{
    return [self call:VirtualControllerDeviceMethodSelectorEnable data:HIDDescriptor];
}

- (BOOL)disable
{
    return [self call:VirtualControllerDeviceMethodSelectorDisable];
}

- (BOOL)updateState:(NSData *)HIDState
{
    return [self call:VirtualControllerDeviceMethodSelectorUpdateState data:HIDState];
}

+ (io_service_t)findService
{
    return IOServiceGetMatchingService(
        kIOMasterPortDefault,
        IOServiceNameMatching(driverKitDriverUserClass)
    );
}

+ (io_connect_t)createNewConnection
{
    io_connect_t result = IO_OBJECT_NULL;
    io_service_t service = [VirtualControllerDeviceImpl findService];

    if (service == IO_OBJECT_NULL)
        return result;

    __auto_type ret = IOServiceOpen(service, mach_task_self(), 0, &result);
    if (ret != KERN_SUCCESS)
        result = IO_OBJECT_NULL;

    IOObjectRelease(service);
    return result;
}

+ (BOOL)isDriverLoaded
{
    io_service_t service = [VirtualControllerDeviceImpl findService];
    BOOL result = (service != IO_OBJECT_NULL);

    IOObjectRelease(service);
    return result;
}

+ (BOOL)loadDriver
{
    if ([self isDriverLoaded]) return YES;
    return [DextManager loadDriver];
}

@end
