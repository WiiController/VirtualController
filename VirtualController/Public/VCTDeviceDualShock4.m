#import "VCTDeviceDualShock4.h"

#import "VCTDeviceState.h"
#import "VCTDevice.h"

#import <os/log.h>

@interface VCTDeviceDualShock4 () <VHIDDeviceDelegate>

@property() VCTDeviceState *deviceState;
@property() VCTDevice *device;

@end

@implementation VCTDeviceDualShock4

- (instancetype)initWithName:(NSString *)name serial:(NSString *)serial
{
    self = [super init];
    if (!self) return nil;
    
    _deviceState = [[VCTDeviceState alloc] initWithType:VHIDDeviceTypeJoystick
                                       pointerCount:3
                                        buttonCount:26
                                         isRelative:NO];
    _deviceState.delegate = self;
    
    _device = [[VCTDevice alloc] initWithHIDDescriptor:_deviceState.descriptor properties:@{
        // https://github.com/nefarius/ViGEmBus/blob/d986e1d93708ec9b11049542fa6027272cce716c/sys/Ds4Pdo.hpp#L70
        VCTDeviceVendorIDKey: @(0x054C),
        VCTDeviceProductIDKey: @(0x05C4),
        VCTDeviceProductStringKey: name,
        VCTDeviceSerialNumberStringKey: serial
    }];
    if (!_device) {
        os_log_with_type(
            OS_LOG_DEFAULT,
            OS_LOG_TYPE_ERROR,
            "Failed to create virtual controller device; the required dext might be unavailable"
        );
        return nil;
    }
    
    return self;
}

- (void)setState:(VCTDeviceStateDualShock4 *)state
{
    [_deviceState setPointer:0 position:state->leftStick];
    [_deviceState setPointer:1 position:NSMakePoint(state->rightStick.x, -state->triggers.left)];
    [_deviceState setPointer:2 position:NSMakePoint(state->triggers.right, state->rightStick.y)];
    
    for (int i = 0; i < sizeof state->buttons / sizeof state->buttons[0]; ++i) {
        [_deviceState setButton:i pressed:state->buttons[i].pressed];
    }
}

- (void)VHIDDevice:(VCTDeviceState*)device stateChanged:(NSData*)state
{
    [_device updateHIDState:state];
}

@end
