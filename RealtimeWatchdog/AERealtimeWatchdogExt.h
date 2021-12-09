//
//  AERealtimeWatchdogMonitor.h
//  TheAmazingAudioEngine
//
//  Created by Michael Tyson on 12/06/2016.
//  Idea by Taylor Holliday
//  Copyright © 2016 A Tasty Pixel. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

// Uncomment the following to use the thread registration functions. You must call
// AERealtimeWatchdogStartMonitoring and AERealtimeWatchdogStopMonitoring from the realtime thread.
//#define USE_WATCHDOG_REGISTRATION_FUNCTIONS 1


#ifndef __ASSEMBLER__
#if (REALTIME_WATCHDOG_ENABLED && USE_WATCHDOG_REGISTRATION_FUNCTIONS)

#if defined(__cplusplus)
extern "C" {
#endif
	// Call this at the very top of the playback and record callbacks
	void AERealtimeWatchdogStartMonitoring(void);
	// Call this at the very end of the playback and record callbacks
	void AERealtimeWatchdogStopMonitoring(void);
#if defined(__cplusplus)
}
#endif

#else // !REALTIME_WATCHDOG_ENABLED

	// Stubbed out for release
	static inline void AERealtimeWatchdogStartMonitoring(void) {};
	static inline void AERealtimeWatchdogStopMonitoring(void) {};

#endif // REALTIME_WATCHDOG_ENABLED
#endif // REALTIME_WATCHDOG_INCLUDED_BY_ASM

