//
//  Task+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_task.h.
//

import Foundation

extension cef_task_t: CEFObject {}

typealias TaskMarshaller = Marshaller<Task, cef_task_t>

extension Task {
    func toCEF() -> UnsafeMutablePointer<cef_task_t> {
        return TaskMarshaller.pass(self)
    }
}

extension cef_task_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        execute = Task_execute
    }
}
