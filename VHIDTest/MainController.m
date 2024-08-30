//
//  MainController.m
//  VHID
//
//  Created by alxn1 on 24.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import "MainController.h"

@implementation MainController

- (id)init
{
    self = [super init];
    if(self == nil)
        return nil;
    
    _deviceState    = [[VHIDDevice alloc] initWithType:VHIDDeviceTypeJoystick
                                          pointerCount:(2 + 1)
                                           buttonCount:(11 + 15)
                                            isRelative:NO];

    NSLog(@"%@", _deviceState);
    _virtualDevice  = [[VirtualControllerDevice alloc] initWithHIDDescriptor:[_deviceState descriptor]
                                                  productString:@"My custom virtual gamepad"];

    [_deviceState setDelegate:self];
    if(_virtualDevice == nil || _deviceState == nil)
        NSLog(@"error");

    return self;
}

- (void)dealloc
{
    [_deviceState release];
    [_virtualDevice release];
    [super dealloc];
}

- (void)VHIDDevice:(VHIDDevice*)device stateChanged:(NSData*)state
{
    [_virtualDevice updateHIDState:state];
}

- (void)testView:(TestView*)view keyPressed:(TestViewKey)key
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSPoint newPosition = NSZeroPoint;
        
        switch(key)
        {
        case TestViewKeyUp:
            newPosition.y += 0.025f;
            break;
            
        case TestViewKeyDown:
            newPosition.y -= 0.025f;
            break;
            
        case TestViewKeyLeft:
            newPosition.x -= 0.025f;
            break;
            
        case TestViewKeyRight:
            newPosition.x += 0.025f;
            break;
        }
        
        [_deviceState setPointer:0 position:newPosition];
        [_deviceState setButton:key pressed:!!arc4random_uniform(2)];
    });
}

@end
