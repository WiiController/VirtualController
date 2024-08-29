//
//  Service.cpp
//  virtualcontroller
//

#include <os/log.h>

#include <DriverKit/IOUserServer.h>
#include <DriverKit/IOUserClient.h>
#include <DriverKit/IOLib.h>

#include "ca_igregory_VirtualController.h"

kern_return_t
IMPL(ca_igregory_VirtualController, Start)
{
    kern_return_t ret;
    ret = Start(provider, SUPERDISPATCH);
    os_log(OS_LOG_DEFAULT, "HELLO BRUDDY");
    if (ret != kIOReturnSuccess) return ret;
    
    RegisterService();
    
    return kIOReturnSuccess;
}

kern_return_t
IMPL(ca_igregory_VirtualController, NewUserClient)
{
    IOService *newService;
    // See Info.plist for properties
    auto ret = Create(this, "UserClientProperties", &newService);
    if (ret != kIOReturnSuccess) {
        os_log(OS_LOG_DEFAULT, "Failed to create new user client: code %d", ret);
        return ret;
    }
    
    *userClient = OSDynamicCast(IOUserClient, newService);
    if (!*userClient) {
        os_log(OS_LOG_DEFAULT, "Failed to cast new user client to IOUserClient");
        newService->release();
        return kIOReturnError;
    }
    
    return kIOReturnSuccess;
}
