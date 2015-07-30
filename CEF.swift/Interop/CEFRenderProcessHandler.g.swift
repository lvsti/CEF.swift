//
//  CEFRenderProcessHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_render_process_handler_t: CEFObject {
}

typealias CEFRenderProcessHandlerMarshaller = CEFMarshaller<CEFRenderProcessHandler, cef_render_process_handler_t>

extension CEFRenderProcessHandler {
    func toCEF() -> UnsafeMutablePointer<cef_render_process_handler_t> {
        return CEFRenderProcessHandlerMarshaller.pass(self)
    }
}

extension cef_render_process_handler_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        //
    }
}
