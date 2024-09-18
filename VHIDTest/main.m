#import <Cocoa/Cocoa.h>

@class VCTDeviceState;

@protocol VHIDDeviceDelegate

- (void)VHIDDevice:(VCTDeviceState*)device stateChanged:(NSData*)state;

@end

@interface VCTDeviceState : NSObject
{
    @private
        NSData                  *_descriptor;
        NSMutableData           *_state;
        id<VHIDDeviceDelegate>   _delegate;
}

- (NSData*)descriptor;
- (NSData*)state;

- (void)reset;

- (id<VHIDDeviceDelegate>)delegate;
- (void)setDelegate:(id<VHIDDeviceDelegate>)obj;

@end

typedef enum VHIDMouseButtonType {
    VHIDMouseButtonTypeLeft,
    VHIDMouseButtonTypeCenter,
    VHIDMouseButtonTypeRight
} VHIDMouseButtonType;

@interface VHIDMouse : VCTDeviceState

- (BOOL)isButtonPressed:(VHIDMouseButtonType)button;
- (void)setButton:(VHIDMouseButtonType)button pressed:(BOOL)pressed;

- (void)updatePosition:(NSPoint)delta;

@end

@interface VHIDKeyboard : VCTDeviceState

@end

typedef enum VHIDJoystickAxisType {
    VHIDJoystickAxisTypeX,
    VHIDJoystickAxisTypeY,
    VHIDJoystickAxisTypeZ,
    VHIDJoystickAxisTypeRX,
    VHIDJoystickAxisTypeRY,
    VHIDJoystickAxisTypeRZ
} VHIDJoystickAxisType;

typedef enum VHIDJoystickAxisValueType {
    VHIDJoystickAxisValueType8Bit,
    VHIDJoystickAxisValueType16Bit
} VHIDJoystickAxisValueType;

@interface VHIDJoystickAxisSet : NSObject

- (NSUInteger)count;
- (BOOL)isContain:(VHIDJoystickAxisType)axis;
- (VHIDJoystickAxisValueType)valueType:(VHIDJoystickAxisType)axis;

@end

@interface VHIDMutableJoystickAxisSet : VHIDJoystickAxisSet

- (void)add:(VHIDJoystickAxisType)axis valueType:(VHIDJoystickAxisValueType)valueType;
- (void)remove:(VHIDJoystickAxisType)axis;

@end

#define VHIDJoystickMaxButtonCount 255

@interface VHIDJoystick : VCTDeviceState

- (id)initWithButtonCount:(NSUInteger)buttonCount
                     axes:(VHIDJoystickAxisSet*)axes;

- (NSUInteger)buttonCount;
- (VHIDJoystickAxisSet*)axes;

- (BOOL)isButtonPressed:(NSUInteger)button;
- (void)setButton:(NSUInteger)button pressed:(BOOL)pressed;

- (CGFloat)axisValue:(VHIDJoystickAxisType)axis;
- (void)setAxis:(VHIDJoystickAxisType)axis value:(CGFloat)value;

@end

int main(int argC, char *argV[])
{
    return NSApplicationMain(argC, (const char**)argV);
}
