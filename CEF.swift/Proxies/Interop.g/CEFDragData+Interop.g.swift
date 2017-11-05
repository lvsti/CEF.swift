//
//  CEFDragData+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_drag_data.h.
//

import Foundation

extension cef_drag_data_t: CEFObject {}

/// Class used to represent drag data. The methods of this class may be called
/// on any thread.
/// CEF name: `CefDragData`
public final class CEFDragData: CEFProxy<cef_drag_data_t> {
    override init?(ptr: UnsafeMutablePointer<cef_drag_data_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_drag_data_t>?) -> CEFDragData? {
        return CEFDragData(ptr: ptr)
    }
}

