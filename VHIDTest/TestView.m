//
//  TestView.m
//  VHID
//
//  Created by alxn1 on 24.07.12.
//  Copyright 2012 alxn1. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return YES;
}

- (BOOL)resignFirstResponder
{
    return NO;
}

- (IBAction)moveRight:(id)sender
{
    [_delegate testView:self keyPressed:TestViewKeyRight];
}

- (IBAction)moveLeft:(id)sender
{
    [_delegate testView:self keyPressed:TestViewKeyLeft];
}

- (IBAction)moveUp:(id)sender
{
    [_delegate testView:self keyPressed:TestViewKeyUp];
}

- (IBAction)moveDown:(id)sender
{
    [_delegate testView:self keyPressed:TestViewKeyDown];
}

- (id<TestViewDelegate>)delegate
{
    return _delegate;
}

- (void)setDelegate:(id<TestViewDelegate>)obj
{
    _delegate = obj;
}

@end
