//
//  VHIDButtonCollection.h
//  VHID
//
//  Created by alxn1 on 23.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VHIDButtonCollection : NSObject
{
@private
    NSUInteger _buttonCount;
    NSData *_descriptor;
    NSMutableData *_state;
}

+ (NSUInteger)maxButtonCount;

- (id)initWithButtonCount:(NSUInteger)buttonCount;

- (NSUInteger)buttonCount;

- (BOOL)isButtonPressed:(NSUInteger)buttonIndex;
- (void)setButton:(NSUInteger)buttonIndex pressed:(BOOL)pressed;
- (void)reset;

- (NSData *)descriptor;
- (NSData *)state;

@end
