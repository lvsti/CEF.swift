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

class CEFRenderProcessHandlerMarshaller: CEFMarshaller<cef_render_process_handler_t, CEFRenderProcessHandler> {
    override init(obj: CEFRenderProcessHandler) {
        super.init(obj: obj)
    }
}

public class CEFRenderProcessHandler: CEFHandler {
    
    func toCEF() -> UnsafeMutablePointer<cef_render_process_handler_t> {
        return CEFRenderProcessHandlerMarshaller.pass(self)
    }
    
}
