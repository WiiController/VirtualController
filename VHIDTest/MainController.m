#import "MainController.h"

#import <VirtualController/VCTDeviceXbox360.h>

@implementation MainController
{
    VCTDeviceXbox360 *_device;
}

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    _device = [[VCTDeviceXbox360 alloc] initWithName:@"Virtual Xbox 360" serial:@"3133731337"];
    
    return self;
}

- (void)testView:(TestView*)view keyPressed:(TestViewKey)key
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        static NSPoint newPosition = { 0, 0 };
        
        switch(key)
        {
        case TestViewKeyUp:
            newPosition.y += 0.1;
            break;
            
        case TestViewKeyDown:
            newPosition.y -= 0.1;
            break;
            
        case TestViewKeyLeft:
            newPosition.x -= 0.1;
            break;
            
        case TestViewKeyRight:
            newPosition.x += 0.1;
            break;
        }
        
        static int button = 0;
        
        VCTDeviceStateXbox360 state = (VCTDeviceStateXbox360){
            .leftStick = newPosition,
            .rightStick = newPosition,
            .triggers = { newPosition.x, newPosition.y },
        };
        state.buttons[button].pressed = 1;
        [self->_device setState:&state];
        
        button++;
        button %= 16;
    });
}

@end
