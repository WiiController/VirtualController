# VirtualController

Work in progress…

Based on [WiiController](https://github.com/WiiController/WiiController), a fork of [WJoy](https://github.com/alxn1/wjoy) by alxn1 (released under BSD 2-Clause License),

## Demo app

Open the `.xcworkspace` in Xcode, and run the scheme "ca.igregory.VHIDTest". When prompted, allow the new system extension.

## Debugging

```
hidutil list
systemextensionsctl list
systemextensionsctl uninstall - ca.igregory.VirtualController.dext
````
