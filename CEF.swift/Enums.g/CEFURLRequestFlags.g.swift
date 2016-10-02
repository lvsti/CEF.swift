//
//  CEFURLRequestFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Flags used to customize the behavior of CefURLRequest.
public struct CEFURLRequestFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Default behavior.
    public static let none = CEFURLRequestFlags(rawValue: 0)

    /// If set the cache will be skipped when handling the request.
    public static let skipCache = CEFURLRequestFlags(rawValue: 1 << 0)

    /// If set user name, password, and cookies may be sent with the request, and
    /// cookies may be saved from the response.
    public static let allowCachedCredentials = CEFURLRequestFlags(rawValue: 1 << 1)

    /// If set upload progress events will be generated when a request has a body.
    public static let reportUploadProgress = CEFURLRequestFlags(rawValue: 1 << 3)

    /// If set the CefURLRequestClient::OnDownloadData method will not be called.
    public static let noDownloadData = CEFURLRequestFlags(rawValue: 1 << 6)

    /// If set 5XX redirect errors will be propagated to the observer instead of
    /// automatically re-tried. This currently only applies for requests
    /// originated in the browser process.
    public static let noRetryOn5XX = CEFURLRequestFlags(rawValue: 1 << 7)
}

extension CEFURLRequestFlags {
    static func fromCEF(_ value: cef_urlrequest_flags_t) -> CEFURLRequestFlags {
        return CEFURLRequestFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_urlrequest_flags_t {
        return cef_urlrequest_flags_t(rawValue: UInt32(rawValue))
    }
}

