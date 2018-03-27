//
//  CEFV8ExceptionWrapper.swift
//  CEF.swift
//
//  Created by Morris on 26/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFV8ExceptionWrapper: ICEFV8Exception {
    public var message: String = ""
    public var sourceLine: String = ""
    public var scriptResourceName: String = ""
    public var lineNumber: Int = 0
    public var startPosition: Int = 0
    public var endPosition: Int = 0
    public var startColumn: Int = 0
    public var endColumn: Int = 0
}
