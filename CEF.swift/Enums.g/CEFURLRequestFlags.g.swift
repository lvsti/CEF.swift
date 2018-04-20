//
//  CEFURLRequestFlags.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Flags used to customize the behavior of CefURLRequest.
/// CEF name: `cef_urlrequest_flags_t`.
public struct CEFURLRequestFlags: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Default behavior.
    /// CEF name: `UR_FLAG_NONE`.
    public static let none = CEFURLRequestFlags(rawValue: 0)

    /// If set the cache will be skipped when handling the request. Setting this
    /// value is equivalent to specifying the "Cache-Control: no-cache" request
    /// header. Setting this value in combination with UR_FLAG_ONLY_FROM_CACHE will
    /// cause the request to fail.
    /// CEF name: `UR_FLAG_SKIP_CACHE`.
    public static let skipCache = CEFURLRequestFlags(rawValue: 1 << 0)

    /// If set the request will fail if it cannot be served from the cache (or some
    /// equivalent local store). Setting this value is equivalent to specifying the
    /// "Cache-Control: only-if-cached" request header. Setting this value in
    /// combination with UR_FLAG_SKIP_CACHE will cause the request to fail.
    /// CEF name: `UR_FLAG_ONLY_FROM_CACHE`.
    public static let onlyFromCache = CEFURLRequestFlags(rawValue: 1 << 1)

    /// If set user name, password, and cookies may be sent with the request, and
    /// cookies may be saved from the response.
    /// CEF name: `UR_FLAG_ALLOW_STORED_CREDENTIALS`.
    public static let allowStoredCredentials = CEFURLRequestFlags(rawValue: 1 << 2)

    /// If set upload progress events will be generated when a request has a body.
    /// CEF name: `UR_FLAG_REPORT_UPLOAD_PROGRESS`.
    public static let reportUploadProgress = CEFURLRequestFlags(rawValue: 1 << 3)

    /// If set the CefURLRequestClient::OnDownloadData method will not be called.
    /// CEF name: `UR_FLAG_NO_DOWNLOAD_DATA`.
    public static let noDownloadData = CEFURLRequestFlags(rawValue: 1 << 4)

    /// If set 5XX redirect errors will be propagated to the observer instead of
    /// automatically re-tried. This currently only applies for requests
    /// originated in the browser process.
    /// CEF name: `UR_FLAG_NO_RETRY_ON_5XX`.
    public static let noRetryOn5XX = CEFURLRequestFlags(rawValue: 1 << 5)

    /// If set 3XX responses will cause the fetch to halt immediately rather than
    /// continue through the redirect.
    /// CEF name: `UR_FLAG_STOP_ON_REDIRECT`.
    public static let stopOnRedirect = CEFURLRequestFlags(rawValue: 1 << 6)
}

extension CEFURLRequestFlags {
    static func fromCEF(_ value: cef_urlrequest_flags_t) -> CEFURLRequestFlags {
        return CEFURLRequestFlags(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_urlrequest_flags_t {
        return cef_urlrequest_flags_t(rawValue: UInt32(rawValue))
    }
}

