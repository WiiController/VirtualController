NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSPoint leftStick;
    NSPoint rightStick;
    struct { CGFloat left, right; } triggers;
    
    // 0: Square
    // 1: Cross
    // 2: Circle
    // 3: Triangle
    // 4: L1
    // 5: L2
    // 6: nothing (would be L2, but it's analog; see `triggers`)
    // 7: nothing (would be R2, but it's analog; see `triggers`)
    // 8: Share
    // 9: Options
    // A: L3 (stick press)
    // B: R3 (stick press)
    // C: PS logo button
    // D: touchpad press
    // E: nothing?
    // F: nothing?
    //
    // https://gamepadviewer.net/custom-skin/ps4-white
    struct { BOOL pressed : 1; } buttons[16];
} VCTDeviceStateDualShock4;

@interface VCTDeviceDualShock4 : NSObject

- (instancetype)initWithName:(NSString *)name serial:(NSString *)serial;

- (void)setState:(VCTDeviceStateDualShock4 *)state;

@end

NS_ASSUME_NONNULL_END
