//
//  CEFSSLCertPrincipal.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_sslcert_principal_t: CEFObject {
}

///
// Class representing the issuer or subject field of an X.509 certificate.
///
public class CEFSSLCertPrincipal: CEFProxy<cef_sslcert_principal_t> {

    ///
    // Returns a name that can be used to represent the issuer.  It tries in this
    // order: CN, O and OU and returns the first non-empty one found.
    ///
    public func getDisplayName() -> String {
        let cefStrPtr = cefObject.get_display_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    ///
    // Returns the common name.
    ///
    public func getCommonName() -> String {
        let cefStrPtr = cefObject.get_common_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    ///
    // Returns the locality name.
    ///
    public func getLocalityName() -> String {
        let cefStrPtr = cefObject.get_locality_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the state or province name.
    ///
    public func getStateOrProvinceName() -> String {
        let cefStrPtr = cefObject.get_state_or_province_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the country name.
    ///
    public func getCountryName() -> String {
        let cefStrPtr = cefObject.get_country_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Retrieve the list of street addresses.
    ///
    public func getStreetAddresses() -> [String] {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        cefObject.get_street_addresses(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    ///
    // Retrieve the list of organization names.
    ///
    public func getOrganizationNames() -> [String] {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        cefObject.get_organization_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    ///
    // Retrieve the list of organization unit names.
    ///
    public func getOrganizationUnitNames() -> [String] {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        cefObject.get_organization_unit_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    ///
    // Retrieve the list of domain components.
    ///
    public func getDomainComponents() -> [String] {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        cefObject.get_domain_components(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFSSLCertPrincipal? {
        return CEFSSLCertPrincipal(ptr: ptr)
    }
    
}
