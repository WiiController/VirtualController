//
//  VirtualControllerDevice.h
//  driver
//
//  Created by alxn1 on 17.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VirtualControllerDeviceImpl;

FOUNDATION_EXTERN NSString *VirtualControllerDeviceVendorIDKey; // NSNumber (NSUInteger as uint32_t)
FOUNDATION_EXTERN NSString *VirtualControllerDeviceProductIDKey; // NSNumber (NSUInteger as uint32_t)
FOUNDATION_EXTERN NSString *VirtualControllerDeviceProductStringKey; // NSString
FOUNDATION_EXTERN NSString *VirtualControllerDeviceSerialNumberStringKey; // NSString

@interface VirtualControllerDevice : NSObject
{
@private
    VirtualControllerDeviceImpl *_impl;
    NSDictionary *_properties;
}

+ (BOOL)prepare;

- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor;
- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor productString:(NSString *)productString;
- (id)initWithHIDDescriptor:(NSData *)HIDDescriptor properties:(NSDictionary *)properties;

- (NSDictionary *)properties;

- (BOOL)updateHIDState:(NSData *)HIDState;

@end
