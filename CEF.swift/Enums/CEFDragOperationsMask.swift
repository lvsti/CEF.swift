//
//  CEFDragOperationsMask.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFDragOperationsMask: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    public static let None = CEFDragOperationsMask(rawValue: 0)
    public static let Copy = CEFDragOperationsMask(rawValue: 1)
    public static let Link = CEFDragOperationsMask(rawValue: 2)
    public static let Generic = CEFDragOperationsMask(rawValue: 4)
    public static let Private = CEFDragOperationsMask(rawValue: 8)
    public static let Move = CEFDragOperationsMask(rawValue: 16)
    public static let Delete = CEFDragOperationsMask(rawValue: 32)
    public static let Every = CEFDragOperationsMask(rawValue: ~0)
}

extension CEFDragOperationsMask {
    func toCEF() -> cef_drag_operations_mask_t {
        return cef_drag_operations_mask_t(rawValue: UInt32(rawValue))
    }
}

