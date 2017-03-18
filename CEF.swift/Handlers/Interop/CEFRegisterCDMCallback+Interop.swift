//
//  CEFRegisterCDMCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 05..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFRegisterCDMCallback_on_cdm_registration_complete(ptr: UnsafeMutablePointer<cef_register_cdm_callback_t>?,
                                                         result: cef_cdm_registration_error_t,
                                                         message: UnsafePointer<cef_string_t>?) {
    guard let obj = CEFRegisterCDMCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onCDMRegistrationComplete(result: CEFCDMRegistrationError.fromCEF(result),
                                  message: message != nil ? CEFStringToSwiftString(message!.pointee) : nil)
}
