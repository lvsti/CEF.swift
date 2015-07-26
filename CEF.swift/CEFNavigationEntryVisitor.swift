//
//  CEFNavigationEntryVisitor.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_navigation_entry_visitor_t: CEFObject {
}

class CEFNavigationEntryVisitorMarshaller: CEFMarshaller<cef_navigation_entry_visitor_t, CEFNavigationEntryVisitor> {
    override init(obj: CEFNavigationEntryVisitor) {
        super.init(obj: obj)
        cefStruct.visit = CEFNavigationEntryVisitor_visit
    }
}

public class CEFNavigationEntryVisitor: CEFHandler {
    public func visit(entry: CEFNavigationEntry, isCurrent: Bool, index: Int, totalCount: Int) -> Bool {
        return false
    }
    
    func toCEF() -> UnsafeMutablePointer<cef_navigation_entry_visitor_t> {
        return CEFNavigationEntryVisitorMarshaller.pass(self)
    }
}

func CEFNavigationEntryVisitor_visit(ptr: UnsafeMutablePointer<cef_navigation_entry_visitor_t>,
                                     entry: UnsafeMutablePointer<cef_navigation_entry_t>,
                                     isCurrent: Int32,
                                     index: Int32,
                                     totalCount: Int32) -> Int32 {
    guard let obj = CEFNavigationEntryVisitorMarshaller.get(ptr) else {
        return 0
    }
    
    return obj.visit(CEFNavigationEntry.fromCEF(entry)!,
                     isCurrent: isCurrent != 0,
                     index: Int(index),
                     totalCount: Int(totalCount)) ? 1 : 0
}
