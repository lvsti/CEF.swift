//
//  CEFRenderProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_render_process_handler_t: CEFObject {
}

typealias CEFRenderProcessHandlerMarshaller = CEFMarshaller<CEFRenderProcessHandler>

public class CEFRenderProcessHandler: CEFHandler, CEFMarshallable {
    typealias StructType = cef_render_process_handler_t

    public override init() {
        super.init()
    }

    func toCEF() -> UnsafeMutablePointer<cef_render_process_handler_t> {
        return CEFRenderProcessHandlerMarshaller.pass(self)
    }
    
    func marshalCallbacks(inout cefStruct: cef_render_process_handler_t) {
        //
    }
}
