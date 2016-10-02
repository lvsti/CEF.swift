//
//  CEFPluginPolicy.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Plugin policies supported by CefRequestContextHandler::OnBeforePluginLoad.
public enum CEFPluginPolicy: Int32 {

    /// Allow the content.
    case allow

    /// Allow important content and block unimportant content based on heuristics.
    /// The user can manually load blocked content.
    case detectImportant

    /// Block the content. The user can manually load blocked content.
    case block

    /// Disable the content. The user cannot load disabled content.
    case disable
}

extension CEFPluginPolicy {
    static func fromCEF(value: cef_plugin_policy_t) -> CEFPluginPolicy {
        return CEFPluginPolicy(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_plugin_policy_t {
        return cef_plugin_policy_t(rawValue: UInt32(rawValue))
    }
}

