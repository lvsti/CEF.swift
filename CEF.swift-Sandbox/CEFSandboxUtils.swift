//
//  CEFSandboxUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2018. 11. 01..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

import Foundation
import CEFSandbox

/// Opaque sandbox context handle
public protocol CEFSandboxContext {}

/// This API requires linking with `cef_sandbox.a`
///
/// The sandbox is used to restrict sub-processes (renderer, plugin, GPU, etc)
/// from directly accessing system resources. This helps to protect the user
/// from untrusted and potentially malicious Web content.
/// See http://www.chromium.org/developers/design-documents/sandbox for
/// complete details.
///
/// To enable the sandbox on macOS the following requirements must be met:
/// 1. Link the helper process executable with the cef_sandbox static library.
/// 2. Call the cef_sandbox_initialize() function at the beginning of the
///    helper executable main() function and before loading the CEF framework
///    library. See include/wrapper/cef_library_loader.h for example usage.
public enum CEFSandboxUtils {
    private struct SandboxContext: CEFSandboxContext {
        let handle: UnsafeMutableRawPointer
    }
    
    /// Initialize the sandbox for this process. Returns the sandbox context
    /// handle on success or NULL on failure. The returned handle should be
    /// passed to cef_sandbox_destroy() immediately before process termination.
    /// CEF name: `cef_sandbox_initialize`
    public static func initializeSandbox(with arguments: [String]) -> CEFSandboxContext? {
        let cefCtx = cef_sandbox_initialize(Int32(arguments.count), CEFArgVFromArguments(arguments))
        if let cefCtx = cefCtx {
            return SandboxContext(handle: cefCtx)
        }
        return nil
    }
    
    /// Destroy the specified sandbox context handle.
    /// CEF name: `cef_sandbox_destroy`
    public static func destroySandbox(context: CEFSandboxContext) {
        guard let context = context as? SandboxContext else {
            return
        }
        cef_sandbox_destroy(context.handle)
    }
}
