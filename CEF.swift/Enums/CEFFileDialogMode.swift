//
//  CEFFileDialogMode.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Supported file dialog modes.
/// CEF name: `cef_file_dialog_mode_t`
public struct CEFFileDialogMode: RawRepresentable {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    public enum DialogType: UInt8 {
        /// Requires that the file exists before allowing the user to pick it.
        /// CEF name: `FILE_DIALOG_OPEN`
        case open = 0

        /// Like Open, but allows picking multiple files to open.
        /// CEF name: `FILE_DIALOG_OPEN_MULTIPLE`
        case openMultiple
        
        /// Like Open, but selects a folder to open.
        /// CEF name: `FILE_DIALOG_OPEN_FOLDER`
        case openFolder
        
        /// Allows picking a nonexistent file, and prompts to overwrite if the file
        /// already exists.
        /// CEF name: `FILE_DIALOG_SAVE`
        case save
    }
    
    public struct Flags: OptionSet {
        public let rawValue: UInt32
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        /// Prompt to overwrite if the user selects an existing file with the Save
        /// dialog.
        /// CEF name: `FILE_DIALOG_OVERWRITEPROMPT_FLAG`
        public static let overwritePrompt = Flags(rawValue: 0x01000000)

        /// Do not display read-only files.
        /// CEF name: `FILE_DIALOG_HIDEREADONLY_FLAG`
        public static let hideReadOnly = Flags(rawValue: 0x02000000)
    }
    
    public var type: DialogType { get { return DialogType(rawValue: UInt8(rawValue & FILE_DIALOG_TYPE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: rawValue & ~FILE_DIALOG_TYPE_MASK.rawValue) } }
}

extension CEFFileDialogMode {
    func toCEF() -> cef_file_dialog_mode_t {
        return cef_file_dialog_mode_t(rawValue: UInt32(type.rawValue) | flags.rawValue)
    }
    
    static func fromCEF(_ value: cef_file_dialog_mode_t) -> CEFFileDialogMode {
        return CEFFileDialogMode(rawValue: value.rawValue)
    }
}

