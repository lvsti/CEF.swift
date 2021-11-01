//
//  CEFResourceType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Resource type for a request.
/// CEF name: `cef_resource_type_t`.
public enum CEFResourceType: Int32 {

    /// Top level page.
    /// CEF name: `RT_MAIN_FRAME`.
    case mainFrame = 0

    /// Frame or iframe.
    /// CEF name: `RT_SUB_FRAME`.
    case subframe

    /// CSS stylesheet.
    /// CEF name: `RT_STYLESHEET`.
    case styleSheet

    /// External script.
    /// CEF name: `RT_SCRIPT`.
    case script

    /// Image (jpg/gif/png/etc).
    /// CEF name: `RT_IMAGE`.
    case image

    /// Font.
    /// CEF name: `RT_FONT_RESOURCE`.
    case fontResource

    /// Some other subresource. This is the default type if the actual type is
    /// unknown.
    /// CEF name: `RT_SUB_RESOURCE`.
    case subresource

    /// Object (or embed) tag for a plugin, or a resource that a plugin requested.
    /// CEF name: `RT_OBJECT`.
    case object

    /// Media resource.
    /// CEF name: `RT_MEDIA`.
    case media

    /// Main resource of a dedicated worker.
    /// CEF name: `RT_WORKER`.
    case worker

    /// Main resource of a shared worker.
    /// CEF name: `RT_SHARED_WORKER`.
    case sharedWorker

    /// Explicitly requested prefetch.
    /// CEF name: `RT_PREFETCH`.
    case prefetch

    /// Favicon.
    /// CEF name: `RT_FAVICON`.
    case favicon

    /// XMLHttpRequest.
    /// CEF name: `RT_XHR`.
    case xhr

    /// A request for a <ping>
    /// CEF name: `RT_PING`.
    case ping

    /// Main resource of a service worker.
    /// CEF name: `RT_SERVICE_WORKER`.
    case serviceWorker

    /// A report of Content Security Policy violations.
    /// CEF name: `RT_CSP_REPORT`.
    case cspReport

    /// A resource that a plugin requested.
    /// CEF name: `RT_PLUGIN_RESOURCE`.
    case pluginResource

    /// A main-frame service worker navigation preload request.
    /// CEF name: `RT_NAVIGATION_PRELOAD_MAIN_FRAME`.
    case navigationPreloadMainFrame = 19

    /// A sub-frame service worker navigation preload request.
    /// CEF name: `RT_NAVIGATION_PRELOAD_SUB_FRAME`.
    case navigationPreloadSubFrame
}

extension CEFResourceType {
    static func fromCEF(_ value: cef_resource_type_t) -> CEFResourceType {
        return CEFResourceType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_resource_type_t {
        return cef_resource_type_t(rawValue: UInt32(rawValue))
    }
}

