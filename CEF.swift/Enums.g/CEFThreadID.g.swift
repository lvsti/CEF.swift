//
//  CEFThreadID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Existing thread IDs.
public enum CEFThreadID: Int32 {

    /// The main thread in the browser. This will be the same as the main
    /// application thread if CefInitialize() is called with a
    /// CefSettings.multi_threaded_message_loop value of false.
    case ui

    /// Used to interact with the database.
    case db

    /// Used to interact with the file system.
    case file

    /// Used for file system operations that block user interactions.
    /// Responsiveness of this thread affects users.
    case fileUserBlocking

    /// Used to launch and terminate browser processes.
    case processLauncher

    /// Used to handle slow HTTP cache operations.
    case cache

    /// Used to process IPC and network messages.
    case io

    /// The main thread in the renderer. Used for all WebKit and V8 interaction.
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

