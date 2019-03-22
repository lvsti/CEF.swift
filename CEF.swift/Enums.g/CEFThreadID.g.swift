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
    /// CefSettings.multi_threaded_message_loop value of false. Do not perform
    /// blocking tasks on this thread. All tasks posted after
    /// CefBrowserProcessHandler::OnContextInitialized() and before CefShutdown()
    /// are guaranteed to run. This thread will outlive all other CEF threads.
    /// CEF name: `TID_UI`.
    case ui

    /// Used for blocking tasks (e.g. file system access) where the user won't
    /// notice if the task takes an arbitrarily long time to complete. All tasks
    /// posted after CefBrowserProcessHandler::OnContextInitialized() and before
    /// CefShutdown() are guaranteed to run.
    /// CEF name: `TID_FILE_BACKGROUND`.
    case fileBackground

    /// Used for blocking tasks (e.g. file system access) that affect UI or
    /// responsiveness of future user interactions. Do not use if an immediate
    /// response to a user interaction is expected. All tasks posted after
    /// CefBrowserProcessHandler::OnContextInitialized() and before CefShutdown()
    /// are guaranteed to run.
    /// Examples:
    /// - Updating the UI to reflect progress on a long task.
    /// - Loading data that might be shown in the UI after a future user
    /// interaction.
    /// CEF name: `TID_FILE_USER_VISIBLE`.
    case fileUserVisible

    /// Used for blocking tasks (e.g. file system access) that affect UI
    /// immediately after a user interaction. All tasks posted after
    /// CefBrowserProcessHandler::OnContextInitialized() and before CefShutdown()
    /// are guaranteed to run.
    /// Example: Generating data shown in the UI immediately after a click.
    /// CEF name: `TID_FILE_USER_BLOCKING`.
    case fileUserBlocking

    /// Used to launch and terminate browser processes.
    /// CEF name: `TID_PROCESS_LAUNCHER`.
    case processLauncher

    /// Used to process IPC and network messages. Do not perform blocking tasks on
    /// this thread. All tasks posted after
    /// CefBrowserProcessHandler::OnContextInitialized() and before CefShutdown()
    /// are guaranteed to run.
    /// CEF name: `TID_IO`.
    case io

    /// The main thread in the renderer. Used for all WebKit and V8 interaction.
    /// Tasks may be posted to this thread after
    /// CefRenderProcessHandler::OnRenderThreadCreated but are not guaranteed to
    /// run before sub-process termination (sub-processes may be killed at any time
    /// without warning).
    /// CEF name: `TID_RENDERER`.
    case renderer
    
    /// CEF name: `TID_FILE`.
    public static let file: CEFThreadID = .fileBackground
}

extension CEFThreadID {
    static func fromCEF(_ value: cef_thread_id_t) -> CEFThreadID {
        return CEFThreadID(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_thread_id_t {
        return cef_thread_id_t(rawValue: UInt32(rawValue))
    }
}

