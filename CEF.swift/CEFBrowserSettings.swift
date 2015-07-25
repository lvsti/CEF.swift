//
//  CEFBrowserSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFState: Int {
    case Default = 0
    case Enabled
    case Disabled
    
    func toCEF() -> cef_state_t {
        return cef_state_t(rawValue: UInt32(self.rawValue))
    }
}

public struct CEFBrowserSettings {
    public var windowlessFrameRate: Int = 30
    public var standardFontFamily: String = ""
    public var fixedFontFamily: String = ""
    public var serifFontFamily: String = ""
    public var sansSerifFontFamily: String = ""
    public var cursiveFontFamily: String = ""
    public var fantasyFontFamily: String = ""
    public var defaultFontSize: Int = 0
    public var defaultFixedFontSize: Int = 0
    public var minimumFontSize: Int = 0
    public var minimumLogicalFontSize: Int = 0
    public var defaultEncoding: String = ""
    public var remoteFonts: CEFState = .Default
    public var javascript: CEFState = .Default
    public var javascriptOpenWindows: CEFState = .Default
    public var javascriptCloseWindows: CEFState = .Default
    public var javascriptAccessClipboard: CEFState = .Default
    public var javascriptDOMPaste: CEFState = .Default
    public var caretBrowsing: CEFState = .Default
    public var java: CEFState = .Default
    public var plugins: CEFState = .Default
    public var universalAccessFromFileURLs: CEFState = .Default
    public var fileAccessFromFileURLs: CEFState = .Default
    public var webSecurity: CEFState = .Default
    public var imageLoading: CEFState = .Default
    public var imageShrinkStandaloneToFit: CEFState = .Default
    public var textAreaResize: CEFState = .Default
    public var tabToLinks: CEFState = .Default
    public var localStorage: CEFState = .Default
    public var databases: CEFState = .Default
    public var applicationCache: CEFState = .Default
    public var webGL: CEFState = .Default
    public var backgroundColor: CEFColor = CEFColor(argb: 0)
    public var acceptLanguageList: String = ""

    public func toCEF() -> cef_browser_settings_t {
        var cefStruct = cef_browser_settings_t()
        
        cefStruct.size = sizeof(cef_browser_settings_t)
        
        cefStruct.windowless_frame_rate = Int32(windowlessFrameRate)
        CEFStringSetFromSwiftString(standardFontFamily, cefString: &cefStruct.standard_font_family)
        CEFStringSetFromSwiftString(fixedFontFamily, cefString: &cefStruct.fixed_font_family)
        CEFStringSetFromSwiftString(serifFontFamily, cefString: &cefStruct.serif_font_family)
        CEFStringSetFromSwiftString(sansSerifFontFamily, cefString: &cefStruct.sans_serif_font_family)
        CEFStringSetFromSwiftString(cursiveFontFamily, cefString: &cefStruct.cursive_font_family)
        CEFStringSetFromSwiftString(fantasyFontFamily, cefString: &cefStruct.fantasy_font_family)
        cefStruct.default_font_size = Int32(defaultFontSize)
        cefStruct.default_fixed_font_size = Int32(defaultFixedFontSize)
        cefStruct.minimum_font_size = Int32(minimumFontSize)
        cefStruct.minimum_logical_font_size = Int32(minimumLogicalFontSize)
        CEFStringSetFromSwiftString(defaultEncoding, cefString: &cefStruct.default_encoding)
        cefStruct.remote_fonts = remoteFonts.toCEF()
        cefStruct.javascript = javascript.toCEF()
        cefStruct.javascript_open_windows = javascriptOpenWindows.toCEF()
        cefStruct.javascript_close_windows = javascriptCloseWindows.toCEF()
        cefStruct.javascript_access_clipboard = javascriptAccessClipboard.toCEF()
        cefStruct.javascript_dom_paste = javascriptDOMPaste.toCEF()
        cefStruct.caret_browsing = caretBrowsing.toCEF()
        cefStruct.java = java.toCEF()
        cefStruct.plugins = plugins.toCEF()
        cefStruct.universal_access_from_file_urls = universalAccessFromFileURLs.toCEF()
        cefStruct.file_access_from_file_urls = fileAccessFromFileURLs.toCEF()
        cefStruct.web_security = webSecurity.toCEF()
        cefStruct.image_loading = imageLoading.toCEF()
        cefStruct.image_shrink_standalone_to_fit = imageShrinkStandaloneToFit.toCEF()
        cefStruct.text_area_resize = textAreaResize.toCEF()
        cefStruct.tab_to_links = tabToLinks.toCEF()
        cefStruct.local_storage = localStorage.toCEF()
        cefStruct.databases = databases.toCEF()
        cefStruct.application_cache = applicationCache.toCEF()
        cefStruct.webgl = webGL.toCEF()
        cefStruct.background_color = backgroundColor.argb
        CEFStringSetFromSwiftString(acceptLanguageList, cefString: &cefStruct.accept_language_list)
        
        return cefStruct
    }
    
    public init() {
    }
}

extension cef_browser_settings_t {
    public mutating func clear() {
        cef_string_utf16_clear(&standard_font_family)
        cef_string_utf16_clear(&fixed_font_family)
        cef_string_utf16_clear(&serif_font_family)
        cef_string_utf16_clear(&sans_serif_font_family)
        cef_string_utf16_clear(&cursive_font_family)
        cef_string_utf16_clear(&fantasy_font_family)
        cef_string_utf16_clear(&default_encoding)
        cef_string_utf16_clear(&accept_language_list)
    }
}
