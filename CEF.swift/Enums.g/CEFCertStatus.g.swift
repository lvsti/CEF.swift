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
public struct CEFCertStatus: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    public static let None = CEFCertStatus(rawValue: 0)
    public static let CommonNameInvalid = CEFCertStatus(rawValue: 1 << 0)
    public static let DateInvalid = CEFCertStatus(rawValue: 1 << 1)

    // 1 << 3 is reserved for ERR_CERT_CONTAINS_ERRORS (not useful with WinHTTP).
    
    public static let AuthorityInvalid = CEFCertStatus(rawValue: 1 << 2)
    public static let NoRevocationMechanism = CEFCertStatus(rawValue: 1 << 4)
    public static let UnableToCheckRevocation = CEFCertStatus(rawValue: 1 << 5)
    public static let Revoked = CEFCertStatus(rawValue: 1 << 6)
    public static let Invalid = CEFCertStatus(rawValue: 1 << 7)

    // 1 << 9 was used for CERT_STATUS_NOT_IN_DNS

    public static let WeakSignatureAlgorithm = CEFCertStatus(rawValue: 1 << 8)
    public static let NonUniqueName = CEFCertStatus(rawValue: 1 << 10)

    // 1 << 12 was used for CERT_STATUS_WEAK_DH_KEY

    public static let WeakKey = CEFCertStatus(rawValue: 1 << 11)
    public static let PinnedKeyMissing = CEFCertStatus(rawValue: 1 << 13)
    public static let NameConstraintViolation = CEFCertStatus(rawValue: 1 << 14)

    // Bits 16 to 31 are for non-error statuses.

    public static let ValidityTooLong = CEFCertStatus(rawValue: 1 << 15)
    public static let IsEV = CEFCertStatus(rawValue: 1 << 16)

    // Bit 18 was CERT_STATUS_IS_DNSSEC

    public static let RevocationCheckingEnabled = CEFCertStatus(rawValue: 1 << 17)
    public static let SHA1SignaturePresent = CEFCertStatus(rawValue: 1 << 19)
    public static let CTComplianceFailed = CEFCertStatus(rawValue: 1 << 20)
}

extension CEFCertStatus {
    static func fromCEF(value: cef_cert_status_t) -> CEFCertStatus {
        return CEFCertStatus(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_cert_status_t {
        return cef_cert_status_t(rawValue: UInt32(rawValue))
    }
}

