//
//  PathKey.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Path key values.
public enum PathKey: Int32 {

    /// Current directory.
    case DirCurrent

    /// Directory containing PK_FILE_EXE.
    case DirExe

    /// Directory containing PK_FILE_MODULE.
    case DirModule

    /// Temporary directory.
    case DirTemp

    /// Path and filename of the current executable.
    case FileExe

    /// Path and filename of the module containing the CEF code (usually the libcef
    /// module).
    case FileModule

    /// "Local Settings\Application Data" directory under the user profile
    /// directory on Windows.
    case LocalAppData

    /// "Application Data" directory under the user profile directory on Windows
    /// and "~/Library/Application Support" directory on Mac OS X.
    case UserData
}

extension PathKey {
    static func fromCEF(value: cef_path_key_t) -> PathKey {
        return PathKey(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_path_key_t {
        return cef_path_key_t(rawValue: UInt32(rawValue))
    }
}

