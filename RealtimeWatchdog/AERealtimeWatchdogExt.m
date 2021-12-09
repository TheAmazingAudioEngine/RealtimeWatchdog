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

#import <pthread.h>
#import <string.h>
#import <stdio.h>

#import "AERealtimeWatchdog.h"

#if (REALTIME_WATCHDOG_ENABLED && USE_WATCHDOG_REGISTRATION_FUNCTIONS)


extern pthread_t sAERealtimeThread;


// Call this at the very top of the playback and record callbacks
void AERealtimeWatchdogStartMonitoring(void) {
	pthread_t thread = pthread_self();

	// All we really need is to assign sAERealtimeThread, but do a few sanity checks
	char name[21];
	if ( pthread_getname_np(thread, name, sizeof(name)) == 0 && !strcmp(name, "AURemoteIO::IOThread") ) {
		if (sAERealtimeThread != NULL) {
			printf("AERealtimeWatchdog: Unmatched start/stop!\n");
		}
		sAERealtimeThread = thread;
	} else {
		printf("AERealtimeWatchdog: %s not called from the realtime thread!\n", __FUNCTION__);
		sAERealtimeThread = NULL;
	}
}

// Call this at the very end of the playback and record callbacks
void AERealtimeWatchdogStopMonitoring(void) {
	if (sAERealtimeThread == NULL) {
		printf("AERealtimeWatchdog: Unmatched start/stop!\n");
	}
	sAERealtimeThread = NULL;
}

#endif
