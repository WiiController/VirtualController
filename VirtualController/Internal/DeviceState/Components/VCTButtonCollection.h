@interface VCTButtonCollection : NSObject

+ (NSUInteger)maxButtonCount;

- (id)initWithButtonCount:(NSUInteger)buttonCount;

- (NSUInteger)buttonCount;

- (BOOL)isButtonPressed:(NSUInteger)buttonIndex;
- (void)setButton:(NSUInteger)buttonIndex pressed:(BOOL)pressed;
- (void)reset;

- (NSData *)descriptor;
- (NSData *)state;

@end
