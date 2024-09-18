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
    os_log(OS_LOG_DEFAULT, "ca_igregory_VirtualController::Start");
    
    kern_return_t ret;
    ret = Start(provider, SUPERDISPATCH);
    if (ret != kIOReturnSuccess) return ret;
    
    ret = RegisterService();
    os_log(OS_LOG_DEFAULT, "ca_igregory_VirtualController::Start: RegisterService returned %d", ret);
    
    return ret;
}

kern_return_t
IMPL(ca_igregory_VirtualController, NewUserClient)
{
    os_log(OS_LOG_DEFAULT, "ca_igregory_VirtualController::NewUserClient");
    
    IOService *newService;
    // See Info.plist for properties
    auto ret = Create(this, "UserClientProperties", &newService);
    if (ret != kIOReturnSuccess) {
        os_log(OS_LOG_DEFAULT, "ca_igregory_VirtualController::NewUserClient: Failed to create new user client: code %d", ret);
        return ret;
    }
    
    *userClient = OSDynamicCast(IOUserClient, newService);
    if (!*userClient) {
        os_log(OS_LOG_DEFAULT, "ca_igregory_VirtualController::NewUserClient: Failed to cast new user client to IOUserClient");
        newService->release();
        return kIOReturnError;
    }
    
    return kIOReturnSuccess;
}
