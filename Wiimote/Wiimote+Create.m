//
//  Wiimote+Create.m
//  Wiimote
//
//  Created by alxn1 on 30.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import "Wiimote+Create.h"
#import "Wiimote+Tracking.h"
#import "Wiimote+PlugIn.h"

#import "WiimoteDevice.h"

#import "WiimoteIRPart.h"
#import "WiimoteLEDPart.h"
#import "WiimoteButtonPart.h"
#import "WiimoteBatteryPart.h"
#import "WiimoteVibrationPart.h"
#import "WiimoteAccelerometerPart.h"
#import "WiimoteExtensionPart.h"

#import "WiimotePartSet.h"

@interface Wiimote (WiimoteDeviceDelegate)

- (void)wiimoteDevice:(WiimoteDevice*)device handleReport:(WiimoteDeviceReport*)report;
- (void)wiimoteDeviceDisconnected:(WiimoteDevice*)device;

@end

@implementation Wiimote (Create)

- (void)initParts
{
    m_IRPart            = (WiimoteIRPart*)              [self partWithClass:[WiimoteIRPart class]];
    m_LEDPart           = (WiimoteLEDPart*)             [self partWithClass:[WiimoteLEDPart class]];
    m_ButtonPart        = (WiimoteButtonPart*)          [self partWithClass:[WiimoteButtonPart class]];
    m_BatteryPart       = (WiimoteBatteryPart*)         [self partWithClass:[WiimoteBatteryPart class]];
    m_VibrationPart     = (WiimoteVibrationPart*)       [self partWithClass:[WiimoteVibrationPart class]];
    m_AccelerometerPart = (WiimoteAccelerometerPart*)   [self partWithClass:[WiimoteAccelerometerPart class]];
    m_ExtensionPart     = (WiimoteExtensionPart*)       [self partWithClass:[WiimoteExtensionPart class]];

    [m_LEDPart setDevice:m_Device];
	[m_VibrationPart setDevice:m_Device];
}

- (id)initWithWiimoteDevice:(WiimoteDevice*)device
{
    self = [super init];
    if(self == nil)
        return nil;

    m_Device    = device;
    m_PartSet   = [[WiimotePartSet alloc] initWithOwner:self device:m_Device];
    m_ModelName = [[device name] copy];

    if(m_Device == nil || ![m_Device connect])
    {
        return nil;
    }

	[m_Device setDelegate:self];

	[self initParts];
    [self requestUpdateState];
    [self deviceConfigurationChanged];

    [Wiimote wiimoteConnected:self];
	[[m_PartSet eventDispatcher] postConnectedNotification];

	[m_PartSet performSelector:@selector(connected)
					withObject:nil
					afterDelay:0.0];

    return self;
}

- (id)initWithHIDDevice:(W_HIDDevice*)device
{
    return [self initWithWiimoteDevice:
                        [[WiimoteDevice alloc]
                                    initWithHIDDevice:device]];
}

- (id)initWithBluetoothDevice:(IOBluetoothDevice*)device
{
    return [self initWithWiimoteDevice:
                        [[WiimoteDevice alloc]
                                    initWithBluetoothDevice:device]];
}

- (void)dealloc
{
    [m_Device disconnect];
}

+ (void)connectToHIDDevice:(W_HIDDevice*)device
{
    (void)[[Wiimote alloc] initWithHIDDevice:device];
}

+ (void)connectToBluetoothDevice:(IOBluetoothDevice*)device
{
    (void)[[Wiimote alloc] initWithBluetoothDevice:device];
}

- (id)lowLevelDevice
{
    return [m_Device lowLevelDevice];
}

@end

@implementation Wiimote (WiimoteDeviceDelegate)

- (void)wiimoteDevice:(WiimoteDevice*)device handleReport:(WiimoteDeviceReport*)report
{
	[m_PartSet handleReport:report];
}

- (void)wiimoteDeviceDisconnected:(WiimoteDevice*)device
{
	[m_PartSet disconnected];
    [Wiimote wiimoteDisconnected:self];
	[[m_PartSet eventDispatcher] postDisconnectNotification];
}

@end
