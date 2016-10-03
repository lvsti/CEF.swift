//
//  CEFPDFPrintCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFPDFPrintCallback_on_pdf_print_finished(ptr: UnsafeMutablePointer<cef_pdf_print_callback_t>?,
                                               path: UnsafePointer<cef_string_t>?,
                                               success: Int32) {
    guard let obj = CEFPDFPrintCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onPDFPrintFinished(path: CEFStringToSwiftString(path!.pointee), successfully: success != 0)
}
