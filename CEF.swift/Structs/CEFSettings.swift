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
/// CEF name: `cef_settings_t`
public struct CEFSettings {
    // Allow other class to know if CEF is running on multi processes mode.
    public fileprivate(set) static var CEFSingleProcessMode = false

    /// Set to true (1) to use a single process for the browser and renderer. This
    /// run mode is not officially supported by Chromium and is less stable than
    /// the multi-process default. Also configurable using the "single-process"
    /// command-line switch.
    /// CEF name: `single_process`
    public var useSingleProcess: Bool = false {
        didSet {
            CEFSettings.CEFSingleProcessMode = useSingleProcess
        }
    }

    /// Set to false (0) to disable the sandbox for sub-processes. See
    /// cef_sandbox_win.h for requirements to enable the sandbox on Windows. Also
    /// configurable using the "no-sandbox" command-line switch.
    /// CEF name: `no_sandbox`
    public var useSandbox: Bool = true
    
    /// The path to a separate executable that will be launched for sub-processes.
    /// If this value is empty on Windows or Linux then the main process executable
    /// will be used. If this value is empty on macOS then a helper executable must
    /// exist at "Contents/Frameworks/<app> Helper.app/Contents/MacOS/<app> Helper"
    /// in the top-level app bundle. See the comments on CefExecuteProcess() for
    /// details. Also configurable using the "browser-subprocess-path" command-line
    /// switch.
    /// CEF name: `browser_subprocess_path`
    public var browserSubprocessPath: String = ""
    
    /// The path to the CEF framework directory on macOS. If this value is empty
    /// then the framework must exist at "Contents/Frameworks/Chromium Embedded
    /// Framework.framework" in the top-level app bundle. Also configurable using
    /// the "framework-dir-path" command-line switch.
    /// CEF name: `framework_dir_path`
    public var frameworkDirPath: String = ""
    
    /// Set to true (1) to have the browser process message loop run in a separate
    /// thread. If false (0) than the CefDoMessageLoopWork() function must be
    /// called from your application message loop. This option is only supported on
    /// Windows.
    /// CEF name: `multi_threaded_message_loop`
    public var useMultiThreadedMessageLoop: Bool = false
    
    /// Set to true (1) to control browser process main (UI) thread message pump
    /// scheduling via the CefBrowserProcessHandler::OnScheduleMessagePumpWork()
    /// callback. This option is recommended for use in combination with the
    /// CefDoMessageLoopWork() function in cases where the CEF message loop must be
    /// integrated into an existing application message loop (see additional
    /// comments and warnings on CefDoMessageLoopWork). Enabling this option is not
    /// recommended for most users; leave this option disabled and use either the
    /// CefRunMessageLoop() function or multi_threaded_message_loop if possible.
    /// CEF name: `external_message_pump`
    public var useExternalMessageLoop: Bool = false

    /// Set to true (1) to enable windowless (off-screen) rendering support. Do not
    /// enable this value if the application does not use windowless rendering as
    /// it may reduce rendering performance on some systems.
    /// CEF name: `windowless_rendering_enabled`
    public var useWindowlessRendering: Bool = false
    
    /// Set to false (0) to disable configuration of browser process features using
    /// standard CEF and Chromium command-line arguments. Configuration can still
    /// be specified using CEF data structures or via the
    /// CefApp::OnBeforeCommandLineProcessing() method.
    /// CEF name: `command_line_args_disabled`
    public var enableCommandLineArgs: Bool = true
    
    /// The location where cache data will be stored on disk. If empty then
    /// browsers will be created in "incognito mode" where in-memory caches are
    /// used for storage and no data is persisted to disk. HTML5 databases such as
    /// localStorage will only persist across sessions if a cache path is
    /// specified. Can be overridden for individual CefRequestContext instances via
    /// the CefRequestContextSettings.cache_path value.
    /// CEF name: `cache_path`
    public var cachePath: String = ""
    
    /// The location where user data such as spell checking dictionary files will
    /// be stored on disk. If empty then the default platform-specific user data
    /// directory will be used ("~/.cef_user_data" directory on Linux,
    /// "~/Library/Application Support/CEF/User Data" directory on Mac OS X,
    /// "Local Settings\Application Data\CEF\User Data" directory under the user
    /// profile directory on Windows).
    /// CEF name: `user_data_path`
    public var userDataPath: String = ""
    
    /// To persist session cookies (cookies without an expiry date or validity
    /// interval) by default when using the global cookie manager set this value to
    /// true (1). Session cookies are generally intended to be transient and most
    /// Web browsers do not persist them. A |cache_path| value must also be
    /// specified to enable this feature. Also configurable using the
    /// "persist-session-cookies" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.persist_session_cookies value.
    /// CEF name: `persist_session_cookies`
    public var persistSessionCookies: Bool = false
    
    /// To persist user preferences as a JSON file in the cache path directory set
    /// this value to true (1). A |cache_path| value must also be specified
    /// to enable this feature. Also configurable using the
    /// "persist-user-preferences" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.persist_user_preferences value.
    /// CEF name: `persist_user_preferences`
    public var persistUserPreferences: Bool = false
    
    /// Value that will be returned as the User-Agent HTTP header. If empty the
    /// default User-Agent string will be used. Also configurable using the
    /// "user-agent" command-line switch.
    /// CEF name: `user_agent`
    public var userAgent: String = ""
    
    /// Value that will be inserted as the product portion of the default
    /// User-Agent string. If empty the Chromium product version will be used. If
    /// |userAgent| is specified this value will be ignored. Also configurable
    /// using the "product-version" command-line switch.
    /// CEF name: `product_version`
    public var productVersion: String = ""
    
    /// The locale string that will be passed to WebKit. If empty the default
    /// locale of "en-US" will be used. This value is ignored on Linux where locale
    /// is determined using environment variable parsing with the precedence order:
    /// LANGUAGE, LC_ALL, LC_MESSAGES and LANG. Also configurable using the "lang"
    /// command-line switch.
    /// CEF name: `locale`
    public var locale: String = ""
    
    /// The directory and file name to use for the debug log. If empty a default
    /// log file name and location will be used. On Windows and Linux a "debug.log"
    /// file will be written in the main executable directory. On Mac OS X a
    /// "~/Library/Logs/<app name>_debug.log" file will be written where <app name>
    /// is the name of the main app executable. Also configurable using the
    /// "log-file" command-line switch.
    /// CEF name: `log_file`
    public var logFilePath: String = ""
    
    /// The log severity. Only messages of this severity level or higher will be
    /// logged. Also configurable using the "log-severity" command-line switch with
    /// a value of "verbose", "info", "warning", "error", "error-report" or
    /// "disable".
    /// CEF name: `log_severity`
    public var logSeverity: CEFLogSeverity = .default
    
    /// Custom flags that will be used when initializing the V8 JavaScript engine.
    /// The consequences of using custom flags may not be well tested. Also
    /// configurable using the "js-flags" command-line switch.
    /// CEF name: `javascript_flags`
    public var javascriptFlags: String = ""
    
    /// The fully qualified path for the resources directory. If this value is
    /// empty the cef.pak and/or devtools_resources.pak files must be located in
    /// the module directory on Windows/Linux or the app bundle Resources directory
    /// on Mac OS X. Also configurable using the "resources-dir-path" command-line
    /// switch.
    /// CEF name: `resources_dir_path`
    public var resourcesDirPath: String = ""
    
    /// The fully qualified path for the locales directory. If this value is empty
    /// the locales directory must be located in the module directory. This value
    /// is ignored on Mac OS X where pack files are always loaded from the app
    /// bundle Resources directory. Also configurable using the "locales-dir-path"
    /// command-line switch.
    /// CEF name: `locales_dir_path`
    public var localesDirPath: String = ""
    
    /// Set to false (0) to disable loading of pack files for resources and locales.
    /// A resource bundle handler must be provided for the browser and render
    /// processes via CefApp::GetResourceBundleHandler() if loading of pack files
    /// is disabled. Also configurable using the "disable-pack-loading" command-
    /// line switch.
    /// CEF name: `pack_loading_disabled`
    public var enablePackLoading: Bool = true
    
    /// Set to a value between 1024 and 65535 to enable remote debugging on the
    /// specified port. For example, if 8080 is specified the remote debugging URL
    /// will be http://localhost:8080. CEF can be remotely debugged from any CEF or
    /// Chrome browser window. Also configurable using the "remote-debugging-port"
    /// command-line switch.
    /// CEF name: `remote_debugging_port`
    public var remoteDebuggingPort: UInt16 = 0
    
    /// The number of stack trace frames to capture for uncaught exceptions.
    /// Specify a positive value to enable the CefRenderProcessHandler::
    /// OnUncaughtException() callback. Specify 0 (default value) and
    /// OnUncaughtException() will not be called. Also configurable using the
    /// "uncaught-exception-stack-size" command-line switch.
    /// CEF name: `uncaught_exception_stack_size`
    public var uncaughtExceptionStackSize: Int32 = 0
    
    /// Set to true (1) to ignore errors related to invalid SSL certificates.
    /// Enabling this setting can lead to potential security vulnerabilities like
    /// "man in the middle" attacks. Applications that load content from the
    /// internet should not enable this setting. Also configurable using the
    /// "ignore-certificate-errors" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.ignore_certificate_errors value.
    /// CEF name: `ignore_certificate_errors`
    public var ignoreCertificateErrors: Bool = false
    
    /// Set to true (1) to enable date-based expiration of built in network
    /// security information (i.e. certificate transparency logs, HSTS preloading
    /// and pinning information). Enabling this option improves network security
    /// but may cause HTTPS load failures when using CEF binaries built more than
    /// 10 weeks in the past. See https://www.certificate-transparency.org/ and
    /// https://www.chromium.org/hsts for details. Also configurable using the
    /// "enable-net-security-expiration" command-line switch. Can be overridden for
    /// individual CefRequestContext instances via the
    /// CefRequestContextSettings.enable_net_security_expiration value.
    /// CEF name: `enable_net_security_expiration`
    public var enableNetSecurityExpiration: Bool = false
    
    /// Background color used for the browser before a document is loaded and when
    /// no document color is specified. The alpha component must be either fully
    /// opaque (0xFF) or fully transparent (0x00). If the alpha component is fully
    /// opaque then the RGB components will be used as the background color. If the
    /// alpha component is fully transparent for a windowed browser then the
    /// default value of opaque white be used. If the alpha component is fully
    /// transparent for a windowless (off-screen) browser then transparent painting
    /// will be enabled.
    /// CEF name: `background_color`
    public var backgroundColor: CEFColor = CEFColor(argb: 0)
    
    /// Comma delimited ordered list of language codes without any whitespace that
    /// will be used in the "Accept-Language" HTTP header. May be overridden on a
    /// per-browser basis using the CefBrowserSettings.accept_language_list value.
    /// If both values are empty then "en-US,en" will be used. Can be overridden
    /// for individual CefRequestContext instances via the
    /// CefRequestContextSettings.accept_language_list value.
    /// CEF name: `accept_language_list`
    public var acceptLanguageList: String = ""

    public init() {
    }
}

extension CEFSettings {
    func toCEF() -> cef_settings_t {
        var cefStruct = cef_settings_t()
        
        cefStruct.size = MemoryLayout<cef_settings_t>.stride
        cefStruct.single_process = useSingleProcess ? 1 : 0
        cefStruct.no_sandbox = !useSandbox ? 1 : 0
        CEFStringSetFromSwiftString(browserSubprocessPath, cefStringPtr: &cefStruct.browser_subprocess_path)
        cefStruct.multi_threaded_message_loop = useMultiThreadedMessageLoop ? 1 : 0
        cefStruct.external_message_pump = useExternalMessageLoop ? 1 : 0
        cefStruct.windowless_rendering_enabled = useWindowlessRendering ? 1 : 0
        cefStruct.command_line_args_disabled = !enableCommandLineArgs ? 1 : 0
        CEFStringSetFromSwiftString(cachePath, cefStringPtr: &cefStruct.cache_path)
        CEFStringSetFromSwiftString(userDataPath, cefStringPtr: &cefStruct.user_data_path)
        cefStruct.persist_session_cookies = persistSessionCookies ? 1 : 0
        cefStruct.persist_user_preferences = persistUserPreferences ? 1 : 0
        CEFStringSetFromSwiftString(userAgent, cefStringPtr: &cefStruct.user_agent)
        CEFStringSetFromSwiftString(productVersion, cefStringPtr: &cefStruct.product_version)
        CEFStringSetFromSwiftString(locale, cefStringPtr: &cefStruct.locale)
        CEFStringSetFromSwiftString(logFilePath, cefStringPtr: &cefStruct.log_file)
        cefStruct.log_severity = logSeverity.toCEF()
        CEFStringSetFromSwiftString(javascriptFlags, cefStringPtr: &cefStruct.javascript_flags)
        CEFStringSetFromSwiftString(resourcesDirPath, cefStringPtr: &cefStruct.resources_dir_path)
        CEFStringSetFromSwiftString(localesDirPath, cefStringPtr: &cefStruct.locales_dir_path)
        cefStruct.pack_loading_disabled = !enablePackLoading ? 1 : 0
        cefStruct.remote_debugging_port = Int32(remoteDebuggingPort)
        cefStruct.uncaught_exception_stack_size = Int32(uncaughtExceptionStackSize)
        cefStruct.ignore_certificate_errors = ignoreCertificateErrors ? 1 : 0
        cefStruct.background_color = backgroundColor.toCEF()
        CEFStringSetFromSwiftString(acceptLanguageList, cefStringPtr: &cefStruct.accept_language_list)
        
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

