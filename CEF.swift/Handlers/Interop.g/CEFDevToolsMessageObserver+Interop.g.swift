//
//  CEFDevToolsMessageObserver+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_devtools_message_observer.h.
//

import Foundation

extension cef_dev_tools_message_observer_t: CEFObject {}

typealias CEFDevToolsMessageObserverMarshaller = CEFMarshaller<CEFDevToolsMessageObserver, cef_dev_tools_message_observer_t>

extension CEFDevToolsMessageObserver {
    func toCEF() -> UnsafeMutablePointer<cef_dev_tools_message_observer_t> {
        return CEFDevToolsMessageObserverMarshaller.pass(self)
    }
}

extension cef_dev_tools_message_observer_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        on_dev_tools_message = CEFDevToolsMessageObserver_on_dev_tools_message
        on_dev_tools_method_result = CEFDevToolsMessageObserver_on_dev_tools_method_result
        on_dev_tools_event = CEFDevToolsMessageObserver_on_dev_tools_event
        on_dev_tools_agent_attached = CEFDevToolsMessageObserver_on_dev_tools_agent_attached
        on_dev_tools_agent_detached = CEFDevToolsMessageObserver_on_dev_tools_agent_detached
    }
}
