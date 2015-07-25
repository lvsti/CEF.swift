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


public class CEFCommandLine: CEFProxyBase<cef_command_line_t> {
    typealias ArgumentList = [String]
    typealias SwitchMap = [String:String]
    
    static func getGlobal() -> CEFCommandLine? {
        return CEFCommandLine.fromCEF(cef_command_line_get_global())
    }
    
    init?() {
        super.init(ptr: cef_command_line_create())
    }
    
    func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    func copy() -> CEFCommandLine? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFCommandLine.fromCEF(copiedObj)
    }

    func initFromArguments(arguments: [String]) {
        let argv = CEFArgVFromArguments(arguments)
        cefObject.init_from_argv(cefObjectPtr, Int32(arguments.count), argv)
        argv.dealloc(arguments.count)
    }
    
    func initFromString(commandLine: String) {
        let cefCmdLinePtr = CEFStringPtrCreateFromSwiftString(commandLine)
        defer { CEFStringPtrRelease(cefCmdLinePtr) }
        cefObject.init_from_string(cefObjectPtr, cefCmdLinePtr)
    }
    
    func reset() {
        cefObject.reset(cefObjectPtr)
    }
    
    func getArgv() -> [String] {
        var argv = [String]()
        let cefList = cef_string_list_alloc()
        cefObject.get_argv(cefObjectPtr, cefList)
        
        let count = cef_string_list_size(cefList)
        let cefStrPtr = UnsafeMutablePointer<cef_string_t>.alloc(1)
        for i in 0..<count {
            cef_string_list_value(cefList, i, cefStrPtr)
            argv.append(CEFStringToSwiftString(cefStrPtr.memory))
        }
        cefStrPtr.dealloc(1)
        
        cef_string_list_free(cefList)
        
        return argv
    }
    
    func getCommandLineString() -> String {
        let cefCmdLinePtr = cefObject.get_command_line_string(cefObjectPtr)
        defer { CEFStringPtrRelease(cefCmdLinePtr) }
        return CEFStringToSwiftString(cefCmdLinePtr.memory)
    }
    
    func getProgram() -> String {
        let cefProgramPtr = cefObject.get_program(cefObjectPtr)
        defer { CEFStringPtrRelease(cefProgramPtr) }
        return CEFStringToSwiftString(cefProgramPtr.memory)
    }

    func setProgram(program: String) {
        let cefProgramPtr = CEFStringPtrCreateFromSwiftString(program)
        defer { CEFStringPtrRelease(cefProgramPtr) }
        cefObject.set_program(cefObjectPtr, cefProgramPtr)
    }
    
    func hasSwitches() -> Bool {
        return cefObject.has_switches(cefObjectPtr) != 0
    }
    
    func hasSwitch(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_switch(cefObjectPtr, cefStrPtr) != 0
    }
    
    func getSwitchValue(name: String) -> String {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = cefObject.get_switch_value(cefObjectPtr, cefStrPtr)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return CEFStringToSwiftString(cefValuePtr.memory)
    }
    
    func getSwitches() -> SwitchMap {
        let cefMap = cef_string_map_alloc()
        defer { cef_string_map_free(cefMap) }
        cefObject.get_switches(cefObjectPtr, cefMap)
        return CEFStringMapToSwiftDictionary(cefMap)
    }
    
    func appendSwitch(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.append_switch(cefObjectPtr, cefStrPtr)
    }
    
    func appendSwitchWithValue(name: String, value: String) {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = CEFStringPtrCreateFromSwiftString(value)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        cefObject.append_switch_with_value(cefObjectPtr, cefNamePtr, cefValuePtr)
    }
    
    func hasArguments() -> Bool {
        return cefObject.has_arguments(cefObjectPtr) != 0
    }
    
    func getArguments() -> ArgumentList {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        cefObject.get_arguments(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    func appendArgument(arg: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(arg)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.append_argument(cefObjectPtr, cefStrPtr)
    }
    
    func prependWrapper(wrapper: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(wrapper)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.prepend_wrapper(cefObjectPtr, cefStrPtr)
    }
    
}

