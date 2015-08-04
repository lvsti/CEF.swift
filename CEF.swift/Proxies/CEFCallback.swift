//
//  CEFCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 04..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_callback_t: CEFObject {
}

public class CEFCallback: CEFProxy<cef_callback_t> {

    public func doContinue() {
        cefObject.cont(cefObjectPtr)
    }
    
    public func doCancel() {
        cefObject.cancel(cefObjectPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFCallback? {
        return CEFCallback(ptr: ptr)
    }

}

