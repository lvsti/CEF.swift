//
//  CEFProcessID.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFProcessID: Int {
    case Browser = 0
    case Renderer
}

extension CEFProcessID {
    func toCEF() -> cef_process_id_t {
        return cef_process_id_t(rawValue: UInt32(rawValue))
    }
}

