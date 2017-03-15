//
//  CEFProcessUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFProcessUtils {

    /// This function should be called from the application entry point function to
    /// execute a secondary process. It can be used to run secondary processes from
    /// the browser client executable (default behavior) or from a separate
    /// executable specified by the CefSettings.browser_subprocess_path value. If
    /// called for the browser process (identified by no "type" command-line value)
    /// it will return immediately with a value of -1. If called for a recognized
    /// secondary process it will block until the process should exit and then return
    /// the process exit code. The |application| parameter may be empty. The
    /// |windows_sandbox_info| parameter is only used on Windows and may be NULL (see
    /// cef_sandbox_win.h for details).
    /// CEF name: `CefExecuteProcess`
    public static func executeProcessWithArgs(args: CEFMainArgs,
                                              app: CEFApp? = nil,
                                              winSandboxInfo: UnsafeMutableRawPointer? = nil) -> Int {
        var cefArgs = args.toCEF()
        defer { cefArgs.clear() }
        return Int(cef_execute_process(&cefArgs, app != nil ? app!.toCEF() : nil, winSandboxInfo))
    }

    /// This function should be called on the main application thread to initialize
    /// the CEF browser process. The |application| parameter may be empty. A return
    /// value of true indicates that it succeeded and false indicates that it failed.
    /// The |windows_sandbox_info| parameter is only used on Windows and may be NULL
    /// (see cef_sandbox_win.h for details).
    /// CEF name: `CefInitialize`
    @discardableResult
    public static func initializeMainWithArgs(args: CEFMainArgs,
                                              settings: CEFSettings,
                                              app: CEFApp? = nil,
                                              winSandboxInfo: UnsafeMutableRawPointer? = nil) -> Bool {
        var cefArgs = args.toCEF()
        var cefSettings = settings.toCEF()
        defer {
            cefArgs.clear()
            cefSettings.clear()
        }
        return cef_initialize(&cefArgs, &cefSettings, app != nil ? app!.toCEF() : nil, winSandboxInfo) != 0
    }

    /// This function should be called on the main application thread to shut down
    /// the CEF browser process before the application exits.
    /// CEF name: `CefShutdown`
    public static func shutDown() {
        cef_shutdown()
    }

    /// Perform a single iteration of CEF message loop processing. This function is
    /// provided for cases where the CEF message loop must be integrated into an
    /// existing application message loop. Use of this function is not recommended
    /// for most users; use either the CefRunMessageLoop() function or
    /// CefSettings.multi_threaded_message_loop if possible. When using this function
    /// care must be taken to balance performance against excessive CPU usage. It is
    /// recommended to enable the CefSettings.external_message_pump option when using
    /// this function so that CefBrowserProcessHandler::OnScheduleMessagePumpWork()
    /// callbacks can facilitate the scheduling process. This function should only be
    /// called on the main application thread and only if CefInitialize() is called
    /// with a CefSettings.multi_threaded_message_loop value of false. This function
    /// will not block.
    /// CEF name: `CefDoMessageLoopWork`
    public static func doMessageLoopWork() {
        cef_do_message_loop_work()
    }

    /// Run the CEF message loop. Use this function instead of an application-
    /// provided message loop to get the best balance between performance and CPU
    /// usage. This function should only be called on the main application thread and
    /// only if CefInitialize() is called with a
    /// CefSettings.multi_threaded_message_loop value of false. This function will
    /// block until a quit message is received by the system.
    /// CEF name: `CefRunMessageLoop`
    public static func runMessageLoop() {
        cef_run_message_loop()
    }

    /// Quit the CEF message loop that was started by calling CefRunMessageLoop().
    /// This function should only be called on the main application thread and only
    /// if CefRunMessageLoop() was used.
    /// CEF name: `CefQuitMessageLoop`
    public static func quitMessageLoop() {
        cef_quit_message_loop()
    }

    /// Set to true before calling Windows APIs like TrackPopupMenu that enter a
    /// modal message loop. Set to false after exiting the modal message loop.
    /// CEF name: `CefSetOSModalLoop`
    public static func setOSModalLoop(modal: Bool) {
        cef_set_osmodal_loop(modal ? 1 : 0)
    }

    /// Call during process startup to enable High-DPI support on Windows 7 or newer.
    /// Older versions of Windows should be left DPI-unaware because they do not
    /// support DirectWrite and GDI fonts are kerned very badly.
    /// CEF name: `CefEnableHighDPISupport`
    public static func enableHighDPISupport() {
        cef_enable_highdpi_support()
    }

}
