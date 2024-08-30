#import <Cocoa/Cocoa.h>

@class TestView;

typedef enum
{
    TestViewKeyUp,
    TestViewKeyDown,
    TestViewKeyLeft,
    TestViewKeyRight
} TestViewKey;

@protocol TestViewDelegate

- (void)testView:(TestView*)view keyPressed:(TestViewKey)key;

@end

@interface TestView : NSView
{
    @private
        id<TestViewDelegate> _delegate;
}

- (id<TestViewDelegate>)delegate;
- (void)setDelegate:(id<TestViewDelegate>)obj;

@end
