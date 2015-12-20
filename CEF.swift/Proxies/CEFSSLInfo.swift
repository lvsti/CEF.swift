//
//  CEFSSLInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFSSLInfo {

    /// Returns a bitmask containing any and all problems verifying the server
    /// certificate.
    public var certStatus: CEFCertStatus {
        let cefStatus = cefObject.get_cert_status(cefObjectPtr)
        return CEFCertStatus.fromCEF(cefStatus)
    }
    
    /// Returns true if the certificate status has any error, major or minor.
    public var isCertStatusError: Bool {
        return cefObject.is_cert_status_error(cefObjectPtr) != 0
    }
    
    /// Returns true if the certificate status represents only minor errors
    /// (e.g. failure to verify certificate revocation).
    public var isCertStatusMinorError: Bool {
        return cefObject.is_cert_status_minor_error(cefObjectPtr) != 0
    }

    /// Returns the subject of the X.509 certificate. For HTTPS server
    /// certificates this represents the web server.  The common name of the
    /// subject should match the host name of the web server.
    public var subject: CEFSSLCertPrincipal? {
        let cefCert = cefObject.get_subject(cefObjectPtr)
        return CEFSSLCertPrincipal.fromCEF(cefCert)
    }
    
    /// Returns the issuer of the X.509 certificate.
    public var issuer: CEFSSLCertPrincipal? {
        let cefCert = cefObject.get_issuer(cefObjectPtr)
        return CEFSSLCertPrincipal.fromCEF(cefCert)
    }
    
    /// Returns the DER encoded serial number for the X.509 certificate. The value
    /// possibly includes a leading 00 byte.
    public var serialNumber: CEFBinaryValue? {
        let cefBinary = cefObject.get_serial_number(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the date before which the X.509 certificate is invalid.
    /// CefTime.GetTimeT() will return 0 if no date was specified.
    public var validFrom: NSDate? {
        var cefTime = cefObject.get_valid_start(cefObjectPtr)
        var time: time_t = 0;
        cef_time_to_timet(&cefTime, &time)
        return time != 0 ? CEFTimeToNSDate(cefTime) : nil
    }
    
    /// Returns the date after which the X.509 certificate is invalid.
    /// CefTime.GetTimeT() will return 0 if no date was specified.
    public var validUntil: NSDate? {
        var cefTime = cefObject.get_valid_expiry(cefObjectPtr)
        var time: time_t = 0;
        cef_time_to_timet(&cefTime, &time)
        return time != 0 ? CEFTimeToNSDate(cefTime) : nil
    }
    
    /// Returns the DER encoded data for the X.509 certificate.
    public var derEncoded: CEFBinaryValue? {
        let cefBinary = cefObject.get_derencoded(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the PEM encoded data for the X.509 certificate.
    public var pemEncoded: CEFBinaryValue? {
        let cefBinary = cefObject.get_pemencoded(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the number of certificates in the issuer chain.
    /// If 0, the certificate is self-signed.
    public var issuerChainSize: size_t {
        return cefObject.get_issuer_chain_size(cefObjectPtr)
    }
    
    /// Returns the DER encoded data for the certificate issuer chain.
    /// If we failed to encode a certificate in the chain it is still
    /// present in the array but is an empty string.
    public var derEncodedIssuerChain: [CEFBinaryValue] {
        var chainLength: size_t = 0
        var cefChain: UnsafeMutablePointer<cef_binary_value_t> = nil
        cefObject.get_derencoded_issuer_chain(cefObjectPtr, &chainLength, &cefChain)
        
        var chain: [CEFBinaryValue] = []
        for i in 0..<chainLength {
            let cefBinary = cefChain.advancedBy(i)
            chain.append(CEFBinaryValue.fromCEF(cefBinary)!)
        }
        
        return chain
    }
    
    /// Returns the PEM encoded data for the certificate issuer chain.
    /// If we failed to encode a certificate in the chain it is still
    /// present in the array but is an empty string.
    public var pemEncodedIssuerChain: [CEFBinaryValue] {
        var chainLength: size_t = 0
        var cefChain: UnsafeMutablePointer<cef_binary_value_t> = nil
        cefObject.get_pemencoded_issuer_chain(cefObjectPtr, &chainLength, &cefChain)
        
        var chain: [CEFBinaryValue] = []
        for i in 0..<chainLength {
            let cefBinary = cefChain.advancedBy(i)
            chain.append(CEFBinaryValue.fromCEF(cefBinary)!)
        }
        
        return chain
    }

}
