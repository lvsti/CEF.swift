//
//  CEFFrameHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2021. 10. 17..
//  Copyright © 2021. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFFrameHandler_on_frame_created(ptr: UnsafeMutablePointer<cef_frame_handler_t>?,
                                   browser: UnsafeMutablePointer<cef_browser_t>?,
                                   frame: UnsafeMutablePointer<cef_frame_t>?) {
    guard let obj = CEFFrameHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFrameCreated(browser: CEFBrowser.fromCEF(browser)!, frame: CEFFrame.fromCEF(frame)!)
}

func CEFFrameHandler_on_frame_attached(ptr: UnsafeMutablePointer<cef_frame_handler_t>?,
                                       browser: UnsafeMutablePointer<cef_browser_t>?,
                                       frame: UnsafeMutablePointer<cef_frame_t>?,
                                       isReattached: Int32) {
    guard let obj = CEFFrameHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFrameAttached(browser: CEFBrowser.fromCEF(browser)!,
                        frame: CEFFrame.fromCEF(frame)!,
                        isReattached: isReattached != 0)
}

func CEFFrameHandler_on_frame_detached(ptr: UnsafeMutablePointer<cef_frame_handler_t>?,
                                       browser: UnsafeMutablePointer<cef_browser_t>?,
                                       frame: UnsafeMutablePointer<cef_frame_t>?) {
    guard let obj = CEFFrameHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onFrameDetached(browser: CEFBrowser.fromCEF(browser)!, frame: CEFFrame.fromCEF(frame)!)
}

func CEFFrameHandler_on_main_frame_changed(ptr: UnsafeMutablePointer<cef_frame_handler_t>?,
                                           browser: UnsafeMutablePointer<cef_browser_t>?,
                                           oldFrame: UnsafeMutablePointer<cef_frame_t>?,
                                           newFrame: UnsafeMutablePointer<cef_frame_t>?) {
    guard let obj = CEFFrameHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onMainFrameChanged(browser: CEFBrowser.fromCEF(browser)!,
                           oldFrame: CEFFrame.fromCEF(oldFrame),
                           newFrame: CEFFrame.fromCEF(newFrame))
}

