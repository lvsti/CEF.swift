//
//  CEFV8Result.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFV8Result {
    case success(CEFV8Value)
    case failure(String)
}

public enum CEFV8VoidResult {
    case success
    case failure(String)
}

public enum CEFV8EvalResult {
    case success(CEFV8Value)
    case failure(CEFV8Exception)
}
