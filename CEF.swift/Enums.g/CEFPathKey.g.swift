//
//  CEFPathKey.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Path key values.
/// CEF name: `cef_path_key_t`.
public enum CEFPathKey: Int32 {

    /// Current directory.
    /// CEF name: `PK_DIR_CURRENT`.
    case dirCurrent

    /// Directory containing PK_FILE_EXE.
    /// CEF name: `PK_DIR_EXE`.
    case dirExe

    /// Directory containing PK_FILE_MODULE.
    /// CEF name: `PK_DIR_MODULE`.
    case dirModule

    /// Temporary directory.
    /// CEF name: `PK_DIR_TEMP`.
    case dirTemp

    /// Path and filename of the current executable.
    /// CEF name: `PK_FILE_EXE`.
    case fileExe

    /// Path and filename of the module containing the CEF code (usually the libcef
    /// module).
    /// CEF name: `PK_FILE_MODULE`.
    case fileModule

    /// "Local Settings\Application Data" directory under the user profile
    /// directory on Windows.
    /// CEF name: `PK_LOCAL_APP_DATA`.
    case localAppData

    /// "Application Data" directory under the user profile directory on Windows
    /// and "~/Library/Application Support" directory on Mac OS X.
    /// CEF name: `PK_USER_DATA`.
    case userData

    /// Directory containing application resources. Can be configured via
    /// CefSettings.resources_dir_path.
    /// CEF name: `PK_DIR_RESOURCES`.
    case dirResources
}

extension CEFPathKey {
    static func fromCEF(_ value: cef_path_key_t) -> CEFPathKey {
        return CEFPathKey(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_path_key_t {
        return cef_path_key_t(rawValue: UInt32(rawValue))
    }
}

