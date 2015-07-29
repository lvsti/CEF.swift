//
//  CEFDragData.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_drag_data_t: CEFObject {
}

public class CEFDragData: CEFProxy<cef_drag_data_t> {
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDragData? {
        return CEFDragData(ptr: ptr)
    }
}
