//
//  CEFTask.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFTask_execute(ptr: UnsafeMutablePointer<cef_task_t>?) {
    guard let obj = CEFTaskMarshaller.get(ptr) else {
        return
    }
    
    obj.execute()
}

