//
//  SchemeHandlerFactory.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func SchemeHandlerFactory_create(ptr: UnsafeMutablePointer<cef_scheme_handler_factory_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>,
                                 frame: UnsafeMutablePointer<cef_frame_t>,
                                 scheme: UnsafePointer<cef_string_t>,
                                 request: UnsafeMutablePointer<cef_request_t>) -> UnsafeMutablePointer<cef_resource_handler_t> {
    guard let obj = SchemeHandlerFactoryMarshaller.get(ptr) else {
        return nil
    }

    if let handler = obj.create(Browser.fromCEF(browser),
                                frame: Frame.fromCEF(frame),
                                scheme: CEFStringToSwiftString(scheme.memory),
                                request: Request.fromCEF(request)!) {
        return handler.toCEF()
    }
    
    return nil
}

