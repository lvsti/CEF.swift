//
//  CEFSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


/// Initialization settings. Specify NULL or 0 to get the recommended default
/// values. Many of these and other settings can also configured using command-
/// line switches.
public struct CEFSettings {
    /// Set to true (1) to use a single process for the browser and renderer. This
    /// run mode is not officially supported by Chromium and is less stable than
    /// the multi-process default. Also configurable using the "single-process"
    /// command-line switch.
    public var singleProcess: Bool = false

    /// Set to true (1) to disable the sandbox for sub-processes. See
    /// cef_sandbox_win.h for requirements to enable the sandbox on Windows. Also
    /// configurable using the "no-sandbox" command-line switch.
    public var noSandbox: Bool = false
    
    /// The path to a separate executable that will be launched for sub-processes.
    /// By default the browser process executable is used. See the comments on
    /// CefExecuteProcess() for details. Also configurable using the
    /// "browser-subprocess-path" command-line switch.
    public var browserSubprocessPath: String = ""
    
    /// Set to true (1) to have the browser process message loop run in a separate
    /// thread. If false (0) than the CefDoMessageLoopWork() function must be
    /// called from your application message loop. This option is only supported on
    /// Windows.
    public var multiThreadedMessageLoop: Bool = false
    
    /// Set to true (1) to enable windowless (off-screen) rendering support. Do not
    /// enable this value if the application does not use windowless rendering as
    /// it may reduce rendering performance on some systems.
    public var windowlessRenderingEnabled: Bool = false
    
    /// Set to true (1) to disable configuration of browser process features using
    /// standard CEF and Chromium command-line arguments. Configuration can still
    /// be specified using CEF data structures or via the
    /// CefApp::OnBeforeCommandLineProcessing() method.
    public var commandLineArgsDisabled: Bool = false
    
    /// The location where cache data will be stored on disk. If empty then
    /// browsers will be created in "incognito mode" where in-memory caches are
    /// used for storage and no data is persisted to disk. HTML5 databases such as
    /// localStorage will only persist across sessions if a cache path is
    /// specified. Can be overridden for individual CefRequestContext instances via
    /// the CefRequestContextSettings.cache_path value.
    public var cachePath: String = ""
    
    /// The location where user data such as spell checking dictionary files will
    /// be stored on disk. If empty then the default platform-specific user data
    /// directory will be used ("~/.cef_user_data" directory on Linux,
    /// "~/Library/Application Support/CEF/User Data" directory on Mac OS X,
    /// "Local Settings\Application Data\CEF\User Data" directory under the user
    /// profile directory on Windows).
    public var userDataPath: String = ""
    
    /// To persist session cookies (cookies without an expiry date or validity
    /// interval) by default when using the global cookie manager set this value to
    /// true (1). Session cookies are generally intended to be transient and most
    /// Web browsers do not persist them. A |cache_path| value must also be
    /// specified to enable this feature. Also configurable using the
    /// "persist-session-cookies" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.persist_session_cookies value.
    public var persistSessionCookies: Bool = false
    
    /// To persist user preferences as a JSON file in the cache path directory set
    /// this value to true (1). A |cache_path| value must also be specified
    /// to enable this feature. Also configurable using the
    /// "persist-user-preferences" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.persist_user_preferences value.
    public var persistUserPreferences: Bool = false
    
    /// Value that will be returned as the User-Agent HTTP header. If empty the
    /// default User-Agent string will be used. Also configurable using the
    /// "user-agent" command-line switch.
    public var userAgent: String = ""
    
    /// Value that will be inserted as the product portion of the default
    /// User-Agent string. If empty the Chromium product version will be used. If
    /// |userAgent| is specified this value will be ignored. Also configurable
    /// using the "product-version" command-line switch.
    public var productVersion: String = ""
    
    /// The locale string that will be passed to WebKit. If empty the default
    /// locale of "en-US" will be used. This value is ignored on Linux where locale
    /// is determined using environment variable parsing with the precedence order:
    /// LANGUAGE, LC_ALL, LC_MESSAGES and LANG. Also configurable using the "lang"
    /// command-line switch.
    public var locale: String = ""
    
    /// The directory and file name to use for the debug log. If empty a default
    /// log file name and location will be used. On Windows and Linux a "debug.log"
    /// file will be written in the main executable directory. On Mac OS X a
    /// "~/Library/Logs/<app name>_debug.log" file will be written where <app name>
    /// is the name of the main app executable. Also configurable using the
    /// "log-file" command-line switch.
    public var logFile: String = ""
    
    /// The log severity. Only messages of this severity level or higher will be
    /// logged. Also configurable using the "log-severity" command-line switch with
    /// a value of "verbose", "info", "warning", "error", "error-report" or
    /// "disable".
    public var logSeverity: CEFLogSeverity = .Default
    
    /// Custom flags that will be used when initializing the V8 JavaScript engine.
    /// The consequences of using custom flags may not be well tested. Also
    /// configurable using the "js-flags" command-line switch.
    public var javascriptFlags: String = ""
    
    /// The fully qualified path for the resources directory. If this value is
    /// empty the cef.pak and/or devtools_resources.pak files must be located in
    /// the module directory on Windows/Linux or the app bundle Resources directory
    /// on Mac OS X. Also configurable using the "resources-dir-path" command-line
    /// switch.
    public var resourcesDirPath: String = ""
    
    /// The fully qualified path for the locales directory. If this value is empty
    /// the locales directory must be located in the module directory. This value
    /// is ignored on Mac OS X where pack files are always loaded from the app
    /// bundle Resources directory. Also configurable using the "locales-dir-path"
    /// command-line switch.
    public var localesDirPath: String = ""
    
    /// Set to true (1) to disable loading of pack files for resources and locales.
    /// A resource bundle handler must be provided for the browser and render
    /// processes via CefApp::GetResourceBundleHandler() if loading of pack files
    /// is disabled. Also configurable using the "disable-pack-loading" command-
    /// line switch.
    public var packLoadingDisabled: Bool = false
    
    /// Set to a value between 1024 and 65535 to enable remote debugging on the
    /// specified port. For example, if 8080 is specified the remote debugging URL
    /// will be http://localhost:8080. CEF can be remotely debugged from any CEF or
    /// Chrome browser window. Also configurable using the "remote-debugging-port"
    /// command-line switch.
    public var remoteDebuggingPort: UInt16 = 0
    
    /// The number of stack trace frames to capture for uncaught exceptions.
    /// Specify a positive value to enable the CefRenderProcessHandler::
    /// OnUncaughtException() callback. Specify 0 (default value) and
    /// OnUncaughtException() will not be called. Also configurable using the
    /// "uncaught-exception-stack-size" command-line switch.
    public var uncaughtExceptionStackSize: Int32 = 0
    
    /// By default CEF V8 references will be invalidated (the IsValid() method will
    /// return false) after the owning context has been released. This reduces the
    /// need for external record keeping and avoids crashes due to the use of V8
    /// references after the associated context has been released.
    /// CEF currently offers two context safety implementations with different
    /// performance characteristics. The default implementation (value of 0) uses a
    /// map of hash values and should provide better performance in situations with
    /// a small number contexts. The alternate implementation (value of 1) uses a
    /// hidden value attached to each context and should provide better performance
    /// in situations with a large number of contexts.
    /// If you need better performance in the creation of V8 references and you
    /// plan to manually track context lifespan you can disable context safety by
    /// specifying a value of -1.
    /// Also configurable using the "context-safety-implementation" command-line
    /// switch.
    public var contextSafetyImplementation: CEFV8ContextSafetyImplementation = .Default
    
    /// Set to true (1) to ignore errors related to invalid SSL certificates.
    /// Enabling this setting can lead to potential security vulnerabilities like
    /// "man in the middle" attacks. Applications that load content from the
    /// internet should not enable this setting. Also configurable using the
    /// "ignore-certificate-errors" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.ignore_certificate_errors value.
    public var ignoreCertificateErrors: Bool = false
    
    /// Opaque background color used for accelerated content. By default the
    /// background color will be white. Only the RGB compontents of the specified
    /// value will be used. The alpha component must greater than 0 to enable use
    /// of the background color but will be otherwise ignored.
    public var backgroundColor: CEFColor = CEFColor(argb: 0)
    
    /// Comma delimited ordered list of language codes without any whitespace that
    /// will be used in the "Accept-Language" HTTP header. May be overridden on a
    /// per-browser basis using the CefBrowserSettings.accept_language_list value.
    /// If both values are empty then "en-US,en" will be used. Can be overridden
    /// for individual CefRequestContext instances via the
    /// CefRequestContextSettings.accept_language_list value.
    public var acceptLanguageList: String = ""

    public init() {
    }
}

extension CEFSettings {
    func toCEF() -> cef_settings_t {
        var cefStruct = cef_settings_t()
        
        cefStruct.size = MemoryLayout<cef_settings_t>.stride
        cefStruct.single_process = singleProcess ? 1 : 0
        cefStruct.no_sandbox = noSandbox ? 1 : 0
        CEFStringSetFromSwiftString(browserSubprocessPath, cefString: &cefStruct.browser_subprocess_path)
        cefStruct.multi_threaded_message_loop = multiThreadedMessageLoop ? 1 : 0
        cefStruct.windowless_rendering_enabled = windowlessRenderingEnabled ? 1 : 0
        cefStruct.command_line_args_disabled = commandLineArgsDisabled ? 1 : 0
        CEFStringSetFromSwiftString(cachePath, cefString: &cefStruct.cache_path)
        CEFStringSetFromSwiftString(userDataPath, cefString: &cefStruct.user_data_path)
        cefStruct.persist_session_cookies = persistSessionCookies ? 1 : 0
        cefStruct.persist_user_preferences = persistUserPreferences ? 1 : 0
        CEFStringSetFromSwiftString(userAgent, cefString: &cefStruct.user_agent)
        CEFStringSetFromSwiftString(productVersion, cefString: &cefStruct.product_version)
        CEFStringSetFromSwiftString(locale, cefString: &cefStruct.locale)
        CEFStringSetFromSwiftString(logFile, cefString: &cefStruct.log_file)
        cefStruct.log_severity = logSeverity.toCEF()
        CEFStringSetFromSwiftString(javascriptFlags, cefString: &cefStruct.javascript_flags)
        CEFStringSetFromSwiftString(resourcesDirPath, cefString: &cefStruct.resources_dir_path)
        CEFStringSetFromSwiftString(localesDirPath, cefString: &cefStruct.locales_dir_path)
        cefStruct.pack_loading_disabled = packLoadingDisabled ? 1 : 0
        cefStruct.remote_debugging_port = Int32(remoteDebuggingPort)
        cefStruct.uncaught_exception_stack_size = Int32(uncaughtExceptionStackSize)
        cefStruct.context_safety_implementation = contextSafetyImplementation.toCEF()
        cefStruct.ignore_certificate_errors = ignoreCertificateErrors ? 1 : 0
        cefStruct.background_color = backgroundColor.toCEF()
        CEFStringSetFromSwiftString(acceptLanguageList, cefString: &cefStruct.accept_language_list)
        
        return cefStruct
    }
}

extension cef_settings_t {
    mutating func clear() {
        cef_string_utf16_clear(&browser_subprocess_path)
        cef_string_utf16_clear(&cache_path)
        cef_string_utf16_clear(&user_data_path)
        cef_string_utf16_clear(&user_agent)
        cef_string_utf16_clear(&product_version)
        cef_string_utf16_clear(&locale)
        cef_string_utf16_clear(&log_file)
        cef_string_utf16_clear(&javascript_flags)
        cef_string_utf16_clear(&resources_dir_path)
        cef_string_utf16_clear(&locales_dir_path)
        cef_string_utf16_clear(&accept_language_list)
    }
}

