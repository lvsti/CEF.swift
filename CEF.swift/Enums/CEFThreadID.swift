//
//  CEFThreadID.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFThreadID: Int {
    case UI = 0
    case DB
    case File
    case FileUserBlocking
    case ProcessLauncher
    case Cache
    case IO
    case Renderer
}

extension CEFThreadID {
    func toCEF() -> cef_thread_id_t {
        return cef_thread_id_t(rawValue: UInt32(rawValue))
    }
}
