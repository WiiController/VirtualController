#import <Foundation/Foundation.h>

@class VHIDDevice;

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSPoint leftStick;
    NSPoint rightStick;
    struct { CGFloat left, right; } triggers;
    // A, B, X, Y, LB, RB, LS, RS, Menu, Share, nothing?, Up, Down, Left, Right, nothing?
    struct { BOOL pressed : 1; } buttons[16];
} VCTDeviceStateXbox360;

@interface VCTDeviceXbox360 : NSObject

- (instancetype)initWithName:(NSString *)name serial:(NSString *)serial;

- (void)setState:(VCTDeviceStateXbox360 *)state;

@property(readonly) VHIDDevice *deviceState;

@end

NS_ASSUME_NONNULL_END
