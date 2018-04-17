//
//  CEFCommandLine.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

public extension CEFCommandLine {
    
    /// Returns the singleton global CefCommandLine object. The returned object
    /// will be read-only.
    /// CEF name: `GetGlobalCommandLine`
    public static var globalCommandLine: CEFCommandLine? {
        return CEFCommandLine(ptr: cef_command_line_get_global())
    }
    
    /// Create a new CefCommandLine instance.
    /// CEF name: `CreateCommandLine`
    public convenience init?() {
        self.init(ptr: cef_command_line_create())
    }
    
    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Returns a writable copy of this object.
    /// CEF name: `Copy`
    public func copy() -> CEFCommandLine? {
        if let copiedObj = cefObject.copy(cefObjectPtr) {
            return CEFCommandLine.fromCEF(copiedObj)
        }
        return nil
    }

    /// Initialize the command line with the specified |argc| and |argv| values.
    /// The first argument must be the name of the program. This method is only
    /// supported on non-Windows platforms.
    /// CEF name: `InitFromArgv`
    public func initFromArguments(arguments: [String]) {
        let argv = CEFArgVFromArguments(arguments)
        let constArgv = UnsafeRawPointer(argv).assumingMemoryBound(to: (UnsafePointer<Int8>?).self)
        cefObject.init_from_argv(cefObjectPtr, Int32(arguments.count), constArgv)
        argv.deallocate()
    }
    
    /// Initialize the command line with the string returned by calling
    /// GetCommandLineW(). This method is only supported on Windows.
    /// CEF name: `InitFromString`
    public func initFromString(commandLine: String) {
        let cefCmdLinePtr = CEFStringPtrCreateFromSwiftString(commandLine)
        defer { CEFStringPtrRelease(cefCmdLinePtr) }
        cefObject.init_from_string(cefObjectPtr, cefCmdLinePtr)
    }
    
    /// Reset the command-line switches and arguments but leave the program
    /// component unchanged.
    /// CEF name: `Reset`
    public func reset() {
        cefObject.reset(cefObjectPtr)
    }
    
    /// Retrieve the original command line string as a vector of strings.
    /// The argv array: { program, [(--|-|/)switch[=value]]*, [--], [argument]* }
    /// CEF name: `GetArgv`
    public var argv: [String] {
        var argv = [String]()
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        
        cefObject.get_argv(cefObjectPtr, cefList)
        
        let count = cef_string_list_size(cefList)
        var cefStr = cef_string_t()

        for i in 0..<count {
            cef_string_list_value(cefList, i, &cefStr)
            argv.append(CEFStringToSwiftString(cefStr))
        }
        
        return argv
    }
    
    /// Constructs and returns the represented command line string. Use this method
    /// cautiously because quoting behavior is unclear.
    /// CEF name: `GetCommandLineString`
    public var stringValue: String {
        let cefCmdLinePtr = cefObject.get_command_line_string(cefObjectPtr)
        defer { CEFStringPtrRelease(cefCmdLinePtr) }
        return CEFStringPtrToSwiftString(cefCmdLinePtr, defaultValue: "")
    }
    
    /// The program part of the command line string (the first item).
    /// CEF name: `GetProgram`, `SetProgram`
    public var program: String {
        get {
            let cefProgramPtr = cefObject.get_program(cefObjectPtr)
            defer { CEFStringPtrRelease(cefProgramPtr) }
            return CEFStringPtrToSwiftString(cefProgramPtr, defaultValue: "")
        }
        set {
            let cefProgramPtr = CEFStringPtrCreateFromSwiftString(newValue)
            defer { CEFStringPtrRelease(cefProgramPtr) }
            cefObject.set_program(cefObjectPtr, cefProgramPtr)
        }
    }
    
    /// Returns true if the command line has switches.
    /// CEF name: `HasSwitches`
    public var hasSwitches: Bool {
        return cefObject.has_switches(cefObjectPtr) != 0
    }
    
    /// Returns true if the command line contains the given switch.
    /// CEF name: `HasSwitch`
    public func hasSwitch(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_switch(cefObjectPtr, cefStrPtr) != 0
    }
    
    /// Returns the value associated with the given switch. If the switch has no
    /// value or isn't present this method returns the empty string.
    /// CEF name: `GetSwitchValue`
    public func switchValue(for name: String) -> String? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = cefObject.get_switch_value(cefObjectPtr, cefStrPtr)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return CEFStringPtrToSwiftString(cefValuePtr)
    }
    
    /// Returns the map of switch names and values. If a switch has no value an
    /// empty string is returned.
    /// CEF name: `GetSwitches`
    public var allSwitches: [String: String] {
        let cefMap = cef_string_map_alloc()
        defer { cef_string_map_free(cefMap) }
        cefObject.get_switches(cefObjectPtr, cefMap)
        return CEFStringMapToSwiftDictionary(cefMap)
    }
    
    /// Add a switch to the end of the command line. If the switch has no value
    /// pass an empty value string.
    /// CEF name: `AppendSwitch`
    public func appendSwitch(_ name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.append_switch(cefObjectPtr, cefStrPtr)
    }
    
    /// Add a switch with the specified value to the end of the command line.
    /// CEF name: `AppendSwitchWithValue`
    public func appendSwitch(name: String, value: String) {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = CEFStringPtrCreateFromSwiftString(value)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        cefObject.append_switch_with_value(cefObjectPtr, cefNamePtr, cefValuePtr)
    }
    
    /// True if there are remaining command line arguments.
    /// CEF name: `HasArguments`
    public var hasArguments: Bool {
        return cefObject.has_arguments(cefObjectPtr) != 0
    }
    
    /// Get the remaining command line arguments.
    /// CEF name: `GetArguments`
    public var arguments: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        cefObject.get_arguments(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Add an argument to the end of the command line.
    /// CEF name: `AppendArgument`
    public func appendArgument(_ arg: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(arg)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.append_argument(cefObjectPtr, cefStrPtr)
    }
    
    /// Insert a command before the current command.
    /// Common for debuggers, like "valgrind" or "gdb --args".
    /// CEF name: `PrependWrapper`
    public func prependWrapper(_ wrapper: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(wrapper)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.prepend_wrapper(cefObjectPtr, cefStrPtr)
    }
    
}

