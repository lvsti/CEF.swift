//
//  CEFSchemeHandlerFactory.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 02..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFSchemeHandlerFactory_create(ptr: UnsafeMutablePointer<cef_scheme_handler_factory_t>,
                                    browser: UnsafeMutablePointer<cef_browser_t>,
                                    frame: UnsafeMutablePointer<cef_frame_t>,
                                    scheme: UnsafePointer<cef_string_t>,
                                    request: UnsafeMutablePointer<cef_request_t>) -> UnsafeMutablePointer<cef_resource_handler_t> {
    guard let obj = CEFSchemeHandlerFactoryMarshaller.get(ptr) else {
        return nil
    }

    if let handler = obj.create(CEFBrowser.fromCEF(browser),
                                frame: CEFFrame.fromCEF(frame),
                                scheme: CEFStringToSwiftString(scheme.memory),
                                request: CEFRequest.fromCEF(request)!) {
        return handler.toCEF()
    }
    
    return nil
}

