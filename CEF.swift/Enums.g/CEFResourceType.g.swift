//
//  CEFResourceType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Resource type for a request.
public enum CEFResourceType: Int32 {

    /// Top level page.
    case mainFrame = 0

    /// Frame or iframe.
    case subframe

    /// CSS stylesheet.
    case styleSheet

    /// External script.
    case script

    /// Image (jpg/gif/png/etc).
    case image

    /// Font.
    case fontResource

    /// Some other subresource. This is the default type if the actual type is
    /// unknown.
    case subresource

    /// Object (or embed) tag for a plugin, or a resource that a plugin requested.
    case object

    /// Media resource.
    case media

    /// Main resource of a dedicated worker.
    case worker

    /// Main resource of a shared worker.
    case sharedWorker

    /// Explicitly requested prefetch.
    case prefetch

    /// Favicon.
    case favicon

    /// XMLHttpRequest.
    case xhr

    /// A request for a <ping>
    case ping

    /// Main resource of a service worker.
    case serviceWorker

    /// A report of Content Security Policy violations.
    case cspReport

    /// A resource that a plugin requested.
    case pluginResource
}

extension CEFResourceType {
    static func fromCEF(_ value: cef_resource_type_t) -> CEFResourceType {
        return CEFResourceType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_resource_type_t {
        return cef_resource_type_t(rawValue: UInt32(rawValue))
    }
}

