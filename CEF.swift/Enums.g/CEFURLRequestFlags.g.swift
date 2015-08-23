//
//  CEFURLRequestFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Flags used to customize the behavior of CefURLRequest.
public struct CEFURLRequestFlags: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Default behavior.
    public static let None = CEFURLRequestFlags(rawValue: 0)

    /// If set the cache will be skipped when handling the request.
    public static let SkipCache = CEFURLRequestFlags(rawValue: 1 << 0)

    /// If set user name, password, and cookies may be sent with the request, and
    /// cookies may be saved from the response.
    public static let AllowCachedCredentials = CEFURLRequestFlags(rawValue: 1 << 1)

    /// If set upload progress events will be generated when a request has a body.
    public static let ReportUploadProgress = CEFURLRequestFlags(rawValue: 1 << 3)

    /// If set the headers sent and received for the request will be recorded.
    public static let ReportRawHeaders = CEFURLRequestFlags(rawValue: 1 << 5)

    /// If set the CefURLRequestClient::OnDownloadData method will not be called.
    public static let NoDownloadData = CEFURLRequestFlags(rawValue: 1 << 6)

    /// If set 5XX redirect errors will be propagated to the observer instead of
    /// automatically re-tried. This currently only applies for requests
    /// originated in the browser process.
    public static let NoRetryOn5XX = CEFURLRequestFlags(rawValue: 1 << 7)
}

extension CEFURLRequestFlags {
    static func fromCEF(value: cef_urlrequest_flags_t) -> CEFURLRequestFlags {
        return CEFURLRequestFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_urlrequest_flags_t {
        return cef_urlrequest_flags_t(rawValue: UInt32(rawValue))
    }
}

