//
//  CEFThreadID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Existing thread IDs.
/// CEF name: `cef_thread_id_t`.
public enum CEFThreadID: Int32 {

    /// The main thread in the browser. This will be the same as the main
    /// application thread if CefInitialize() is called with a
    /// CefSettings.multi_threaded_message_loop value of false.
    /// CEF name: `TID_UI`.
    case ui

    /// Used to interact with the database.
    /// CEF name: `TID_DB`.
    case db

    /// Used to interact with the file system.
    /// CEF name: `TID_FILE`.
    case file

    /// Used for file system operations that block user interactions.
    /// Responsiveness of this thread affects users.
    /// CEF name: `TID_FILE_USER_BLOCKING`.
    case fileUserBlocking

    /// Used to launch and terminate browser processes.
    /// CEF name: `TID_PROCESS_LAUNCHER`.
    case processLauncher

    /// Used to handle slow HTTP cache operations.
    /// CEF name: `TID_CACHE`.
    case cache

    /// Used to process IPC and network messages.
    /// CEF name: `TID_IO`.
    case io

    /// The main thread in the renderer. Used for all WebKit and V8 interaction.
    /// CEF name: `TID_RENDERER`.
    case renderer
}

extension CEFThreadID {
    static func fromCEF(_ value: cef_thread_id_t) -> CEFThreadID {
        return CEFThreadID(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_thread_id_t {
        return cef_thread_id_t(rawValue: UInt32(rawValue))
    }
}

