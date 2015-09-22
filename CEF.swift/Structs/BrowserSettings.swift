//
//  BrowserSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Browser initialization settings. Specify NULL or 0 to get the recommended
/// default values. The consequences of using custom values may not be well
/// tested. Many of these and other settings can also configured using command-
/// line switches.
public struct BrowserSettings {
    /// The maximum rate in frames per second (fps) that CefRenderHandler::OnPaint
    /// will be called for a windowless browser. The actual fps may be lower if
    /// the browser cannot generate frames at the requested rate. The minimum
    /// value is 1 and the maximum value is 60 (default 30).
    public var windowlessFrameRate: Int32 = 30

    /// Font settings.
    public var standardFontFamily: String = ""
    public var fixedFontFamily: String = ""
    public var serifFontFamily: String = ""
    public var sansSerifFontFamily: String = ""
    public var cursiveFontFamily: String = ""
    public var fantasyFontFamily: String = ""
    public var defaultFontSize: Int32 = 0
    public var defaultFixedFontSize: Int32 = 0
    public var minimumFontSize: Int32 = 0
    public var minimumLogicalFontSize: Int32 = 0

    /// Default encoding for Web content. If empty "ISO-8859-1" will be used. Also
    /// configurable using the "default-encoding" command-line switch.
    public var defaultEncoding: String = ""
    
    /// Controls the loading of fonts from remote sources. Also configurable using
    /// the "disable-remote-fonts" command-line switch.
    public var remoteFonts: CEFState = .Default
    
    /// Controls whether JavaScript can be executed. Also configurable using the
    /// "disable-javascript" command-line switch.
    public var javascript: CEFState = .Default
    
    /// Controls whether JavaScript can be used for opening windows. Also
    /// configurable using the "disable-javascript-open-windows" command-line
    /// switch.
    public var javascriptOpenWindows: CEFState = .Default
    
    /// Controls whether JavaScript can be used to close windows that were not
    /// opened via JavaScript. JavaScript can still be used to close windows that
    /// were opened via JavaScript or that have no back/forward history. Also
    /// configurable using the "disable-javascript-close-windows" command-line
    /// switch.
    public var javascriptCloseWindows: CEFState = .Default
    
    /// Controls whether JavaScript can access the clipboard. Also configurable
    /// using the "disable-javascript-access-clipboard" command-line switch.
    public var javascriptAccessClipboard: CEFState = .Default
    
    /// Controls whether DOM pasting is supported in the editor via
    /// execCommand("paste"). The |javascript_access_clipboard| setting must also
    /// be enabled. Also configurable using the "disable-javascript-dom-paste"
    /// command-line switch.
    public var javascriptDOMPaste: CEFState = .Default
    
    /// Controls whether the caret position will be drawn. Also configurable using
    /// the "enable-caret-browsing" command-line switch.
    public var caretBrowsing: CEFState = .Default
    
    /// Controls whether the Java plugin will be loaded. Also configurable using
    /// the "disable-java" command-line switch.
    public var java: CEFState = .Default
    
    /// Controls whether any plugins will be loaded. Also configurable using the
    /// "disable-plugins" command-line switch.
    public var plugins: CEFState = .Default
    
    /// Controls whether file URLs will have access to all URLs. Also configurable
    /// using the "allow-universal-access-from-files" command-line switch.
    public var universalAccessFromFileURLs: CEFState = .Default
    
    /// Controls whether file URLs will have access to other file URLs. Also
    /// configurable using the "allow-access-from-files" command-line switch.
    public var fileAccessFromFileURLs: CEFState = .Default

    /// Controls whether web security restrictions (same-origin policy) will be
    /// enforced. Disabling this setting is not recommend as it will allow risky
    /// security behavior such as cross-site scripting (XSS). Also configurable
    /// using the "disable-web-security" command-line switch.
    public var webSecurity: CEFState = .Default
    
    /// Controls whether image URLs will be loaded from the network. A cached image
    /// will still be rendered if requested. Also configurable using the
    /// "disable-image-loading" command-line switch.
    public var imageLoading: CEFState = .Default
    
    /// Controls whether standalone images will be shrunk to fit the page. Also
    /// configurable using the "image-shrink-standalone-to-fit" command-line
    /// switch.
    public var imageShrinkStandaloneToFit: CEFState = .Default
    
    /// Controls whether text areas can be resized. Also configurable using the
    /// "disable-text-area-resize" command-line switch.
    public var textAreaResize: CEFState = .Default
    
    /// Controls whether the tab key can advance focus to links. Also configurable
    /// using the "disable-tab-to-links" command-line switch.
    public var tabToLinks: CEFState = .Default
    
    /// Controls whether local storage can be used. Also configurable using the
    /// "disable-local-storage" command-line switch.
    public var localStorage: CEFState = .Default
    
    /// Controls whether databases can be used. Also configurable using the
    /// "disable-databases" command-line switch.
    public var databases: CEFState = .Default
    
    /// Controls whether the application cache can be used. Also configurable using
    /// the "disable-application-cache" command-line switch.
    public var applicationCache: CEFState = .Default
    
    /// Controls whether WebGL can be used. Note that WebGL requires hardware
    /// support and may not work on all systems even when enabled. Also
    /// configurable using the "disable-webgl" command-line switch.
    public var webGL: CEFState = .Default
    
    /// Opaque background color used for the browser before a document is loaded
    /// and when no document color is specified. By default the background color
    /// will be the same as CefSettings.background_color. Only the RGB compontents
    /// of the specified value will be used. The alpha component must greater than
    /// 0 to enable use of the background color but will be otherwise ignored.
    public var backgroundColor: CEFColor = CEFColor(argb: 0)
    
    /// Comma delimited ordered list of language codes without any whitespace that
    /// will be used in the "Accept-Language" HTTP header. May be set globally
    /// using the CefBrowserSettings.accept_language_list value. If both values are
    /// empty then "en-US,en" will be used.
    public var acceptLanguageList: String = ""

    public init() {
    }
}

extension BrowserSettings {
    func toCEF() -> cef_browser_settings_t {
        var cefStruct = cef_browser_settings_t()
        
        cefStruct.size = strideof(cef_browser_settings_t)
        
        cefStruct.windowless_frame_rate = windowlessFrameRate
        CEFStringSetFromSwiftString(standardFontFamily, cefString: &cefStruct.standard_font_family)
        CEFStringSetFromSwiftString(fixedFontFamily, cefString: &cefStruct.fixed_font_family)
        CEFStringSetFromSwiftString(serifFontFamily, cefString: &cefStruct.serif_font_family)
        CEFStringSetFromSwiftString(sansSerifFontFamily, cefString: &cefStruct.sans_serif_font_family)
        CEFStringSetFromSwiftString(cursiveFontFamily, cefString: &cefStruct.cursive_font_family)
        CEFStringSetFromSwiftString(fantasyFontFamily, cefString: &cefStruct.fantasy_font_family)
        cefStruct.default_font_size = defaultFontSize
        cefStruct.default_fixed_font_size = defaultFixedFontSize
        cefStruct.minimum_font_size = minimumFontSize
        cefStruct.minimum_logical_font_size = minimumLogicalFontSize
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
        cefStruct.background_color = backgroundColor.toCEF()
        CEFStringSetFromSwiftString(acceptLanguageList, cefString: &cefStruct.accept_language_list)
        
        return cefStruct
    }
    
    static func fromCEF(value: cef_browser_settings_t) -> BrowserSettings {
        var settings = BrowserSettings()
        
        settings.windowlessFrameRate = value.windowless_frame_rate
        settings.standardFontFamily = CEFStringToSwiftString(value.standard_font_family)
        settings.fixedFontFamily = CEFStringToSwiftString(value.fixed_font_family)
        settings.serifFontFamily = CEFStringToSwiftString(value.serif_font_family)
        settings.sansSerifFontFamily = CEFStringToSwiftString(value.sans_serif_font_family)
        settings.cursiveFontFamily = CEFStringToSwiftString(value.cursive_font_family)
        settings.fantasyFontFamily = CEFStringToSwiftString(value.fantasy_font_family)
        settings.defaultFontSize = value.default_font_size
        settings.defaultFixedFontSize = value.default_fixed_font_size
        settings.minimumFontSize = value.minimum_font_size
        settings.minimumLogicalFontSize = value.minimum_logical_font_size
        settings.defaultEncoding = CEFStringToSwiftString(value.default_encoding)
        settings.remoteFonts = State.fromCEF(value.remote_fonts)
        settings.javascript = State.fromCEF(value.javascript)
        settings.javascriptOpenWindows = State.fromCEF(value.javascript_open_windows)
        settings.javascriptCloseWindows = State.fromCEF(value.javascript_close_windows)
        settings.javascriptAccessClipboard = State.fromCEF(value.javascript_access_clipboard)
        settings.javascriptDOMPaste = State.fromCEF(value.javascript_dom_paste)
        settings.caretBrowsing = State.fromCEF(value.caret_browsing)
        settings.java = State.fromCEF(value.java)
        settings.plugins = State.fromCEF(value.plugins)
        settings.universalAccessFromFileURLs = State.fromCEF(value.universal_access_from_file_urls)
        settings.fileAccessFromFileURLs = State.fromCEF(value.file_access_from_file_urls)
        settings.webSecurity = State.fromCEF(value.web_security)
        settings.imageLoading = State.fromCEF(value.image_loading)
        settings.imageShrinkStandaloneToFit = State.fromCEF(value.image_shrink_standalone_to_fit)
        settings.textAreaResize = State.fromCEF(value.text_area_resize)
        settings.tabToLinks = State.fromCEF(value.tab_to_links)
        settings.localStorage = State.fromCEF(value.local_storage)
        settings.databases = State.fromCEF(value.databases)
        settings.applicationCache = State.fromCEF(value.application_cache)
        settings.webGL = State.fromCEF(value.webgl)
        settings.backgroundColor = CEFColor(argb: value.background_color)
        settings.acceptLanguageList = CEFStringToSwiftString(value.accept_language_list)
        
        return settings
    }
}

extension cef_browser_settings_t {
    mutating func clear() {
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
