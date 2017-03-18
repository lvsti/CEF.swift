//
//  CEFCDMRegistrationError.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Error codes for CDM registration. See cef_web_plugin.h for details.
/// CEF name: `cef_cdm_registration_error_t`.
public enum CEFCDMRegistrationError: Int32 {

    /// No error. Registration completed successfully.
    /// CEF name: `CEF_CDM_REGISTRATION_ERROR_NONE`.
    case none

    /// Required files or manifest contents are missing.
    /// CEF name: `CEF_CDM_REGISTRATION_ERROR_INCORRECT_CONTENTS`.
    case incorrectContents

    /// The CDM is incompatible with the current Chromium version.
    /// CEF name: `CEF_CDM_REGISTRATION_ERROR_INCOMPATIBLE`.
    case incompatible

    /// CDM registration is not supported at this time.
    /// CEF name: `CEF_CDM_REGISTRATION_ERROR_NOT_SUPPORTED`.
    case notSupported
}

extension CEFCDMRegistrationError {
    static func fromCEF(_ value: cef_cdm_registration_error_t) -> CEFCDMRegistrationError {
        return CEFCDMRegistrationError(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_cdm_registration_error_t {
        return cef_cdm_registration_error_t(rawValue: UInt32(rawValue))
    }
}

