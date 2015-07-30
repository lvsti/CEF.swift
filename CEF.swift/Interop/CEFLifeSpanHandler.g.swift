//
//  CEFLifeSpanHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_life_span_handler_t: CEFObject {
}

typealias CEFLifeSpanHandlerMarshaller = CEFMarshaller<CEFLifeSpanHandler>

extension CEFLifeSpanHandler: CEFMarshallable {
    typealias StructType = cef_life_span_handler_t
   
    func toCEF() -> UnsafeMutablePointer<cef_life_span_handler_t> {
        return CEFLifeSpanHandlerMarshaller.pass(self)
    }
    
    func marshalCallbacks(inout cefStruct: cef_life_span_handler_t) {
//        cefStruct.on_before_popup = CEFLifeSpanHandler_onBeforePopup
        cefStruct.on_after_created = CEFLifeSpanHandler_onAfterCreated
        cefStruct.run_modal = CEFLifeSpanHandler_runModal
        cefStruct.on_before_close = CEFLifeSpanHandler_onBeforeClose
        cefStruct.do_close = CEFLifeSpanHandler_doClose
    }
}

// TODO:
//func CEFLifeSpanHandler_onBeforePopup(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
//                                      browser: UnsafeMutablePointer<cef_browser_t>,
//    ...) {
//    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
//        return
//    }
//    
//    obj.onBeforePopup(CEFBrowser.fromCEF(browser))
//}


func CEFLifeSpanHandler_onAfterCreated(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                       browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAfterCreated(CEFBrowser.fromCEF(browser)!)
}

func CEFLifeSpanHandler_runModal(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                 browser: UnsafeMutablePointer<cef_browser_t>) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.runModal(CEFBrowser.fromCEF(browser)!) ? 1 : 0
}

func CEFLifeSpanHandler_doClose(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                browser: UnsafeMutablePointer<cef_browser_t>) -> Int32 {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.doClose(CEFBrowser.fromCEF(browser)!) ? 1 : 0
}

func CEFLifeSpanHandler_onBeforeClose(ptr: UnsafeMutablePointer<cef_life_span_handler_t>,
                                      browser: UnsafeMutablePointer<cef_browser_t>) {
    guard let obj = CEFLifeSpanHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onBeforeClose(CEFBrowser.fromCEF(browser)!)
}

