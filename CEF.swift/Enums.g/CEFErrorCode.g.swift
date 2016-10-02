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

    public static let none = CEFErrorCode(rawValue: 0)
    public static let failed = CEFErrorCode(rawValue: -2)
    public static let aborted = CEFErrorCode(rawValue: -3)
    public static let invalidArgument = CEFErrorCode(rawValue: -4)
    public static let invalidHandle = CEFErrorCode(rawValue: -5)
    public static let fileNotFound = CEFErrorCode(rawValue: -6)
    public static let timedOut = CEFErrorCode(rawValue: -7)
    public static let fileTooBig = CEFErrorCode(rawValue: -8)
    public static let unexpected = CEFErrorCode(rawValue: -9)
    public static let accessDenied = CEFErrorCode(rawValue: -10)
    public static let notImplemented = CEFErrorCode(rawValue: -11)
    public static let connectionClosed = CEFErrorCode(rawValue: -100)
    public static let connectionReset = CEFErrorCode(rawValue: -101)
    public static let connectionRefused = CEFErrorCode(rawValue: -102)
    public static let connectionAborted = CEFErrorCode(rawValue: -103)
    public static let connectionFailed = CEFErrorCode(rawValue: -104)
    public static let nameNotResolved = CEFErrorCode(rawValue: -105)
    public static let internetDisconnected = CEFErrorCode(rawValue: -106)
    public static let sslProtocolError = CEFErrorCode(rawValue: -107)
    public static let addressInvalid = CEFErrorCode(rawValue: -108)
    public static let addressUnreachable = CEFErrorCode(rawValue: -109)
    public static let sslClientAuthCertNeeded = CEFErrorCode(rawValue: -110)
    public static let tunnelConnectionFailed = CEFErrorCode(rawValue: -111)
    public static let noSSLVersionsEnabled = CEFErrorCode(rawValue: -112)
    public static let sslVersionOrCipherMismatch = CEFErrorCode(rawValue: -113)
    public static let sslRenegotiationRequested = CEFErrorCode(rawValue: -114)
    public static let certCommonNameInvalid = CEFErrorCode(rawValue: -200)
    public static let certBegin = CEFErrorCode(rawValue: certCommonNameInvalid.rawValue)
    public static let certDateInvalid = CEFErrorCode(rawValue: -201)
    public static let certAuthorityInvalid = CEFErrorCode(rawValue: -202)
    public static let certContainsErrors = CEFErrorCode(rawValue: -203)
    public static let certNoRevocationMechanism = CEFErrorCode(rawValue: -204)
    public static let certUnableToCheckRevocation = CEFErrorCode(rawValue: -205)
    public static let certRevoked = CEFErrorCode(rawValue: -206)
    public static let certInvalid = CEFErrorCode(rawValue: -207)
    // -209 is available: was ERR_CERT_NOT_IN_DNS.
    public static let certWeakSignatureAlgorithm = CEFErrorCode(rawValue: -208)
    public static let certNonUniqueName = CEFErrorCode(rawValue: -210)
    public static let certWeakKey = CEFErrorCode(rawValue: -211)
    public static let certNameConstraintViolation = CEFErrorCode(rawValue: -212)
    public static let certValidityTooLong = CEFErrorCode(rawValue: -213)
    public static let certEnd = CEFErrorCode(rawValue: certValidityTooLong.rawValue)
    public static let invalidURL = CEFErrorCode(rawValue: -300)
    public static let disallowedURLScheme = CEFErrorCode(rawValue: -301)
    public static let unknownURLScheme = CEFErrorCode(rawValue: -302)
    public static let tooManyRedirects = CEFErrorCode(rawValue: -310)
    public static let unsafeRedirect = CEFErrorCode(rawValue: -311)
    public static let unsafePort = CEFErrorCode(rawValue: -312)
    public static let invalidResponse = CEFErrorCode(rawValue: -320)
    public static let invalidChunkedEncoding = CEFErrorCode(rawValue: -321)
    public static let methodNotSupported = CEFErrorCode(rawValue: -322)
    public static let unexpectedProxyAuth = CEFErrorCode(rawValue: -323)
    public static let emptyResponse = CEFErrorCode(rawValue: -324)
    public static let responseHeadersTooBig = CEFErrorCode(rawValue: -325)
    public static let cacheMiss = CEFErrorCode(rawValue: -400)
    public static let insecureResponse = CEFErrorCode(rawValue: -501)
}

extension CEFErrorCode {
    static func fromCEF(_ value: Int32) -> CEFErrorCode {
        return CEFErrorCode(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}

