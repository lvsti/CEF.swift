//
//  CEFCommandLine.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_command_line_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}


public class CEFCommandLine: CEFBase<cef_command_line_t> {
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
        let cefCmdLinePtr = CEFStringPtrFromSwiftString(commandLine)
        cefObject.init_from_string(cefObjectPtr, cefCmdLinePtr)
        cef_string_userfree_utf16_free(cefCmdLinePtr)
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
        let retval = CEFStringToSwiftString(cefCmdLinePtr.memory)
        cef_string_userfree_utf16_free(cefCmdLinePtr)
        return retval
    }
    
    func getProgram() -> String {
        let cefProgramPtr = cefObject.get_program(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefProgramPtr.memory)
        cef_string_userfree_utf16_free(cefProgramPtr)
        return retval
    }

    func setProgram(program: String) {
        let cefProgramPtr = CEFStringPtrFromSwiftString(program)
        cefObject.set_program(cefObjectPtr, cefProgramPtr)
        cef_string_userfree_utf16_free(cefProgramPtr)
    }
    
    func hasSwitches() -> Bool {
        return cefObject.has_switches(cefObjectPtr) != 0
    }
    
    func hasSwitch(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        let retval = cefObject.has_switch(cefObjectPtr, cefStrPtr) != 0
        cef_string_userfree_utf16_free(cefStrPtr)
        return retval
    }
    
    func getSwitchValue(name: String) -> String {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        let cefValuePtr = cefObject.get_switch_value(cefObjectPtr, cefStrPtr)
        let retval = CEFStringToSwiftString(cefValuePtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        cef_string_userfree_utf16_free(cefValuePtr)
        return retval
    }
    
    func getSwitches() -> SwitchMap {
        let cefMap = cef_string_map_alloc()
        cefObject.get_switches(cefObjectPtr, cefMap)
        let retval = CEFStringMapToSwiftDictionary(cefMap)
        cef_string_map_free(cefMap)
        return retval
    }
    
    func appendSwitch(name: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        cefObject.append_switch(cefObjectPtr, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
    func appendSwitchWithValue(name: String, value: String) {
        let cefNamePtr = CEFStringPtrFromSwiftString(name)
        let cefValuePtr = CEFStringPtrFromSwiftString(value)
        cefObject.append_switch_with_value(cefObjectPtr, cefNamePtr, cefValuePtr)
        cef_string_userfree_utf16_free(cefNamePtr)
        cef_string_userfree_utf16_free(cefValuePtr)
    }
    
    func hasArguments() -> Bool {
        return cefObject.has_arguments(cefObjectPtr) != 0
    }
    
    func getArguments() -> ArgumentList {
        let cefList = cef_string_list_alloc()
        cefObject.get_arguments(cefObjectPtr, cefList)
        let arguments = CEFStringListToSwiftArray(cefList)
        cef_string_list_free(cefList)
        return arguments
    }
    
    func appendArgument(arg: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(arg)
        cefObject.append_argument(cefObjectPtr, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
    func prependWrapper(wrapper: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(wrapper)
        cefObject.prepend_wrapper(cefObjectPtr, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
}

