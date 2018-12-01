//
//  CEFLibraryUtils.swift
//  CEF.swift-Sandbox
//
//  Created by Tamas Lustyik on 2018. 11. 01..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

import Foundation
import CEFSandbox

public enum CEFLibraryUtils {
    /// Load the CEF library at the specified |path|. Returns true (1) on
    /// success and false (0) on failure.
    /// CEF name: `cef_load_library`
    public static func loadLibrary(at path: String) -> Bool {
        return path.withCString { cstr in
            return cef_load_library(cstr) != 0
        }
    }
    
    /// Unload the CEF library that was previously loaded. Returns true (1)
    /// on success and false (0) on failure.
    /// CEF name: `cef_unload_library`
    @discardableResult
    public static func unloadLibrary() -> Bool {
        return cef_unload_library() != 0
    }
    
    public static func loadLibraryInApp() -> Bool {
        return CEFLibraryLoader.loadLibraryInApp()
    }
    
    public static func loadLibraryInHelper() -> Bool {
        return CEFLibraryLoader.loadLibraryInHelper()
    }
    
}
