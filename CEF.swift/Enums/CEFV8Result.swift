//
//  CEFV8Result.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFV8Result {
    case Success(CEFV8Value)
    case Failure(String)
}

public enum CEFV8VoidResult {
    case Success
    case Failure(String)
}

public enum CEFV8EvalResult {
    case Success(CEFV8Value)
    case Failure(CEFV8Exception)
}
