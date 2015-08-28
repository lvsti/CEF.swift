//
//  CEFTask+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_task.h.
//

import Foundation

extension cef_task_t: CEFObject {}

typealias CEFTaskMarshaller = CEFMarshaller<CEFTask, cef_task_t>

extension CEFTask {
    func toCEF() -> UnsafeMutablePointer<cef_task_t> {
        return CEFTaskMarshaller.pass(self)
    }
}

extension cef_task_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        execute = CEFTask_execute
    }
}
