//
//  CEFBrowserSettings.swift
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
/// CEF name: `cef_browser_settings_t`
public struct CEFBrowserSettings {
    /// The maximum rate in frames per second (fps) that CefRenderHandler::OnPaint
    /// will be called for a windowless browser. The actual fps may be lower if
    /// the browser cannot generate frames at the requested rate. The minimum
    /// value is 1 and the maximum value is 60 (default 30). This value can also be
    /// changed dynamically via CefBrowserHost::SetWindowlessFrameRate.
    /// CEF name: `windowless_frame_rate`
    public var windowlessFrameRate: Int32 = 30

    /// Font settings.
    /// CEF name: `standard_font_family`
    public var standardFontFamily: String = ""
    /// CEF name: `fixed_font_family`
    public var fixedFontFamily: String = ""
    /// CEF name: `serif_font_family`
    public var serifFontFamily: String = ""
    /// CEF name: `sans_serif_font_family`
    public var sansSerifFontFamily: String = ""
    /// CEF name: `cursive_font_family`
    public var cursiveFontFamily: String = ""
    /// CEF name: `fantasy_font_family`
    public var fantasyFontFamily: String = ""
    /// CEF name: `default_font_size`
    public var defaultFontSize: Int32 = 0
    /// CEF name: `default_fixed_font_size`
    public var defaultFixedFontSize: Int32 = 0
    /// CEF name: `minimum_font_size`
    public var minimumFontSize: Int32 = 0
    /// CEF name: `minimum_logical_font_size`
    public var minimumLogicalFontSize: Int32 = 0

    /// Default encoding for Web content. If empty "ISO-8859-1" will be used. Also
    /// configurable using the "default-encoding" command-line switch.
    /// CEF name: `default_encoding`
    public var defaultEncoding: String = ""
    
    /// Controls the loading of fonts from remote sources. Also configurable using
    /// the "disable-remote-fonts" command-line switch.
    /// CEF name: `remote_fonts`
    public var remoteFonts: CEFState = .default
    
    /// Controls whether JavaScript can be executed. Also configurable using the
    /// "disable-javascript" command-line switch.
    /// CEF name: `javascript`
    public var javascript: CEFState = .default
    
    /// Controls whether JavaScript can be used to close windows that were not
    /// opened via JavaScript. JavaScript can still be used to close windows that
    /// were opened via JavaScript or that have no back/forward history. Also
    /// configurable using the "disable-javascript-close-windows" command-line
    /// switch.
    /// CEF name: `javascript_close_windows`
    public var javascriptCloseWindows: CEFState = .default
    
    /// Controls whether JavaScript can access the clipboard. Also configurable
    /// using the "disable-javascript-access-clipboard" command-line switch.
    /// CEF name: `javascript_access_clipboard`
    public var javascriptAccessClipboard: CEFState = .default
    
    /// Controls whether DOM pasting is supported in the editor via
    /// execCommand("paste"). The |javascript_access_clipboard| setting must also
    /// be enabled. Also configurable using the "disable-javascript-dom-paste"
    /// command-line switch.
    /// CEF name: `javascript_dom_paste`
    public var javascriptDOMPaste: CEFState = .default
        
    /// Controls whether any plugins will be loaded. Also configurable using the
    /// "disable-plugins" command-line switch.
    /// CEF name: `plugins`
    public var plugins: CEFState = .default
    
    /// Controls whether image URLs will be loaded from the network. A cached image
    /// will still be rendered if requested. Also configurable using the
    /// "disable-image-loading" command-line switch.
    /// CEF name: `image_loading`
    public var imageLoading: CEFState = .default
    
    /// Controls whether standalone images will be shrunk to fit the page. Also
    /// configurable using the "image-shrink-standalone-to-fit" command-line
    /// switch.
    /// CEF name: `image_shrink_standalone_fit`
    public var imageShrinkStandaloneToFit: CEFState = .default
    
    /// Controls whether text areas can be resized. Also configurable using the
    /// "disable-text-area-resize" command-line switch.
    /// CEF name: `text_area_resize`
    public var textAreaResize: CEFState = .default
    
    /// Controls whether the tab key can advance focus to links. Also configurable
    /// using the "disable-tab-to-links" command-line switch.
    /// CEF name: `tab_to_links`
    public var tabToLinks: CEFState = .default
    
    /// Controls whether local storage can be used. Also configurable using the
    /// "disable-local-storage" command-line switch.
    /// CEF name: `local_storage`
    public var localStorage: CEFState = .default
    
    /// Controls whether databases can be used. Also configurable using the
    /// "disable-databases" command-line switch.
    /// CEF name: `databases`
    public var databases: CEFState = .default
    
    /// Controls whether WebGL can be used. Note that WebGL requires hardware
    /// support and may not work on all systems even when enabled. Also
    /// configurable using the "disable-webgl" command-line switch.
    /// CEF name: `webgl`
    public var webGL: CEFState = .default
    
    /// Background color used for the browser before a document is loaded and when
    /// no document color is specified. The alpha component must be either fully
    /// opaque (0xFF) or fully transparent (0x00). If the alpha component is fully
    /// opaque then the RGB components will be used as the background color. If the
    /// alpha component is fully transparent for a windowed browser then the
    /// CefSettings.background_color value will be used. If the alpha component is
    /// fully transparent for a windowless (off-screen) browser then transparent
    /// painting will be enabled.
    /// CEF name: `background_color`
    public var backgroundColor: CEFColor = CEFColor(argb: 0)
    
    /// Comma delimited ordered list of language codes without any whitespace that
    /// will be used in the "Accept-Language" HTTP header. May be set globally
    /// using the CefSettings.accept_language_list value. If both values are
    /// empty then "en-US,en" will be used.
    /// CEF name: `accept_language_list`
    public var acceptLanguageList: String = ""

    public init() {
    }
}

extension CEFBrowserSettings {
    func toCEF() -> cef_browser_settings_t {
        var cefStruct = cef_browser_settings_t()
        
        cefStruct.size = MemoryLayout<cef_browser_settings_t>.stride
        
        cefStruct.windowless_frame_rate = windowlessFrameRate
        CEFStringSetFromSwiftString(standardFontFamily, cefStringPtr: &cefStruct.standard_font_family)
        CEFStringSetFromSwiftString(fixedFontFamily, cefStringPtr: &cefStruct.fixed_font_family)
        CEFStringSetFromSwiftString(serifFontFamily, cefStringPtr: &cefStruct.serif_font_family)
        CEFStringSetFromSwiftString(sansSerifFontFamily, cefStringPtr: &cefStruct.sans_serif_font_family)
        CEFStringSetFromSwiftString(cursiveFontFamily, cefStringPtr: &cefStruct.cursive_font_family)
        CEFStringSetFromSwiftString(fantasyFontFamily, cefStringPtr: &cefStruct.fantasy_font_family)
        cefStruct.default_font_size = defaultFontSize
        cefStruct.default_fixed_font_size = defaultFixedFontSize
        cefStruct.minimum_font_size = minimumFontSize
        cefStruct.minimum_logical_font_size = minimumLogicalFontSize
        CEFStringSetFromSwiftString(defaultEncoding, cefStringPtr: &cefStruct.default_encoding)
        cefStruct.remote_fonts = remoteFonts.toCEF()
        cefStruct.javascript = javascript.toCEF()
        cefStruct.javascript_close_windows = javascriptCloseWindows.toCEF()
        cefStruct.javascript_access_clipboard = javascriptAccessClipboard.toCEF()
        cefStruct.javascript_dom_paste = javascriptDOMPaste.toCEF()
        cefStruct.plugins = plugins.toCEF()
        cefStruct.image_loading = imageLoading.toCEF()
        cefStruct.image_shrink_standalone_to_fit = imageShrinkStandaloneToFit.toCEF()
        cefStruct.text_area_resize = textAreaResize.toCEF()
        cefStruct.tab_to_links = tabToLinks.toCEF()
        cefStruct.local_storage = localStorage.toCEF()
        cefStruct.databases = databases.toCEF()
        cefStruct.webgl = webGL.toCEF()
        cefStruct.background_color = backgroundColor.toCEF()
        CEFStringSetFromSwiftString(acceptLanguageList, cefStringPtr: &cefStruct.accept_language_list)
        
        return cefStruct
    }
    
    static func fromCEF(_ value: cef_browser_settings_t) -> CEFBrowserSettings {
        var settings = CEFBrowserSettings()
        
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
        settings.remoteFonts = CEFState.fromCEF(value.remote_fonts)
        settings.javascript = CEFState.fromCEF(value.javascript)
        settings.javascriptCloseWindows = CEFState.fromCEF(value.javascript_close_windows)
        settings.javascriptAccessClipboard = CEFState.fromCEF(value.javascript_access_clipboard)
        settings.javascriptDOMPaste = CEFState.fromCEF(value.javascript_dom_paste)
        settings.plugins = CEFState.fromCEF(value.plugins)
        settings.imageLoading = CEFState.fromCEF(value.image_loading)
        settings.imageShrinkStandaloneToFit = CEFState.fromCEF(value.image_shrink_standalone_to_fit)
        settings.textAreaResize = CEFState.fromCEF(value.text_area_resize)
        settings.tabToLinks = CEFState.fromCEF(value.tab_to_links)
        settings.localStorage = CEFState.fromCEF(value.local_storage)
        settings.databases = CEFState.fromCEF(value.databases)
        settings.webGL = CEFState.fromCEF(value.webgl)
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
