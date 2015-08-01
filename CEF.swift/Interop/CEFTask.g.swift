//
//  CEFTask.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_task_t: CEFObject {
}

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

func CEFTask_execute(ptr: UnsafeMutablePointer<cef_task_t>) {
    guard let obj = CEFTaskMarshaller.get(ptr) else {
        return
    }
    
    obj.execute()
}

