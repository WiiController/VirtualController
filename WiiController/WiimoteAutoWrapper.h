//
//  WiimoteAutoWrapper.h
//  WJoy
//
//  Created by alxn1 on 27.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import <Wiimote/Wiimote.h>
#import <WirtualJoy/VirtualControllerDevice.h>
#import <VHID/VHIDDevice.h>

#import "ProfileProvider.h"

@interface WiimoteAutoWrapper : NSObject <VHIDDeviceDelegate>

// 0 = infinite, default = infinite, if currently connected too many, disconnect last connected
+ (NSUInteger)maxConnectedDevices;
+ (void)setMaxConnectedDevices:(NSUInteger)count;
+ (void)setProfileProvider:(id<ProfileProvider>)provider;

+ (void)start;

@end
