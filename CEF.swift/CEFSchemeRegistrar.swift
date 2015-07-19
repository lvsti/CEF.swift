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

public class CEFSchemeRegistrar: CEFProxyBase<cef_scheme_registrar_t> {
    
    public func addCustomScheme(name: String, isStandard: Bool, isLocal: Bool, isDisplayIsolated: Bool) {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        cefObject.add_custom_scheme(cefObjectPtr, cefStrPtr, isStandard ? 1 : 0, isLocal ? 1 : 0, isDisplayIsolated ? 1 : 0)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
}
