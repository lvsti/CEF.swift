//
//  CEFAPIHashUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 04. 07..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFAPIHashType: Int32 {
    case platform = 0
    case universal = 1
    case commit = 2
}

/// The API hash is created by analyzing CEF header files for C API type
/// definitions. The hash value will change when header files are modified in a
/// way that may cause binary incompatibility with other builds. The universal
/// hash value will change if any platform is affected whereas the platform hash
/// values will change only if that particular platform is affected.
public enum CEFAPIHashUtils {
    /// Returns CEF API hashes for the libcef library. The returned string is owned
    /// by the library and should not be freed. The |entry| parameter describes which
    /// hash value will be returned:
    /// 0 - CEF_API_HASH_PLATFORM
    /// 1 - CEF_API_HASH_UNIVERSAL
    /// 2 - CEF_COMMIT_HASH (from cef_version.h)
    public func apiHash(for type: CEFAPIHashType) -> String {
        return String(cString: cef_api_hash(type.rawValue))
    }
}
