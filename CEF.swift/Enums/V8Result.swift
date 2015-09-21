//
//  V8Result.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum V8Result {
    case Success(V8Value)
    case Failure(String)
}

public enum V8VoidResult {
    case Success
    case Failure(String)
}

