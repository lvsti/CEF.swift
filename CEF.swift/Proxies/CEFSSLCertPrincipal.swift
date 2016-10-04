//
//  CEFSSLCertPrincipal.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFSSLCertPrincipal {

    /// Returns a name that can be used to represent the issuer.  It tries in this
    /// order: CN, O and OU and returns the first non-empty one found.
    public var displayName: String {
        let cefStrPtr = cefObject.get_display_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }

    /// Returns the common name.
    public var commonName: String {
        let cefStrPtr = cefObject.get_common_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }

    /// Returns the locality name.
    public var localityName: String {
        let cefStrPtr = cefObject.get_locality_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the state or province name.
    public var stateOrProvinceName: String {
        let cefStrPtr = cefObject.get_state_or_province_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the country name.
    public var countryName: String {
        let cefStrPtr = cefObject.get_country_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Retrieve the list of street addresses.
    public var streetAddresses: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_street_addresses(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Retrieve the list of organization names.
    public var organizationNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_organization_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Retrieve the list of organization unit names.
    public var organizationUnitNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_organization_unit_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Retrieve the list of domain components.
    public var domainComponents: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_domain_components(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
}
