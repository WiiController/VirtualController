#!/bin/bash

cd $(dirname "$0")

cd VHIDTest
clang-format -i *.{h,m}
cd ..

cd VirtualController
clang-format -i *.{h,m}
cd ..
