//
//  CEFFrame.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_frame_t: CEFObject {
}

public class CEFFrame: CEFProxy<cef_frame_t> {
    
    typealias Identifier = Int64
    
    static func fromCEF() -> CEFFrame? {
        return nil
    }
    
}
