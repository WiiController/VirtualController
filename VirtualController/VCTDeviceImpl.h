typedef enum
{
    VCTDeviceMethodSelectorEnable = 0,
    VCTDeviceMethodSelectorDisable = 1,
    VCTDeviceMethodSelectorUpdateState = 2,
    VCTDeviceMethodSelectorSetDeviceProductString = 3,
    VCTDeviceMethodSelectorSetDeviceSerialNumberString = 4,
    VCTDeviceMethodSelectorSetDeviceVendorAndProductID = 5
} VCTDeviceMethodSelector;

@interface VCTDeviceImpl : NSObject
{
@private
    io_connect_t _connection;
}

+ (BOOL)prepare;

- (BOOL)call:(VCTDeviceMethodSelector)selector;
- (BOOL)call:(VCTDeviceMethodSelector)selector data:(NSData*)data;
- (BOOL)call:(VCTDeviceMethodSelector)selector string:(NSString*)string;

- (BOOL)setDeviceProductString:(NSString*)string;
- (BOOL)setDeviceSerialNumberString:(NSString*)string;
- (BOOL)setDeviceVendorID:(uint32_t)vendorID productID:(uint32_t)productID;

- (BOOL)enable:(NSData*)HIDDescriptor;
- (BOOL)disable;

- (BOOL)updateState:(NSData*)HIDState;

@end
