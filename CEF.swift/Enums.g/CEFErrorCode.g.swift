//
//  CEFErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Supported error code values. See net\base\net_error_list.h for complete
// descriptions of the error codes.
///
public enum CEFErrorCode: Int32 {
    case None = 0
    case Failed = -2
    case Aborted = -3
    case InvalidArgument = -4
    case InvalidHandle = -5
    case FileNotFound = -6
    case TimedOut = -7
    case FileTooBig = -8
    case Unexpected = -9
    case AccessDenied = -10
    case NotImplemented = -11
    case ConnectionClosed = -100
    case ConnectionReset = -101
    case ConnectionRefused = -102
    case ConnectionAborted = -103
    case ConnectionFailed = -104
    case NameNotResolved = -105
    case InternetDisconnected = -106
    case SSLProtocolError = -107
    case AddressInvalid = -108
    case AddressUnreachable = -109
    case SSLClientAuthCertNeeded = -110
    case TunnelConnectionFailed = -111
    case NoSSLVersionsEnabled = -112
    case SSLVersionOrCipherMismatch = -113
    case SSLRenegotiationRequested = -114
    case CertCommonNameInvalid = -200
    case CertDateInvalid = -201
    case CertAuthorityInvalid = -202
    case CertContainsErrors = -203
    case CertNoRevocationMechanism = -204
    case CertUnableToCheckRevocation = -205
    case CertRevoked = -206
    case CertInvalid = -207
    case CertEnd = -208
    case InvalidURL = -300
    case DisallowedURLScheme = -301
    case UnknownURLScheme = -302
    case TooManyRedirects = -310
    case UnsafeRedirect = -311
    case UnsafePort = -312
    case InvalidResponse = -320
    case InvalidChunkedEncoding = -321
    case MethodNotSupported = -322
    case UnexpectedProxyAuth = -323
    case EmptyResponse = -324
    case ResponseHeadersTooBig = -325
    case CacheMiss = -400
    case InsecureResponse = -501
}

extension CEFErrorCode {
    static func fromCEF(value: cef_errorcode_t) -> CEFErrorCode {
        return CEFErrorCode(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_errorcode_t {
        return cef_errorcode_t(rawValue: Int32(rawValue))
    }
}

