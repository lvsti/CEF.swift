//
//  CEFReferrerPolicy.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Policy for how the Referrer HTTP header value will be sent during navigation.
/// If the `--no-referrers` command-line flag is specified then the policy value
/// will be ignored and the Referrer value will never be sent.
/// CEF name: `cef_referrer_policy_t`.
public enum CEFReferrerPolicy: Int32 {

    /// Always send the complete Referrer value.
    /// CEF name: `REFERRER_POLICY_ALWAYS`.
    case always

    /// Use the default policy. This is REFERRER_POLICY_ORIGIN_WHEN_CROSS_ORIGIN
    /// when the `--reduced-referrer-granularity` command-line flag is specified
    /// and REFERRER_POLICY_NO_REFERRER_WHEN_DOWNGRADE otherwise.
    /// CEF name: `REFERRER_POLICY_DEFAULT`.
    case defaultPolicy

    /// When navigating from HTTPS to HTTP do not send the Referrer value.
    /// Otherwise, send the complete Referrer value.
    /// CEF name: `REFERRER_POLICY_NO_REFERRER_WHEN_DOWNGRADE`.
    case noReferrerWhenDowngrade

    /// Never send the Referrer value.
    /// CEF name: `REFERRER_POLICY_NEVER`.
    case never

    /// Only send the origin component of the Referrer value.
    /// CEF name: `REFERRER_POLICY_ORIGIN`.
    case origin

    /// When navigating cross-origin only send the origin component of the Referrer
    /// value. Otherwise, send the complete Referrer value.
    /// CEF name: `REFERRER_POLICY_ORIGIN_WHEN_CROSS_ORIGIN`.
    case originWhenCrossOrigin
}

extension CEFReferrerPolicy {
    static func fromCEF(_ value: cef_referrer_policy_t) -> CEFReferrerPolicy {
        return CEFReferrerPolicy(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_referrer_policy_t {
        return cef_referrer_policy_t(rawValue: UInt32(rawValue))
    }
}

