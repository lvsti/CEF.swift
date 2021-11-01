//
//  CEFDockingMode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Docking modes supported by CefWindow::AddOverlay.
/// CEF name: `cef_docking_mode_t`.
public enum CEFDockingMode: Int32 {
    /// CEF name: `CEF_DOCKING_MODE_TOP_LEFT`.
    case topLeft = 1
    /// CEF name: `CEF_DOCKING_MODE_TOP_RIGHT`.
    case topRight
    /// CEF name: `CEF_DOCKING_MODE_BOTTOM_LEFT`.
    case bottomLeft
    /// CEF name: `CEF_DOCKING_MODE_BOTTOM_RIGHT`.
    case bottomRight
    /// CEF name: `CEF_DOCKING_MODE_CUSTOM`.
    case custom
}

extension CEFDockingMode {
    static func fromCEF(_ value: cef_docking_mode_t) -> CEFDockingMode {
        return CEFDockingMode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_docking_mode_t {
        return cef_docking_mode_t(rawValue: UInt32(rawValue))
    }
}

