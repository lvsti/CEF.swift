//
//  CEFNavigationEntryVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFNavigationEntryVisitor_visit(ptr: UnsafeMutablePointer<cef_navigation_entry_visitor_t>?,
                                     entry: UnsafeMutablePointer<cef_navigation_entry_t>?,
                                     isCurrent: Int32,
                                     index: Int32,
                                     totalCount: Int32) -> Int32 {
    guard let obj = CEFNavigationEntryVisitorMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.visit(entry: CEFNavigationEntry.fromCEF(entry)!,
                           isCurrent: isCurrent != 0,
                           index: Int(index),
                           totalCount: Int(totalCount))
    return action == .continueVisiting ? 1 : 0
}
