//
//  ErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported error code values. See net\base\net_error_list.h for complete
/// descriptions of the error codes.
public struct ErrorCode: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let None = ErrorCode(rawValue: 0)
    public static let Failed = ErrorCode(rawValue: -2)
    public static let Aborted = ErrorCode(rawValue: -3)
    public static let InvalidArgument = ErrorCode(rawValue: -4)
    public static let InvalidHandle = ErrorCode(rawValue: -5)
    public static let FileNotFound = ErrorCode(rawValue: -6)
    public static let TimedOut = ErrorCode(rawValue: -7)
    public static let FileTooBig = ErrorCode(rawValue: -8)
    public static let Unexpected = ErrorCode(rawValue: -9)
    public static let AccessDenied = ErrorCode(rawValue: -10)
    public static let NotImplemented = ErrorCode(rawValue: -11)
    public static let ConnectionClosed = ErrorCode(rawValue: -100)
    public static let ConnectionReset = ErrorCode(rawValue: -101)
    public static let ConnectionRefused = ErrorCode(rawValue: -102)
    public static let ConnectionAborted = ErrorCode(rawValue: -103)
    public static let ConnectionFailed = ErrorCode(rawValue: -104)
    public static let NameNotResolved = ErrorCode(rawValue: -105)
    public static let InternetDisconnected = ErrorCode(rawValue: -106)
    public static let SSLProtocolError = ErrorCode(rawValue: -107)
    public static let AddressInvalid = ErrorCode(rawValue: -108)
    public static let AddressUnreachable = ErrorCode(rawValue: -109)
    public static let SSLClientAuthCertNeeded = ErrorCode(rawValue: -110)
    public static let TunnelConnectionFailed = ErrorCode(rawValue: -111)
    public static let NoSSLVersionsEnabled = ErrorCode(rawValue: -112)
    public static let SSLVersionOrCipherMismatch = ErrorCode(rawValue: -113)
    public static let SSLRenegotiationRequested = ErrorCode(rawValue: -114)
    public static let CertCommonNameInvalid = ErrorCode(rawValue: -200)
    public static let CertDateInvalid = ErrorCode(rawValue: -201)
    public static let CertAuthorityInvalid = ErrorCode(rawValue: -202)
    public static let CertContainsErrors = ErrorCode(rawValue: -203)
    public static let CertNoRevocationMechanism = ErrorCode(rawValue: -204)
    public static let CertUnableToCheckRevocation = ErrorCode(rawValue: -205)
    public static let CertRevoked = ErrorCode(rawValue: -206)
    public static let CertInvalid = ErrorCode(rawValue: -207)
    public static let CertEnd = ErrorCode(rawValue: -208)
    public static let InvalidURL = ErrorCode(rawValue: -300)
    public static let DisallowedURLScheme = ErrorCode(rawValue: -301)
    public static let UnknownURLScheme = ErrorCode(rawValue: -302)
    public static let TooManyRedirects = ErrorCode(rawValue: -310)
    public static let UnsafeRedirect = ErrorCode(rawValue: -311)
    public static let UnsafePort = ErrorCode(rawValue: -312)
    public static let InvalidResponse = ErrorCode(rawValue: -320)
    public static let InvalidChunkedEncoding = ErrorCode(rawValue: -321)
    public static let MethodNotSupported = ErrorCode(rawValue: -322)
    public static let UnexpectedProxyAuth = ErrorCode(rawValue: -323)
    public static let EmptyResponse = ErrorCode(rawValue: -324)
    public static let ResponseHeadersTooBig = ErrorCode(rawValue: -325)
    public static let CacheMiss = ErrorCode(rawValue: -400)
    public static let InsecureResponse = ErrorCode(rawValue: -501)
}

extension ErrorCode {
    static func fromCEF(value: Int32) -> ErrorCode {
        return ErrorCode(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}

