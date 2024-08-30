#import "VCTDeviceXbox360.h"

#import "VHIDDevice.h"
#import "VirtualControllerDevice.h"

#import <os/log.h>

@interface VCTDeviceXbox360 () <VHIDDeviceDelegate>

@property() VHIDDevice *deviceState;
@property() VirtualControllerDevice *device;

@end

@implementation VCTDeviceXbox360

- (instancetype)initWithName:(NSString *)name serial:(NSString *)serial
{
    self = [super init];
    if (!self) return nil;
    
    _deviceState = [[VHIDDevice alloc] initWithType:VHIDDeviceTypeJoystick
                                       pointerCount:3
                                        buttonCount:26
                                         isRelative:NO];
    _deviceState.delegate = self;
    
    _device = [[VirtualControllerDevice alloc] initWithHIDDescriptor:_deviceState.descriptor properties:@{
        VirtualControllerDeviceVendorIDKey: @(0x045E),
        VirtualControllerDeviceProductIDKey: @(0x028E),
        VirtualControllerDeviceProductStringKey: name,
        VirtualControllerDeviceSerialNumberStringKey: serial
    }];
    if (!_device) {
        os_log_with_type(
            OS_LOG_DEFAULT,
            OS_LOG_TYPE_ERROR,
            "Failed to create virtual controller device; the required dext might be unavailable"
        );
        return nil;
    }
    
    [_deviceState setPointer:0 position:NSMakePoint(0.5, 0.5)];
    
    return self;
}

- (void)setState:(VCTDeviceStateXbox360 *)state
{
    [_deviceState setPointer:0 position:state->leftStick];
    [_deviceState setPointer:1 position:NSMakePoint(state->triggers.left, -state->rightStick.x)];
    [_deviceState setPointer:2 position:NSMakePoint(-state->rightStick.y, -state->triggers.right)];
    
    for (int i = 0; i < sizeof state->buttons / sizeof state->buttons[0]; ++i) {
        [_deviceState setButton:i pressed:state->buttons[i].pressed];
    }
}

- (void)VHIDDevice:(VHIDDevice*)device stateChanged:(NSData*)state
{
    [_device updateHIDState:state];
}

@end
