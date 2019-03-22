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
/// Must be kept synchronized with net::URLRequest::ReferrerPolicy from Chromium.
/// CEF name: `cef_referrer_policy_t`.
public enum CEFReferrerPolicy: Int32 {

    /// Clear the referrer header if the header value is HTTPS but the request
    /// destination is HTTP. This is the default behavior.
    /// CEF name: `REFERRER_POLICY_CLEAR_REFERRER_ON_TRANSITION_FROM_SECURE_TO_INSECURE`.
    case clearReferrerOnTransitionFromSecureToInsecure

    /// A slight variant on CLEAR_REFERRER_ON_TRANSITION_FROM_SECURE_TO_INSECURE:
    /// If the request destination is HTTP, an HTTPS referrer will be cleared. If
    /// the request's destination is cross-origin with the referrer (but does not
    /// downgrade), the referrer's granularity will be stripped down to an origin
    /// rather than a full URL. Same-origin requests will send the full referrer.
    /// CEF name: `REFERRER_POLICY_REDUCE_REFERRER_GRANULARITY_ON_TRANSITION_CROSS_ORIGIN`.
    case reduceReferrerGranularityOnTransitionCrossOrigin

    /// Strip the referrer down to an origin when the origin of the referrer is
    /// different from the destination's origin.
    /// CEF name: `REFERRER_POLICY_ORIGIN_ONLY_ON_TRANSITION_CROSS_ORIGIN`.
    case originOnlyOnTransitionCrossOrigin

    /// Never change the referrer.
    /// CEF name: `REFERRER_POLICY_NEVER_CLEAR_REFERRER`.
    case neverClearReferrer

    /// Strip the referrer down to the origin regardless of the redirect location.
    /// CEF name: `REFERRER_POLICY_ORIGIN`.
    case origin

    /// Clear the referrer when the request's referrer is cross-origin with the
    /// request's destination.
    /// CEF name: `REFERRER_POLICY_CLEAR_REFERRER_ON_TRANSITION_CROSS_ORIGIN`.
    case clearReferrerOnTransitionCrossOrigin

    /// Strip the referrer down to the origin, but clear it entirely if the
    /// referrer value is HTTPS and the destination is HTTP.
    /// CEF name: `REFERRER_POLICY_ORIGIN_CLEAR_ON_TRANSITION_FROM_SECURE_TO_INSECURE`.
    case originClearOnTransitionFromSecureToInsecure

    /// Always clear the referrer regardless of the request destination.
    /// CEF name: `REFERRER_POLICY_NO_REFERRER`.
    case noReferrer
    
    /// CEF name: `REFERRER_POLICY_DEFAULT`.
    public static let `default`: CEFReferrerPolicy = .clearReferrerOnTransitionFromSecureToInsecure

    /// Always the last value in this enumeration.
    /// CEF name: `REFERRER_POLICY_LAST_VALUE`.
    public static let lastValue: CEFReferrerPolicy = .noReferrer
}

extension CEFReferrerPolicy {
    static func fromCEF(_ value: cef_referrer_policy_t) -> CEFReferrerPolicy {
        return CEFReferrerPolicy(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_referrer_policy_t {
        return cef_referrer_policy_t(rawValue: UInt32(rawValue))
    }
}

