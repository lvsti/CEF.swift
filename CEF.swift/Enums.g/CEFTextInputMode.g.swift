//
//  CEFTextInputMode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Input mode of a virtual keyboard. These constants match their equivalents
/// in Chromium's text_input_mode.h and should not be renumbered.
/// See https://html.spec.whatwg.org/#input-modalities:-the-inputmode-attribute
/// CEF name: `cef_text_input_mode_t`.
public enum CEFTextInputMode: Int32 {
    /// CEF name: `CEF_TEXT_INPUT_MODE_DEFAULT`.
    case `default`
    /// CEF name: `CEF_TEXT_INPUT_MODE_NONE`.
    case none
    /// CEF name: `CEF_TEXT_INPUT_MODE_TEXT`.
    case text
    /// CEF name: `CEF_TEXT_INPUT_MODE_TEL`.
    case tel
    /// CEF name: `CEF_TEXT_INPUT_MODE_URL`.
    case url
    /// CEF name: `CEF_TEXT_INPUT_MODE_EMAIL`.
    case email
    /// CEF name: `CEF_TEXT_INPUT_MODE_NUMERIC`.
    case numeric
    /// CEF name: `CEF_TEXT_INPUT_MODE_DECIMAL`.
    case decimal
    /// CEF name: `CEF_TEXT_INPUT_MODE_SEARCH`.
    case search
    /// CEF name: `CEF_TEXT_INPUT_MODE_MAX`.
    public static let max: CEFTextInputMode = .search
}

extension CEFTextInputMode {
    static func fromCEF(_ value: cef_text_input_mode_t) -> CEFTextInputMode {
        return CEFTextInputMode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_text_input_mode_t {
        return cef_text_input_mode_t(rawValue: UInt32(rawValue))
    }
}

