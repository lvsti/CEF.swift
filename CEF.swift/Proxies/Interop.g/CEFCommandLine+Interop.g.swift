//
//  CEFCommandLine+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_command_line.h.
//

import Foundation

extension cef_command_line_t: CEFObject {}

/// Class used to create and/or parse command line arguments. Arguments with
/// '--', '-' and, on Windows, '/' prefixes are considered switches. Switches
/// will always precede any arguments without switch prefixes. Switches can
/// optionally have a value specified using the '=' delimiter (e.g.
/// "-switch=value"). An argument of "--" will terminate switch parsing with all
/// subsequent tokens, regardless of prefix, being interpreted as non-switch
/// arguments. Switch names are considered case-insensitive. This class can be
/// used before CefInitialize() is called.
/// CEF name: `CefCommandLine`
public class CEFCommandLine: CEFProxy<cef_command_line_t> {
    override init?(ptr: UnsafeMutablePointer<cef_command_line_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_command_line_t>?) -> CEFCommandLine? {
        return CEFCommandLine(ptr: ptr)
    }
}

