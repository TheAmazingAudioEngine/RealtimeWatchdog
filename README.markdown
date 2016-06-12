Realtime Thread Safety Monitor
==============================

This library for iOS acts as a watchdog for activities on the Core Audio thread that are considered unsafe:

1. Taking locks
2. Allocating memory
3. Using Objective-C

It works by overriding a number of functions: `malloc`, `free`, `objc\_storeStrong`, `objc\_msgSend` (for 64-bit devices and the 64-bit simulator only, for now), `pthread\_mutex\_lock` and `objc\_sync\_enter`. When a call is intercepted, a warning is printed to the console. You can also put a breakpoint on `AERealtimeSafetyMonitorUnsafeActivityWarning`.

This library is also built into [The Amazing Audio Engine 2](http://github.com/TheAmazingAudioEngine/TheAmazingAudioEngine2).

Usage
-----

1. Drag *RealtimeSafety.xcodeproj* into your project. 
2. Select your app target, open the "Link Binary With Libraries" tab, click the "+" button and select *libRealtimeSafety.a*. 
3. Then make sure the "Header Search Paths" build setting contains `"$(BUILT_PRODUCTS_DIR)"`. 
4. Add `#import <RealtimeSafety/AERealtimeSafetyMonitor.h>` to the top of the implementation file that contains your audio code
5. Call `AERealtimeSafetyMonitorInit(pthread_self())` at least once from your audio thread.

You can easily disable the monitor by commenting out the `#define REALTIME_SAFETY_MONITOR_ENABLED 1` line in `AERealtimeSafetyMonitor.h`.

It will only be active for debug builds, so you can leave it on safely.

Note that for 64-bit devices and the 64-bit simulator, this library provides its own implementation of `objc\_msgSend`, which means Objective-C method calls will be marginally slower.

For more discussion on realtime thread safety, see this article: [Responsible audio development: An appeal](http://atastypixel.com/blog/responsible-audio-development-an-appeal/).


Realtime Thread Safety Monitor License
--------------------------------------

Copyright (C) 2012-2016 A Tasty Pixel

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
   
2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.
   
3. This notice may not be removed or altered from any source distribution.

