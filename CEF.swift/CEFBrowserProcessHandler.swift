//
//  CEFBrowserProcessHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_browser_process_handler_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

class CEFBrowserProcessHandler: CEFHandlerBase<cef_browser_process_handler_t>, CEFObjectLookup {
    typealias SelfType = CEFBrowserProcessHandler
    
    static var _registryLock: Lock = pthread_mutex_t()
    static var _registry = Dictionary<ObjectPtrType, SelfType>()
    
    init?() {
        let handler = ObjectPtrType.alloc(1)
        handler.memory.base.add_ref = CEFBrowserProcessHandler_addRef
        handler.memory.base.release = CEFBrowserProcessHandler_release
        handler.memory.base.has_one_ref = CEFBrowserProcessHandler_hasOneRef
        handler.memory.on_context_initialized = CEFBrowserProcessHandler_onContextInitialized
        handler.memory.on_before_child_process_launch = CEFBrowserProcessHandler_onBeforeChildProcessLaunch
        handler.memory.on_render_process_thread_created = CEFBrowserProcessHandler_onRenderProcessThreadCreated
//        handler.memory.get_print_handler = CEFBrowserProcessHandler_getPrintHandler
        
        super.init(ptr: handler)
    }

    func onContextInitialized() {
    }
    
    func onBeforeChildProcessLaunch(commandLine: CEFCommandLine) {
    }
    
    func onRenderProcessThreadCreated(userInfo: CEFListValue) {
    }
    
    // TODO:
//    func getPrintHandler() -> CEFPrintHandler? {
//        return nil
//    }

}


func CEFBrowserProcessHandler_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.addRef()
}

func CEFBrowserProcessHandler_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.release() ? 1 : 0
}

func CEFBrowserProcessHandler_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.hasOneRef() ? 1 : 0
}

func CEFBrowserProcessHandler_onContextInitialized(ptr: CEFBrowserProcessHandler.ObjectPtrType) {
    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.onContextInitialized()
}

func CEFBrowserProcessHandler_onBeforeChildProcessLaunch(ptr: CEFBrowserProcessHandler.ObjectPtrType,
                                                         commandLine: UnsafeMutablePointer<cef_command_line_t>) {
    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.onBeforeChildProcessLaunch(CEFCommandLine.fromCEF(commandLine)!)
}

func CEFBrowserProcessHandler_onRenderProcessThreadCreated(ptr: CEFBrowserProcessHandler.ObjectPtrType,
                                                           userInfo: UnsafeMutablePointer<cef_list_value_t>) {
    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.onRenderProcessThreadCreated(CEFListValue.fromCEF(userInfo)!)
}

//func CEFBrowserProcessHandler_getPrintHandler(ptr: CEFBrowserProcessHandler.ObjectPtrType) -> UnsafeMutablePointer<cef_print_handler_t> {
//    guard let wrapper = CEFBrowserProcessHandler.lookup(CEFBrowserProcessHandler.ObjectPtrType(ptr)) else {
//        return nil
//    }
//    
//    return wrapper.getPrintHandler()
//}


