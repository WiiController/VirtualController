//
//  MainController.m
//  WJoy
//
//  Created by alxn1 on 27.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import "MainController.h"
#import "WiimoteAutoWrapper.h"
#import "StatusBarItemController.h"
#import "WiimoteLEDsController.h"

#import <Sparkle/Sparkle.h>

@implementation MainController

- (void)awakeFromNib
{
    [SUUpdater sharedUpdater];
    [WiimoteLEDsController start];
    __auto_type statusBarItemController = [StatusBarItemController start];
    [WiimoteAutoWrapper setMaxConnectedDevices:4];
    [WiimoteAutoWrapper setProfileProvider:statusBarItemController];
    [WiimoteAutoWrapper start];

    [Wiimote beginDiscovery];
}

@end
