//
//  CEFErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported error code values. See net\base\net_error_list.h for complete
/// descriptions of the error codes.
public struct CEFErrorCode: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let None = CEFErrorCode(rawValue: 0)
    public static let Failed = CEFErrorCode(rawValue: -2)
    public static let Aborted = CEFErrorCode(rawValue: -3)
    public static let InvalidArgument = CEFErrorCode(rawValue: -4)
    public static let InvalidHandle = CEFErrorCode(rawValue: -5)
    public static let FileNotFound = CEFErrorCode(rawValue: -6)
    public static let TimedOut = CEFErrorCode(rawValue: -7)
    public static let FileTooBig = CEFErrorCode(rawValue: -8)
    public static let Unexpected = CEFErrorCode(rawValue: -9)
    public static let AccessDenied = CEFErrorCode(rawValue: -10)
    public static let NotImplemented = CEFErrorCode(rawValue: -11)
    public static let ConnectionClosed = CEFErrorCode(rawValue: -100)
    public static let ConnectionReset = CEFErrorCode(rawValue: -101)
    public static let ConnectionRefused = CEFErrorCode(rawValue: -102)
    public static let ConnectionAborted = CEFErrorCode(rawValue: -103)
    public static let ConnectionFailed = CEFErrorCode(rawValue: -104)
    public static let NameNotResolved = CEFErrorCode(rawValue: -105)
    public static let InternetDisconnected = CEFErrorCode(rawValue: -106)
    public static let SSLProtocolError = CEFErrorCode(rawValue: -107)
    public static let AddressInvalid = CEFErrorCode(rawValue: -108)
    public static let AddressUnreachable = CEFErrorCode(rawValue: -109)
    public static let SSLClientAuthCertNeeded = CEFErrorCode(rawValue: -110)
    public static let TunnelConnectionFailed = CEFErrorCode(rawValue: -111)
    public static let NoSSLVersionsEnabled = CEFErrorCode(rawValue: -112)
    public static let SSLVersionOrCipherMismatch = CEFErrorCode(rawValue: -113)
    public static let SSLRenegotiationRequested = CEFErrorCode(rawValue: -114)
    public static let CertCommonNameInvalid = CEFErrorCode(rawValue: -200)
    public static let CertBegin = CertCommonNameInvalid;
    public static let CertDateInvalid = CEFErrorCode(rawValue: -201)
    public static let CertAuthorityInvalid = CEFErrorCode(rawValue: -202)
    public static let CertContainsErrors = CEFErrorCode(rawValue: -203)
    public static let CertNoRevocationMechanism = CEFErrorCode(rawValue: -204)
    public static let CertUnableToCheckRevocation = CEFErrorCode(rawValue: -205)
    public static let CertRevoked = CEFErrorCode(rawValue: -206)
    public static let CertInvalid = CEFErrorCode(rawValue: -207)
    public static let CertWeakSignatureAlgorithm = CEFErrorCode(rawValue: -208)
    // -209 is available: was ERR_CERT_NOT_IN_DNS.
    public static let CertNonUniqueName = CEFErrorCode(rawValue: -210)
    public static let CertWeakKey = CEFErrorCode(rawValue: -211)
    public static let CertNameConstraintViolation = CEFErrorCode(rawValue: -212)
    public static let CertValidityTooLong = CEFErrorCode(rawValue: -213)
    public static let CertEnd = CertValidityTooLong;
    public static let InvalidURL = CEFErrorCode(rawValue: -300)
    public static let DisallowedURLScheme = CEFErrorCode(rawValue: -301)
    public static let UnknownURLScheme = CEFErrorCode(rawValue: -302)
    public static let TooManyRedirects = CEFErrorCode(rawValue: -310)
    public static let UnsafeRedirect = CEFErrorCode(rawValue: -311)
    public static let UnsafePort = CEFErrorCode(rawValue: -312)
    public static let InvalidResponse = CEFErrorCode(rawValue: -320)
    public static let InvalidChunkedEncoding = CEFErrorCode(rawValue: -321)
    public static let MethodNotSupported = CEFErrorCode(rawValue: -322)
    public static let UnexpectedProxyAuth = CEFErrorCode(rawValue: -323)
    public static let EmptyResponse = CEFErrorCode(rawValue: -324)
    public static let ResponseHeadersTooBig = CEFErrorCode(rawValue: -325)
    public static let CacheMiss = CEFErrorCode(rawValue: -400)
    public static let InsecureResponse = CEFErrorCode(rawValue: -501)
}

extension CEFErrorCode {
    static func fromCEF(value: Int32) -> CEFErrorCode {
        return CEFErrorCode(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}

