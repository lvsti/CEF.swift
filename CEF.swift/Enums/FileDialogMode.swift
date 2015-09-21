//
//  FileDialogMode.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Supported file dialog modes.
public struct FileDialogMode: RawRepresentable {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    public enum Type: UInt8 {
        /// Requires that the file exists before allowing the user to pick it.
        case Open = 0

        /// Like Open, but allows picking multiple files to open.
        case OpenMultiple
        
        /// Like Open, but selects a folder to open.
        case OpenFolder
        
        /// Allows picking a nonexistent file, and prompts to overwrite if the file
        /// already exists.
        case Save
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt32
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        /// Prompt to overwrite if the user selects an existing file with the Save
        /// dialog.
        public static let OverwritePrompt = Flags(rawValue: 0x01000000)

        /// Do not display read-only files.
        public static let HideReadOnly = Flags(rawValue: 0x02000000)
    }
    
    public var type: Type { get { return Type(rawValue: UInt8(rawValue & FILE_DIALOG_TYPE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: rawValue & ~FILE_DIALOG_TYPE_MASK.rawValue) } }
}

extension FileDialogMode {
    func toCEF() -> cef_file_dialog_mode_t {
        return cef_file_dialog_mode_t(rawValue: UInt32(type.rawValue) | flags.rawValue)
    }
    
    static func fromCEF(value: cef_file_dialog_mode_t) -> FileDialogMode {
        return FileDialogMode(rawValue: value.rawValue)
    }
}

