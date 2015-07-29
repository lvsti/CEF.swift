//
//  CEFSchemeRegistrar.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_scheme_registrar_t: CEFObject {
}

public class CEFSchemeRegistrar: CEFProxy<cef_scheme_registrar_t> {
    
    public required init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }

    public func addCustomScheme(name: String, isStandard: Bool, isLocal: Bool, isDisplayIsolated: Bool) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.add_custom_scheme(cefObjectPtr, cefStrPtr, isStandard ? 1 : 0, isLocal ? 1 : 0, isDisplayIsolated ? 1 : 0)
    }
    
}
