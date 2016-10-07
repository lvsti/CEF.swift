//
//  CEFCertStatus.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported certificate status code values. See net\cert\cert_status_flags.h
/// for more information. CERT_STATUS_NONE is new in CEF because we use an
/// enum while cert_status_flags.h uses a typedef and static const variables.
/// CEF name: `cef_cert_status_t`.
public struct CEFCertStatus: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    /// CEF name: `CERT_STATUS_NONE`.
    public static let none = CEFCertStatus(rawValue: 0)
    /// CEF name: `CERT_STATUS_COMMON_NAME_INVALID`.
    public static let commonNameInvalid = CEFCertStatus(rawValue: 1 << 0)
    /// CEF name: `CERT_STATUS_DATE_INVALID`.
    public static let dateInvalid = CEFCertStatus(rawValue: 1 << 1)

    // 1 << 3 is reserved for ERR_CERT_CONTAINS_ERRORS (not useful with WinHTTP).
    
    /// CEF name: `CERT_STATUS_AUTHORITY_INVALID`.
    public static let authorityInvalid = CEFCertStatus(rawValue: 1 << 2)
    /// CEF name: `CERT_STATUS_NO_REVOCATION_MECHANISM`.
    public static let noRevocationMechanism = CEFCertStatus(rawValue: 1 << 4)
    /// CEF name: `CERT_STATUS_UNABLE_TO_CHECK_REVOCATION`.
    public static let unableToCheckRevocation = CEFCertStatus(rawValue: 1 << 5)
    /// CEF name: `CERT_STATUS_REVOKED`.
    public static let revoked = CEFCertStatus(rawValue: 1 << 6)
    /// CEF name: `CERT_STATUS_INVALID`.
    public static let invalid = CEFCertStatus(rawValue: 1 << 7)

    // 1 << 9 was used for CERT_STATUS_NOT_IN_DNS
    /// CEF name: `CERT_STATUS_WEAK_SIGNATURE_ALGORITHM`.
    public static let weakSignatureAlgorithm = CEFCertStatus(rawValue: 1 << 8)
    /// CEF name: `CERT_STATUS_NON_UNIQUE_NAME`.
    public static let nonUniqueName = CEFCertStatus(rawValue: 1 << 10)


    // 1 << 12 was used for CERT_STATUS_WEAK_DH_KEY
    /// CEF name: `CERT_STATUS_WEAK_KEY`.
    public static let weakKey = CEFCertStatus(rawValue: 1 << 11)
    /// CEF name: `CERT_STATUS_PINNED_KEY_MISSING`.
    public static let pinnedKeyMissing = CEFCertStatus(rawValue: 1 << 13)
    /// CEF name: `CERT_STATUS_NAME_CONSTRAINT_VIOLATION`.
    public static let nameConstraintViolation = CEFCertStatus(rawValue: 1 << 14)


    // Bits 16 to 31 are for non-error statuses.
    /// CEF name: `CERT_STATUS_VALIDITY_TOO_LONG`.
    public static let validityTooLong = CEFCertStatus(rawValue: 1 << 15)
    /// CEF name: `CERT_STATUS_IS_EV`.
    public static let isEV = CEFCertStatus(rawValue: 1 << 16)


    // Bit 18 was CERT_STATUS_IS_DNSSEC

    /// CEF name: `CERT_STATUS_REV_CHECKING_ENABLED`.
    public static let revocationCheckingEnabled = CEFCertStatus(rawValue: 1 << 17)
    /// CEF name: `CERT_STATUS_SHA1_SIGNATURE_PRESENT`.
    public static let sha1SignaturePresent = CEFCertStatus(rawValue: 1 << 19)
    /// CEF name: `CERT_STATUS_CT_COMPLIANCE_FAILED`.
    public static let ctComplianceFailed = CEFCertStatus(rawValue: 1 << 20)
}

extension CEFCertStatus {
    static func fromCEF(_ value: cef_cert_status_t) -> CEFCertStatus {
        return CEFCertStatus(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_cert_status_t {
        return cef_cert_status_t(rawValue: UInt32(rawValue))
    }
}

