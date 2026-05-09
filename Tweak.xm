#import <Foundation/Foundation.h>
#import <substrate.h>
#import <mach-o/dyld.h>

/*
 * PES Mobile Auto Play Mod (C++ Symbol Hooking)
 * This version uses MSHookFunction for better compatibility with C++ symbols.
 */

// Function pointers to store original functions
bool (*old_IsOnlineMatch)(void *instance);
bool (*old_IsAiMatch)(void *instance);
bool (*old_IsBotControlled)(void *instance);

// Replacement functions
bool new_IsOnlineMatch(void *instance) {
    return false; // Always false
}

bool new_IsAiMatch(void *instance) {
    return true; // Always true
}

bool new_IsBotControlled(void *instance) {
    return true; // Always true
}

%ctor {
    @autoreleasepool {
        NSLog(@"[PES Mod] Initializing Hooks...");

        // Hooking by Symbols (These are the mangled names found in the binary)
        
        // 1. basic::Status::IsOnlineMatch()
        MSHookFunction((void *)MSFindSymbol(NULL, "__ZN5basic6Status13IsOnlineMatchEv"), 
                       (void *)new_IsOnlineMatch, 
                       (void **)&old_IsOnlineMatch);

        // 2. UUEMenuUtilityOnlineMultiplay::IsAiMatch()
        MSHookFunction((void *)MSFindSymbol(NULL, "__ZN29UUEMenuUtilityOnlineMultiplay9IsAiMatchEv"), 
                       (void *)new_IsAiMatch, 
                       (void **)&old_IsAiMatch);

        // 3. APawn::IsBotControlled()
        MSHookFunction((void *)MSFindSymbol(NULL, "__ZNK5APawn15IsBotControlledEv"), 
                       (void *)new_IsBotControlled, 
                       (void **)&old_IsBotControlled);

        NSLog(@"[PES Mod] All Hooks Applied!");
    }
}
