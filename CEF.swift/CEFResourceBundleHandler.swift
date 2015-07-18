//
//  CEFResourceBundleHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_resource_bundle_handler_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

class CEFResourceBundleHandler: CEFHandlerBase<cef_resource_bundle_handler_t> {
    
}
