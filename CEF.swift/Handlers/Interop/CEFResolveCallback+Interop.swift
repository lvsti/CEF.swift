//
//  CEFResolveCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 04. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFResolveCallback_on_resolve_completed(ptr: UnsafeMutablePointer<cef_resolve_callback_t>,
                                             errorCode: cef_errorcode_t,
                                             results: cef_string_list_t) {
    guard let obj = CEFResolveCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onResolveCompleted(CEFStringListToSwiftArray(results),
                           errorCode: CEFErrorCode.fromCEF(errorCode.rawValue))
}
