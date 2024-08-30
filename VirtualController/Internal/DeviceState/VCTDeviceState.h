typedef enum
{
    VHIDDeviceTypeMouse,
    VHIDDeviceTypeJoystick
} VHIDDeviceType;

@class VCTDeviceState;
@class VCTButtonCollection;
@class VCTPointerCollection;

@protocol VHIDDeviceDelegate <NSObject>

- (void)VHIDDevice:(VCTDeviceState *)device stateChanged:(NSData *)state;

@end

@interface VCTDeviceState : NSObject
{
@private
    VHIDDeviceType _type;
    VCTButtonCollection *_buttons;
    VCTPointerCollection *_pointers;
    NSData *_descriptor;
    NSMutableData *_state;

    id<VHIDDeviceDelegate> _delegate;
}

+ (NSUInteger)maxButtonCount;
+ (NSUInteger)maxPointerCount;

- (id)initWithType:(VHIDDeviceType)type
      pointerCount:(NSUInteger)pointerCount
       buttonCount:(NSUInteger)buttonCount
        isRelative:(BOOL)isRelative;

- (VHIDDeviceType)type;

- (BOOL)isRelative;
- (NSUInteger)buttonCount;
- (NSUInteger)pointerCount;

- (BOOL)isButtonPressed:(NSUInteger)buttonIndex;
- (void)setButton:(NSUInteger)buttonIndex pressed:(BOOL)pressed;

// [-1, +1] ;)
- (NSPoint)pointerPosition:(NSUInteger)pointerIndex;
- (void)setPointer:(NSUInteger)pointerIndex position:(NSPoint)position;

- (void)reset;

- (NSData *)descriptor;
- (NSData *)state;

@property() id<VHIDDeviceDelegate> delegate;

@end
