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
    case MainFrame = 0

    /// Frame or iframe.
    case Subframe

    /// CSS stylesheet.
    case StyleSheet

    /// External script.
    case Script

    /// Image (jpg/gif/png/etc).
    case Image

    /// Font.
    case FontResource

    /// Some other subresource. This is the default type if the actual type is
    /// unknown.
    case Subresource

    /// Object (or embed) tag for a plugin, or a resource that a plugin requested.
    case Object

    /// Media resource.
    case Media

    /// Main resource of a dedicated worker.
    case Worker

    /// Main resource of a shared worker.
    case SharedWorker

    /// Explicitly requested prefetch.
    case Prefetch

    /// Favicon.
    case Favicon

    /// XMLHttpRequest.
    case XHR

    /// A request for a <ping>
    case Ping

    /// Main resource of a service worker.
    case ServiceWorker
    
    /// A report of Content Security Policy violations.
    case CSPReport
    
    /// A resource that a plugin requested.
    case PluginResource
}

extension CEFResourceType {
    static func fromCEF(value: cef_resource_type_t) -> CEFResourceType {
        return CEFResourceType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_resource_type_t {
        return cef_resource_type_t(rawValue: UInt32(rawValue))
    }
}

