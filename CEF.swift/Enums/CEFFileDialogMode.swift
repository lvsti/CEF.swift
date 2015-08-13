//
//  CEFFileDialogMode.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFFileDialogMode: RawRepresentable {
    public let rawValue: UInt32
    
    public enum Type: UInt8 {
        case Open = 0
        case OpenMultiple
        case OpenFolder
        case Save
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt32
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        public static let OverwritePrompt = Flags(rawValue: 0x01000000)
        public static let HideReadOnly = Flags(rawValue: 0x02000000)
    }
    
    public var type: Type { get { return Type(rawValue: UInt8(rawValue & FILE_DIALOG_TYPE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: rawValue & ~FILE_DIALOG_TYPE_MASK.rawValue) } }
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
}

extension CEFFileDialogMode {
    func toCEF() -> cef_file_dialog_mode_t {
        return cef_file_dialog_mode_t(rawValue: UInt32(type.rawValue) | flags.rawValue)
    }
    
    static func fromCEF(value: cef_file_dialog_mode_t) -> CEFFileDialogMode {
        return CEFFileDialogMode(rawValue: value.rawValue)
    }
}

