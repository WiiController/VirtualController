//
//  VirtualControllerDeviceImpl.h
//  driver
//
//  Created by alxn1 on 17.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>

typedef enum
{
    VirtualControllerDeviceMethodSelectorEnable = 0,
    VirtualControllerDeviceMethodSelectorDisable = 1,
    VirtualControllerDeviceMethodSelectorUpdateState = 2,
    VirtualControllerDeviceMethodSelectorSetDeviceProductString = 3,
    VirtualControllerDeviceMethodSelectorSetDeviceSerialNumberString = 4,
    VirtualControllerDeviceMethodSelectorSetDeviceVendorAndProductID = 5
} VirtualControllerDeviceMethodSelector;

@interface VirtualControllerDeviceImpl : NSObject
{
@private
    io_connect_t _connection;
}

+ (BOOL)prepare;

- (BOOL)call:(VirtualControllerDeviceMethodSelector)selector;
- (BOOL)call:(VirtualControllerDeviceMethodSelector)selector data:(NSData*)data;
- (BOOL)call:(VirtualControllerDeviceMethodSelector)selector string:(NSString*)string;

- (BOOL)setDeviceProductString:(NSString*)string;
- (BOOL)setDeviceSerialNumberString:(NSString*)string;
- (BOOL)setDeviceVendorID:(uint32_t)vendorID productID:(uint32_t)productID;

- (BOOL)enable:(NSData*)HIDDescriptor;
- (BOOL)disable;

- (BOOL)updateState:(NSData*)HIDState;

@end
