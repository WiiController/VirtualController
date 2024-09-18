NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSPoint leftStick;
    NSPoint rightStick;
    struct { CGFloat left, right; } triggers;
    
    // 0: A
    // 1: B
    // 2: X
    // 3: Y
    // 4: LB
    // 5: RB
    // 6: LS
    // 7: RS
    // 8: Start
    // 9: Back
    // A: nothing?
    // B: Up
    // C: Down
    // D: Left
    // E: Right
    // F: nothing?
    //
    // https://gamepadviewer.net/custom-skin/xbox-360
    struct { BOOL pressed : 1; } buttons[16];
} VCTDeviceStateXbox360;

@interface VCTDeviceXbox360 : NSObject

- (instancetype)initWithName:(NSString *)name serial:(NSString *)serial;

- (void)setState:(VCTDeviceStateXbox360 *)state;

@end

NS_ASSUME_NONNULL_END
