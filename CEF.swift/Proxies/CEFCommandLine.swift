//
//  CEFCommandLine.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_command_line_t: CEFObject {
}


public class CEFCommandLine: CEFProxy<cef_command_line_t> {
    public typealias ArgumentList = [String]
    public typealias SwitchMap = [String:String]
    
    public static func getGlobal() -> CEFCommandLine? {
        return CEFCommandLine(ptr: cef_command_line_get_global())
    }
    
    public init?() {
        super.init(ptr: cef_command_line_create())
    }
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    public func copy() -> CEFCommandLine? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFCommandLine.fromCEF(copiedObj)
    }

    public func initFromArguments(arguments: [String]) {
        let argv = CEFArgVFromArguments(arguments)
        cefObject.init_from_argv(cefObjectPtr, Int32(arguments.count), argv)
        argv.dealloc(arguments.count)
    }
    
    public func initFromString(commandLine: String) {
        let cefCmdLinePtr = CEFStringPtrCreateFromSwiftString(commandLine)
        defer { CEFStringPtrRelease(cefCmdLinePtr) }
        cefObject.init_from_string(cefObjectPtr, cefCmdLinePtr)
    }
    
    public func reset() {
        cefObject.reset(cefObjectPtr)
    }
    
    public func getArgv() -> [String] {
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
    
    public func getCommandLineString() -> String {
        let cefCmdLinePtr = cefObject.get_command_line_string(cefObjectPtr)
        defer { CEFStringPtrRelease(cefCmdLinePtr) }
        return CEFStringToSwiftString(cefCmdLinePtr.memory)
    }
    
    public func getProgram() -> String {
        let cefProgramPtr = cefObject.get_program(cefObjectPtr)
        defer { CEFStringPtrRelease(cefProgramPtr) }
        return CEFStringToSwiftString(cefProgramPtr.memory)
    }

    public func setProgram(program: String) {
        let cefProgramPtr = CEFStringPtrCreateFromSwiftString(program)
        defer { CEFStringPtrRelease(cefProgramPtr) }
        cefObject.set_program(cefObjectPtr, cefProgramPtr)
    }
    
    public func hasSwitches() -> Bool {
        return cefObject.has_switches(cefObjectPtr) != 0
    }
    
    public func hasSwitch(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_switch(cefObjectPtr, cefStrPtr) != 0
    }
    
    public func getSwitchValue(name: String) -> String {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = cefObject.get_switch_value(cefObjectPtr, cefStrPtr)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return cefValuePtr != nil ? CEFStringToSwiftString(cefValuePtr.memory) : ""
    }
    
    public func getSwitches() -> SwitchMap {
        let cefMap = cef_string_map_alloc()
        defer { cef_string_map_free(cefMap) }
        cefObject.get_switches(cefObjectPtr, cefMap)
        return CEFStringMapToSwiftDictionary(cefMap)
    }
    
    public func appendSwitch(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.append_switch(cefObjectPtr, cefStrPtr)
    }
    
    public func appendSwitchWithValue(name: String, value: String) {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = CEFStringPtrCreateFromSwiftString(value)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        cefObject.append_switch_with_value(cefObjectPtr, cefNamePtr, cefValuePtr)
    }
    
    public func hasArguments() -> Bool {
        return cefObject.has_arguments(cefObjectPtr) != 0
    }
    
    public func getArguments() -> ArgumentList {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        cefObject.get_arguments(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    public func appendArgument(arg: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(arg)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.append_argument(cefObjectPtr, cefStrPtr)
    }
    
    public func prependWrapper(wrapper: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(wrapper)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.prepend_wrapper(cefObjectPtr, cefStrPtr)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFCommandLine? {
        return CEFCommandLine(ptr: ptr)
    }
}

