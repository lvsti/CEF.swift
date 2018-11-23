//
//  main.cpp
//  CEFDemo Helper (C++)
//
//  Created by Tamas Lustyik on 2018. 11. 23..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

#include "include/capi/cef_app_capi.h"
#include "include/wrapper/cef_library_loader.h"
#include "include/cef_sandbox_mac.h"

// Entry point function for sub-processes.
int main(int argc, char* argv[]) {
    // Initialize the macOS sandbox for this helper process.
    CefScopedSandboxContext sandboxContext;
    if (!sandboxContext.Initialize(argc, argv)) {
        return 1;
    }
    
    // Load the CEF framework library at runtime instead of linking directly
    // as required by the macOS sandbox implementation.
    CefScopedLibraryLoader libraryLoader;
    if (!libraryLoader.LoadInHelper()) {
        return 1;
    }
    
    // Provide CEF with command-line arguments.
    cef_main_args_t mainArgs = {.argc = argc, .argv = argv};
    
    // Execute the sub-process.
    return cef_execute_process(&mainArgs, nullptr, nullptr);
}
