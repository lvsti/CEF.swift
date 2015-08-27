//
//  CEFPageRange.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing a print job page range.
public struct CEFPageRange {
    public let from: Int
    public let to: Int
}

extension CEFPageRange {
    func toCEF() -> cef_page_range_t {
        return cef_page_range_t(from: Int32(from), to: Int32(to))
    }
    
    static func fromCEF(value: cef_page_range_t) -> CEFPageRange {
        return CEFPageRange(from: Int(value.from), to: Int(value.to))
    }
}
