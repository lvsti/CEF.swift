//
//  CEFFileDialogMode.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFFileDialogMode: RawRepresentable {
    public let rawValue: UInt
    
    public enum Type: UInt8 {
        case Open = 0
        case OpenMultiple
        case OpenFolder
        case Save
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        public static let OverwritePrompt = Flags(rawValue: 0x01000000)
        public static let HideReadOnly = Flags(rawValue: 0x02000000)
    }
    
    public var type: Type { get { return Type(rawValue: UInt8(UInt32(rawValue) & FILE_DIALOG_TYPE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: UInt(UInt32(rawValue) & ~FILE_DIALOG_TYPE_MASK.rawValue)) } }
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

extension CEFFileDialogMode {
    func toCEF() -> cef_file_dialog_mode_t {
        return cef_file_dialog_mode_t(rawValue: UInt32(type.rawValue) | UInt32(flags.rawValue))
    }
}

