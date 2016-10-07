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
    /// CEF name: `GetCertStatus`
    public var certStatus: CEFCertStatus {
        let cefStatus = cefObject.get_cert_status(cefObjectPtr)
        return CEFCertStatus.fromCEF(cefStatus)
    }
    
    /// Returns true if the certificate status has any error, major or minor.
    /// CEF name: `IsCertStatusError`
    public var isCertStatusError: Bool {
        return cefObject.is_cert_status_error(cefObjectPtr) != 0
    }
    
    /// Returns true if the certificate status represents only minor errors
    /// (e.g. failure to verify certificate revocation).
    /// CEF name: `IsCertStatusMinorError`
    public var isCertStatusMinorError: Bool {
        return cefObject.is_cert_status_minor_error(cefObjectPtr) != 0
    }

    /// Returns the subject of the X.509 certificate. For HTTPS server
    /// certificates this represents the web server.  The common name of the
    /// subject should match the host name of the web server.
    /// CEF name: `GetSubject`
    public var subject: CEFSSLCertPrincipal? {
        let cefCert = cefObject.get_subject(cefObjectPtr)
        return CEFSSLCertPrincipal.fromCEF(cefCert)
    }
    
    /// Returns the issuer of the X.509 certificate.
    /// CEF name: `GetIssuer`
    public var issuer: CEFSSLCertPrincipal? {
        let cefCert = cefObject.get_issuer(cefObjectPtr)
        return CEFSSLCertPrincipal.fromCEF(cefCert)
    }
    
    /// Returns the DER encoded serial number for the X.509 certificate. The value
    /// possibly includes a leading 00 byte.
    /// CEF name: `GetSerialNumber`
    public var serialNumber: CEFBinaryValue? {
        let cefBinary = cefObject.get_serial_number(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the date before which the X.509 certificate is invalid.
    /// CefTime.GetTimeT() will return 0 if no date was specified.
    /// CEF name: `GetValidStart`
    public var validFromDate: NSDate? {
        var cefTime = cefObject.get_valid_start(cefObjectPtr)
        var time: time_t = 0;
        cef_time_to_timet(&cefTime, &time)
        return time != 0 ? CEFTimeToNSDate(cefTime) : nil
    }
    
    /// Returns the date after which the X.509 certificate is invalid.
    /// CefTime.GetTimeT() will return 0 if no date was specified.
    /// CEF name: `GetValidExpiry`
    public var validUntilDate: NSDate? {
        var cefTime = cefObject.get_valid_expiry(cefObjectPtr)
        var time: time_t = 0;
        cef_time_to_timet(&cefTime, &time)
        return time != 0 ? CEFTimeToNSDate(cefTime) : nil
    }
    
    /// Returns the DER encoded data for the X.509 certificate.
    /// CEF name: `GetDEREncoded`
    public var derEncoded: CEFBinaryValue? {
        let cefBinary = cefObject.get_derencoded(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }
    
    /// Returns the PEM encoded data for the X.509 certificate.
    /// CEF name: `GetPEMEncoded`
    public var pemEncoded: CEFBinaryValue? {
        let cefBinary = cefObject.get_pemencoded(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the number of certificates in the issuer chain.
    /// If 0, the certificate is self-signed.
    /// CEF name: `GetIssuerChainSize`
    public var issuerChainSize: size_t {
        return cefObject.get_issuer_chain_size(cefObjectPtr)
    }
    
    /// Returns the DER encoded data for the certificate issuer chain.
    /// If we failed to encode a certificate in the chain it is still
    /// present in the array but is an empty string.
    /// CEF name: `GetDEREncodedIssuerChain`
    public var derEncodedIssuerChain: [CEFBinaryValue] {
        var chainLength: size_t = 0
        var cefChain: UnsafeMutablePointer<cef_binary_value_t>? = nil
        cefObject.get_derencoded_issuer_chain(cefObjectPtr, &chainLength, &cefChain)
        
        var chain: [CEFBinaryValue] = []
        for i in 0..<chainLength {
            let cefBinary = cefChain!.advanced(by: i)
            chain.append(CEFBinaryValue.fromCEF(cefBinary)!)
        }
        
        return chain
    }
    
    /// Returns the PEM encoded data for the certificate issuer chain.
    /// If we failed to encode a certificate in the chain it is still
    /// present in the array but is an empty string.
    /// CEF name: `GetPEMEncodedIssuerChain`
    public var pemEncodedIssuerChain: [CEFBinaryValue] {
        var chainLength: size_t = 0
        var cefChain: UnsafeMutablePointer<cef_binary_value_t>? = nil
        cefObject.get_pemencoded_issuer_chain(cefObjectPtr, &chainLength, &cefChain)
        
        var chain: [CEFBinaryValue] = []
        for i in 0..<chainLength {
            let cefBinary = cefChain!.advanced(by: i)
            chain.append(CEFBinaryValue.fromCEF(cefBinary)!)
        }
        
        return chain
    }

}
