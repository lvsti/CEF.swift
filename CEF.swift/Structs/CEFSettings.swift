//
//  CEFSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


public struct CEFSettings {
    public var singleProcess: Bool = false
    public var noSandbox: Bool = false
    public var browserSubprocessPath: String = ""
    public var multiThreadedMessageLoop: Bool = false
    public var windowlessRenderingEnabled: Bool = false
    public var commandLineArgsDisabled: Bool = false
    public var cachePath: String = ""
    public var userDataPath: String = ""
    public var persistSessionCookies: Bool = false
    public var userAgent: String = ""
    public var productVersion: String = ""
    public var locale: String = ""
    public var logFile: String = ""
    public var logSeverity: CEFLogSeverity = .Default
    public var javascriptFlags: String = ""
    public var resourcesDirPath: String = ""
    public var localesDirPath: String = ""
    public var packLoadingDisabled: Bool = false
    public var remoteDebuggingPort: UInt16 = 0
    public var uncaughtExceptionStackSize: Int32 = 0
    public var contextSafetyImplementation: CEFV8ContextSafetyImplementation = .Default
    public var ignoreCertificateErrors: Bool = false
    public var backgroundColor: CEFColor = CEFColor(argb: 0)
    public var acceptLanguageList: String = ""

    public init() {
    }
}

extension CEFSettings {
    func toCEF() -> cef_settings_t {
        var cefStruct = cef_settings_t()
        
        cefStruct.size = strideof(cef_settings_t)
        cefStruct.single_process = singleProcess ? 1 : 0
        cefStruct.no_sandbox = noSandbox ? 1 : 0
        CEFStringSetFromSwiftString(browserSubprocessPath, cefString: &cefStruct.browser_subprocess_path)
        cefStruct.multi_threaded_message_loop = multiThreadedMessageLoop ? 1 : 0
        cefStruct.windowless_rendering_enabled = windowlessRenderingEnabled ? 1 : 0
        cefStruct.command_line_args_disabled = commandLineArgsDisabled ? 1 : 0
        CEFStringSetFromSwiftString(cachePath, cefString: &cefStruct.cache_path)
        CEFStringSetFromSwiftString(userDataPath, cefString: &cefStruct.user_data_path)
        cefStruct.persist_session_cookies = persistSessionCookies ? 1 : 0
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

