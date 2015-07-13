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
    
    static func getGlobal() -> CEFCommandLine {
        return CEFCommandLine(proxiedObject: cef_command_line_get_global().memory)
    }
    
    init() {
        super.init(pointer: cef_command_line_create())
    }
    
    override init(proxiedObject obj: cef_command_line_t) {
        super.init(proxiedObject: obj)
    }
    
    func isValid() -> Bool {
        return object.is_valid(cefSelf) != 0
    }
    
    func isReadOnly() -> Bool {
        return object.is_read_only(cefSelf) != 0
    }
    
    func copy() -> CEFCommandLine {
        let copiedObj = object.copy(cefSelf)
        return CEFCommandLine(proxiedObject: copiedObj.memory)
    }

    func initFromArguments(arguments: [String]) {
        let argv = CEFArgVFromArguments(arguments)
        object.init_from_argv(cefSelf, Int32(arguments.count), argv)
        argv.dealloc(arguments.count)
    }
    
    func initFromString(commandLine: String) {
        let cefCmdLinePtr = CEFStringPtrFromSwiftString(commandLine)
        object.init_from_string(cefSelf, cefCmdLinePtr)
        cef_string_userfree_utf16_free(cefCmdLinePtr)
    }
    
    func reset() {
        object.reset(cefSelf)
    }
    
    func getArgv() -> [String] {
        var argv = [String]()
        let cefList = cef_string_list_alloc()
        object.get_argv(cefSelf, cefList)
        
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
        let cefCmdLinePtr = object.get_command_line_string(cefSelf)
        let retval = CEFStringToSwiftString(cefCmdLinePtr.memory)
        cef_string_userfree_utf16_free(cefCmdLinePtr)
        return retval
    }
    
    func getProgram() -> String {
        let cefProgramPtr = object.get_program(cefSelf)
        let retval = CEFStringToSwiftString(cefProgramPtr.memory)
        cef_string_userfree_utf16_free(cefProgramPtr)
        return retval
    }

    func setProgram(program: String) {
        let cefProgramPtr = CEFStringPtrFromSwiftString(program)
        object.set_program(cefSelf, cefProgramPtr)
        cef_string_userfree_utf16_free(cefProgramPtr)
    }
    
    func hasSwitches() -> Bool {
        return object.has_switches(cefSelf) != 0
    }
    
    func hasSwitch(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        let retval = object.has_switch(cefSelf, cefStrPtr) != 0
        cef_string_userfree_utf16_free(cefStrPtr)
        return retval
    }
    
    func getSwitchValue(name: String) -> String {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        let cefValuePtr = object.get_switch_value(cefSelf, cefStrPtr)
        let retval = CEFStringToSwiftString(cefValuePtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        cef_string_userfree_utf16_free(cefValuePtr)
        return retval
    }
    
    func getSwitches() -> SwitchMap {
        let cefMap = cef_string_map_alloc()
        object.get_switches(cefSelf, cefMap)
        let retval = CEFStringMapToSwiftDictionary(cefMap)
        cef_string_map_free(cefMap)
        return retval
    }
    
    func appendSwitch(name: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(name)
        object.append_switch(cefSelf, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
    func appendSwitchWithValue(name: String, value: String) {
        let cefNamePtr = CEFStringPtrFromSwiftString(name)
        let cefValuePtr = CEFStringPtrFromSwiftString(value)
        object.append_switch_with_value(cefSelf, cefNamePtr, cefValuePtr)
        cef_string_userfree_utf16_free(cefNamePtr)
        cef_string_userfree_utf16_free(cefValuePtr)
    }
    
    func hasArguments() -> Bool {
        return object.has_arguments(cefSelf) != 0
    }
    
    func getArguments() -> ArgumentList {
        let cefList = cef_string_list_alloc()
        object.get_arguments(cefSelf, cefList)
        let arguments = CEFStringListToSwiftArray(cefList)
        cef_string_list_free(cefList)
        return arguments
    }
    
    func appendArgument(arg: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(arg)
        object.append_argument(cefSelf, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
    func prependWrapper(wrapper: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(wrapper)
        object.prepend_wrapper(cefSelf, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
}

