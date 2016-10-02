//
//  CEFInsets.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing insets.
public struct CEFInsets {
    public let top: Int
    public let left: Int
    public let bottom: Int
    public let right: Int
}

extension CEFInsets {
    func toCEF() -> cef_insets_t {
        return cef_insets_t(top: Int32(top), left: Int32(left), bottom: Int32(bottom), right: Int32(right))
    }
    
    static func fromCEF(_ value: cef_insets_t) -> CEFInsets {
        return CEFInsets(top: Int(value.top), left: Int(value.left), bottom: Int(value.bottom), right: Int(value.right))
    }
}
