//
//  CEFErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported error code values. See net\base\net_error_list.h for complete
/// descriptions of the error codes.
/// CEF name: `cef_errorcode_t`.
public struct CEFErrorCode: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    /// CEF name: `ERR_NONE`.
    public static let none = CEFErrorCode(rawValue: 0)
    /// CEF name: `ERR_FAILED`.
    public static let failed = CEFErrorCode(rawValue: -2)
    /// CEF name: `ERR_ABORTED`.
    public static let aborted = CEFErrorCode(rawValue: -3)
    /// CEF name: `ERR_INVALID_ARGUMENT`.
    public static let invalidArgument = CEFErrorCode(rawValue: -4)
    /// CEF name: `ERR_INVALID_HANDLE`.
    public static let invalidHandle = CEFErrorCode(rawValue: -5)
    /// CEF name: `ERR_FILE_NOT_FOUND`.
    public static let fileNotFound = CEFErrorCode(rawValue: -6)
    /// CEF name: `ERR_TIMED_OUT`.
    public static let timedOut = CEFErrorCode(rawValue: -7)
    /// CEF name: `ERR_FILE_TOO_BIG`.
    public static let fileTooBig = CEFErrorCode(rawValue: -8)
    /// CEF name: `ERR_UNEXPECTED`.
    public static let unexpected = CEFErrorCode(rawValue: -9)
    /// CEF name: `ERR_ACCESS_DENIED`.
    public static let accessDenied = CEFErrorCode(rawValue: -10)
    /// CEF name: `ERR_NOT_IMPLEMENTED`.
    public static let notImplemented = CEFErrorCode(rawValue: -11)
    /// CEF name: `ERR_CONNECTION_CLOSED`.
    public static let connectionClosed = CEFErrorCode(rawValue: -100)
    /// CEF name: `ERR_CONNECTION_RESET`.
    public static let connectionReset = CEFErrorCode(rawValue: -101)
    /// CEF name: `ERR_CONNECTION_REFUSED`.
    public static let connectionRefused = CEFErrorCode(rawValue: -102)
    /// CEF name: `ERR_CONNECTION_ABORTED`.
    public static let connectionAborted = CEFErrorCode(rawValue: -103)
    /// CEF name: `ERR_CONNECTION_FAILED`.
    public static let connectionFailed = CEFErrorCode(rawValue: -104)
    /// CEF name: `ERR_NAME_NOT_RESOLVED`.
    public static let nameNotResolved = CEFErrorCode(rawValue: -105)
    /// CEF name: `ERR_INTERNET_DISCONNECTED`.
    public static let internetDisconnected = CEFErrorCode(rawValue: -106)
    /// CEF name: `ERR_SSL_PROTOCOL_ERROR`.
    public static let sslProtocolError = CEFErrorCode(rawValue: -107)
    /// CEF name: `ERR_ADDRESS_INVALID`.
    public static let addressInvalid = CEFErrorCode(rawValue: -108)
    /// CEF name: `ERR_ADDRESS_UNREACHABLE`.
    public static let addressUnreachable = CEFErrorCode(rawValue: -109)
    /// CEF name: `ERR_SSL_CLIENT_AUTH_CERT_NEEDED`.
    public static let sslClientAuthCertNeeded = CEFErrorCode(rawValue: -110)
    /// CEF name: `ERR_TUNNEL_CONNECTION_FAILED`.
    public static let tunnelConnectionFailed = CEFErrorCode(rawValue: -111)
    /// CEF name: `ERR_NO_SSL_VERSIONS_ENABLED`.
    public static let noSSLVersionsEnabled = CEFErrorCode(rawValue: -112)
    /// CEF name: `ERR_SSL_VERSION_OR_CIPHER_MISMATCH`.
    public static let sslVersionOrCipherMismatch = CEFErrorCode(rawValue: -113)
    /// CEF name: `ERR_SSL_RENEGOTIATION_REQUESTED`.
    public static let sslRenegotiationRequested = CEFErrorCode(rawValue: -114)
    /// CEF name: `ERR_CERT_COMMON_NAME_INVALID`.
    public static let certCommonNameInvalid = CEFErrorCode(rawValue: -200)
    /// CEF name: `ERR_CERT_BEGIN`.
    public static let certBegin = CEFErrorCode(rawValue: certCommonNameInvalid.rawValue)
    /// CEF name: `ERR_CERT_DATE_INVALID`.
    public static let certDateInvalid = CEFErrorCode(rawValue: -201)
    /// CEF name: `ERR_CERT_AUTHORITY_INVALID`.
    public static let certAuthorityInvalid = CEFErrorCode(rawValue: -202)
    /// CEF name: `ERR_CERT_CONTAINS_ERRORS`.
    public static let certContainsErrors = CEFErrorCode(rawValue: -203)
    /// CEF name: `ERR_CERT_NO_REVOCATION_MECHANISM`.
    public static let certNoRevocationMechanism = CEFErrorCode(rawValue: -204)
    /// CEF name: `ERR_CERT_UNABLE_TO_CHECK_REVOCATION`.
    public static let certUnableToCheckRevocation = CEFErrorCode(rawValue: -205)
    /// CEF name: `ERR_CERT_REVOKED`.
    public static let certRevoked = CEFErrorCode(rawValue: -206)
    /// CEF name: `ERR_CERT_INVALID`.
    public static let certInvalid = CEFErrorCode(rawValue: -207)
    /// CEF name: `ERR_CERT_WEAK_SIGNATURE_ALGORITHM`.
    public static let certWeakSignatureAlgorithm = CEFErrorCode(rawValue: -208)

    /// -209 is available: was ERR_CERT_NOT_IN_DNS.
    /// CEF name: `ERR_CERT_NON_UNIQUE_NAME`.
    public static let certNonUniqueName = CEFErrorCode(rawValue: -210)
    /// CEF name: `ERR_CERT_WEAK_KEY`.
    public static let certWeakKey = CEFErrorCode(rawValue: -211)
    /// CEF name: `ERR_CERT_NAME_CONSTRAINT_VIOLATION`.
    public static let certNameConstraintViolation = CEFErrorCode(rawValue: -212)
    /// CEF name: `ERR_CERT_VALIDITY_TOO_LONG`.
    public static let certValidityTooLong = CEFErrorCode(rawValue: -213)
    /// CEF name: `ERR_CERT_END`.
    public static let certEnd = CEFErrorCode(rawValue: certValidityTooLong.rawValue)
    /// CEF name: `ERR_INVALID_URL`.
    public static let invalidURL = CEFErrorCode(rawValue: -300)
    /// CEF name: `ERR_DISALLOWED_URL_SCHEME`.
    public static let disallowedURLScheme = CEFErrorCode(rawValue: -301)
    /// CEF name: `ERR_UNKNOWN_URL_SCHEME`.
    public static let unknownURLScheme = CEFErrorCode(rawValue: -302)
    /// CEF name: `ERR_TOO_MANY_REDIRECTS`.
    public static let tooManyRedirects = CEFErrorCode(rawValue: -310)
    /// CEF name: `ERR_UNSAFE_REDIRECT`.
    public static let unsafeRedirect = CEFErrorCode(rawValue: -311)
    /// CEF name: `ERR_UNSAFE_PORT`.
    public static let unsafePort = CEFErrorCode(rawValue: -312)
    /// CEF name: `ERR_INVALID_RESPONSE`.
    public static let invalidResponse = CEFErrorCode(rawValue: -320)
    /// CEF name: `ERR_INVALID_CHUNKED_ENCODING`.
    public static let invalidChunkedEncoding = CEFErrorCode(rawValue: -321)
    /// CEF name: `ERR_METHOD_NOT_SUPPORTED`.
    public static let methodNotSupported = CEFErrorCode(rawValue: -322)
    /// CEF name: `ERR_UNEXPECTED_PROXY_AUTH`.
    public static let unexpectedProxyAuth = CEFErrorCode(rawValue: -323)
    /// CEF name: `ERR_EMPTY_RESPONSE`.
    public static let emptyResponse = CEFErrorCode(rawValue: -324)
    /// CEF name: `ERR_RESPONSE_HEADERS_TOO_BIG`.
    public static let responseHeadersTooBig = CEFErrorCode(rawValue: -325)
    /// CEF name: `ERR_CACHE_MISS`.
    public static let cacheMiss = CEFErrorCode(rawValue: -400)
    /// CEF name: `ERR_INSECURE_RESPONSE`.
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

