//
//  CEFSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

enum CEFLogSeverity: Int {
    case Default = 0
    case Verbose
    case Info
    case Warning
    case Error
    case Disable = 99
}

enum CEFV8ContextSafetyImplementation: Int {
    case Default = 0
    case Alternate = 1
    case Disabled = -1
}

struct CEFColor {
    let r: UInt8
    let g: UInt8
    let b: UInt8
    let a: UInt8
    var argb: UInt32 { get { UInt32(a) << 24 | UInt32(r) << 16 | UInt32(g) << 8 | UInt32(b) } }
    
    init(argb: UInt32) {
        r = UInt8((argb >> 16) & 0xff)
        g = UInt8((argb >> 8) & 0xff)
        b = UInt8(argb & 0xff)
        a = UInt8((argb >> 24) & 0xff)
    }
}

class CEFSettings: CEFStruct<cef_settings_t> {
    var singleProcess: Bool {
        get { return self.cefStruct.single_process != 0 }
        set(value) { self.cefStruct.single_process = value ? 1 : 0 }
    }
    
    var noSandbox: Bool {
        get { return self.cefStruct.no_sandbox != 0 }
        set(value) { self.cefStruct.no_sandbox = value ? 1 : 0 }
    }

    var browserSubprocessPath: String {
        get { return CEFStringToSwiftString(self.cefStruct.browser_subprocess_path) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.browser_subprocess_path) }
    }

    var multiThreadedMessageLoop: Bool {
        get { return self.cefStruct.multi_threaded_message_loop != 0 }
        set(value) { self.cefStruct.multi_threaded_message_loop = value ? 1 : 0 }
    }

    var windowlessRenderingEnabled: Bool {
        get { return self.cefStruct.windowless_rendering_enabled != 0 }
        set(value) { self.cefStruct.windowless_rendering_enabled = value ? 1 : 0 }
    }

    var commandLineArgsDisabled: Bool {
        get { return self.cefStruct.command_line_args_disabled != 0 }
        set(value) { self.cefStruct.command_line_args_disabled = value ? 1 : 0 }
    }

    var cachePath: String {
        get { return CEFStringToSwiftString(self.cefStruct.cache_path) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.cache_path) }
    }

    var userDataPath: String {
        get { return CEFStringToSwiftString(self.cefStruct.user_data_path) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.user_data_path) }
    }

    var persistSessionCookies: Bool {
        get { return self.cefStruct.persist_session_cookies != 0 }
        set(value) { self.cefStruct.persist_session_cookies = value ? 1 : 0 }
    }

    var userAgent: String {
        get { return CEFStringToSwiftString(self.cefStruct.user_agent) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.user_agent) }
    }
    
    var productVersion: String {
        get { return CEFStringToSwiftString(self.cefStruct.product_version) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.product_version) }
    }

    var locale: String {
        get { return CEFStringToSwiftString(self.cefStruct.locale) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.locale) }
    }

    var logFile: String {
        get { return CEFStringToSwiftString(self.cefStruct.log_file) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.log_file) }
    }

    var logSeverity: CEFLogSeverity {
        get { return CEFLogSeverity(rawValue: Int(self.cefStruct.log_severity.rawValue))! }
        set(value) { self.cefStruct.log_severity = cef_log_severity_t(rawValue: UInt32(value.rawValue)) }
    }

    var javascriptFlags: String {
        get { return CEFStringToSwiftString(self.cefStruct.javascript_flags) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.javascript_flags) }
    }

    var resourcesDirPath: String {
        get { return CEFStringToSwiftString(self.cefStruct.resources_dir_path) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.resources_dir_path) }
    }

    var localesDirPath: String {
        get { return CEFStringToSwiftString(self.cefStruct.locales_dir_path) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.locales_dir_path) }
    }

    var packLoadingDisabled: Bool {
        get { return self.cefStruct.pack_loading_disabled != 0 }
        set(value) { self.cefStruct.pack_loading_disabled = value ? 1 : 0 }
    }

    var remoteDebuggingPort: Int16 {
        get { return Int16(self.cefStruct.remote_debugging_port) }
        set(value) { self.cefStruct.remote_debugging_port = Int32(value) }
    }

    var uncaughtExceptionStackSize: Int {
        get { return Int(self.cefStruct.uncaught_exception_stack_size) }
        set(value) { self.cefStruct.uncaught_exception_stack_size = Int32(value) }
    }

    var contextSafetyImplementation: CEFV8ContextSafetyImplementation {
        get { return CEFV8ContextSafetyImplementation(rawValue: Int(self.cefStruct.context_safety_implementation))! }
        set(value) { self.cefStruct.context_safety_implementation = Int32(value.rawValue) }
    }

    var ignoreCertificateErrors: Bool {
        get { return self.cefStruct.ignore_certificate_errors != 0 }
        set(value) { self.cefStruct.ignore_certificate_errors = value ? 1 : 0 }
    }
    
    var backgroundColor: CEFColor {
        get { return CEFColor(argb: self.cefStruct.background_color) }
        set(value) { self.cefStruct.background_color = value.argb }
    }

    var acceptLanguageList: String {
        get { return CEFStringToSwiftString(self.cefStruct.accept_language_list) }
        set(value) { CEFStringSetFromSwiftString(value, cefString: &self.cefStruct.accept_language_list) }
    }

    deinit {
        cef_string_utf16_clear(&self.cefStruct.browser_subprocess_path)
        cef_string_utf16_clear(&self.cefStruct.cache_path)
        cef_string_utf16_clear(&self.cefStruct.user_data_path)
        cef_string_utf16_clear(&self.cefStruct.user_agent)
        cef_string_utf16_clear(&self.cefStruct.product_version)
        cef_string_utf16_clear(&self.cefStruct.locale)
        cef_string_utf16_clear(&self.cefStruct.log_file)
        cef_string_utf16_clear(&self.cefStruct.javascript_flags)
        cef_string_utf16_clear(&self.cefStruct.resources_dir_path)
        cef_string_utf16_clear(&self.cefStruct.locales_dir_path)
        cef_string_utf16_clear(&self.cefStruct.accept_language_list)
    }
    
}
