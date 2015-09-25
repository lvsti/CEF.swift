//
//  CEFNavigationEntry+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_navigation_entry.h.
//

import Foundation

extension cef_navigation_entry_t: CEFObject {}

/// Class used to represent an entry in navigation history.
public class CEFNavigationEntry: CEFProxy<cef_navigation_entry_t> {
    override init?(ptr: UnsafeMutablePointer<cef_navigation_entry_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_navigation_entry_t>) -> CEFNavigationEntry? {
        return CEFNavigationEntry(ptr: ptr)
    }
}

