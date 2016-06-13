Realtime Thread Safety Watchdog
===============================

This library for iOS acts as a watchdog for activities on the Core Audio thread that are considered unsafe:

1. Taking locks
2. Allocating memory
3. Using Objective-C
4. File or network IO

It works by overriding a number of system functions, including `malloc`, `free`, `objc_storeStrong`, `objc_msgSend` (for 64-bit devices and the 64-bit simulator only, for now), `pthread_mutex_lock` and `objc_sync_enter`, `read`, `write`, etc. When a call is intercepted, a warning is printed to the console. You can also put a breakpoint on `AERealtimeWatchdogUnsafeActivityWarning`.

It won’t catch everything, and it won’t catch anything in Apple’s own system code, but it’ll catch some locks, some memory allocation, all Objective-C use (but not Swift), all object retains, and some common IO tasks, in your code and that of any static libraries you’re using.

This library is also built into [The Amazing Audio Engine 2](http://github.com/TheAmazingAudioEngine/TheAmazingAudioEngine2).

Idea by [Taylor Holliday](http://audulus.com/), implemented by [Michael Tyson](http://atastypixel.com/blog).

Usage
-----

1. Drag *RealtimeWatchdog.xcodeproj* into your project. 
2. Select your app target, open the "Link Binary With Libraries" tab, click the "+" button and select *libRealtimeWatchdog.a*. Done.

You can easily disable the monitor by commenting out the `#define REALTIME_WATCHDOG_ENABLED 1` line in `AERealtimeWatchdog.h`.

It will only be active for debug builds, so you can leave it on safely.

Note that for 64-bit devices and the 64-bit simulator, this library provides its own wrapper implementation of `objc_msgSend`, which means Objective-C method calls will be marginally slower.

For more discussion on realtime thread safety, see this article: [Responsible audio development: An appeal](http://atastypixel.com/blog/responsible-audio-development-an-appeal/).


Realtime Thread Safety Watchdog License
---------------------------------------

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

