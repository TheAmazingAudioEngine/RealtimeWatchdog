Pod::Spec.new do |s|
  s.name         = "RealtimeWatchdog"
  s.version      = "1.0.1"
  s.summary      = "A library for iOS audio which acts as a watchdog for unsafe activity on the audio thread."
  s.description  = <<-DESC
This library for iOS acts as a watchdog for activities on the Core Audio thread that are considered unsafe:

1. Taking locks
2. Allocating memory
3. Using Objective-C
4. File or network IO

It works by overriding a number of system functions, including malloc, free, objc_storeStrong, objc_msgSend (for 64-bit devices and the 64-bit simulator only, for now), pthread_mutex_lock and objc_sync_enter, read, write, etc. When a call is intercepted, a warning is printed to the console. You can also put a breakpoint on AERealtimeWatchdogUnsafeActivityWarning.

It won’t catch everything, and it won’t catch anything in Apple’s own system code, but it’ll catch some locks, some memory allocation, all Objective-C use (but not Swift), all object retains, and some common IO tasks, in your code and that of any static libraries you’re using.
                      DESC
  s.homepage     = "https://github.com/TheAmazingAudioEngine/RealtimeWatchdog"
  s.license      = 'zlib'
  s.author       = { "Michael Tyson" => "michael@atastypixel.com" }
  s.source       = { :git => "https://github.com/TheAmazingAudioEngine/RealtimeWatchdog.git", :tag => "1.0.1" }
  s.ios.deployment_target = '8.0'
  s.source_files = 'RealtimeWatchdog/*'
  s.pod_target_xcconfig = { 'OTHER_CFLAGS' => '-fno-modules' }
  s.requires_arc = false
end
