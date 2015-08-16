//
//  CEFV8Value.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


extension cef_v8value_t: CEFObject {
}


public class CEFV8Value: CEFProxy<cef_v8value_t> {
 
    public typealias AccessControl = CEFV8AccessControl
    public typealias PropertyAttribute = CEFV8PropertyAttribute

    public static func createUndefined() -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_undefined())
    }
    
    public static func createNull() -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_null())
    }
    
    public static func createBool(value: Bool) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_bool(value ? 1 : 0))
    }

    public static func createInt(value: Int) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_int(Int32(value)))
    }

    public static func createUInt(value: UInt) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_uint(UInt32(value)))
    }
    
    public static func createDouble(value: Double) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_double(value))
    }
    
    public static func createDate(value: NSDate) -> CEFV8Value? {
        let cefTimePtr = CEFTimePtrCreateFromNSDate(value)
        defer { CEFTimePtrRelease(cefTimePtr) }
        return CEFV8Value.fromCEF(cef_v8value_create_date(cefTimePtr))
    }
    
    public static func createString(value: String) -> CEFV8Value? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(value)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFV8Value.fromCEF(cef_v8value_create_string(cefStrPtr))
    }

    public static func createObject(accessor: CEFV8Accessor?) -> CEFV8Value? {
        let cefAccessorPtr = (accessor != nil) ? accessor!.toCEF() : nil
        return CEFV8Value.fromCEF(cef_v8value_create_object(cefAccessorPtr))
    }

    public static func createArray(length: Int) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_array(Int32(length)))
    }
    
    public static func createFunction(name: String, handler: CEFV8Handler?) -> CEFV8Value? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefHandlerPtr = (handler != nil) ? handler!.toCEF() : nil
        return CEFV8Value.fromCEF(cef_v8value_create_function(cefStrPtr, cefHandlerPtr))
    }
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func isUndefined() -> Bool {
        return cefObject.is_undefined(cefObjectPtr) != 0
    }

    public func isNull() -> Bool {
        return cefObject.is_null(cefObjectPtr) != 0
    }

    public func isBool() -> Bool {
        return cefObject.is_bool(cefObjectPtr) != 0
    }
    
    public func isInt() -> Bool {
        return cefObject.is_int(cefObjectPtr) != 0
    }
    
    public func isUInt() -> Bool {
        return cefObject.is_uint(cefObjectPtr) != 0
    }

    public func isDouble() -> Bool {
        return cefObject.is_double(cefObjectPtr) != 0
    }
    
    public func isDate() -> Bool {
        return cefObject.is_date(cefObjectPtr) != 0
    }

    public func isString() -> Bool {
        return cefObject.is_string(cefObjectPtr) != 0
    }
    
    public func isObject() -> Bool {
        return cefObject.is_object(cefObjectPtr) != 0
    }
    
    public func isArray() -> Bool {
        return cefObject.is_array(cefObjectPtr) != 0
    }

    public func isFunction() -> Bool {
        return cefObject.is_function(cefObjectPtr) != 0
    }

    public func isSame(other: CEFV8Value) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    public func getBoolValue() -> Bool {
        return cefObject.get_bool_value(cefObjectPtr) != 0
    }
    
    public func getIntValue() -> Int {
        return Int(cefObject.get_int_value(cefObjectPtr))
    }
    
    public func getUIntValue() -> UInt {
        return UInt(cefObject.get_uint_value(cefObjectPtr))
    }
    
    public func getDoubleValue() -> Double {
        return cefObject.get_double_value(cefObjectPtr)
    }

    public func getDateValue() -> NSDate {
        let cefTime = cefObject.get_date_value(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }

    public func getStringValue() -> String {
        let cefStrPtr = cefObject.get_string_value(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    // object methods
    
    public func isUserCreated() -> Bool {
        return cefObject.is_user_created(cefObjectPtr) != 0
    }

    public func hasException() -> Bool {
        return cefObject.has_exception(cefObjectPtr) != 0
    }
    
    public func getException() -> CEFV8Exception? {
        let cefExc = cefObject.get_exception(cefObjectPtr)
        return CEFV8Exception.fromCEF(cefExc)
    }
    
    public func clearException() -> Bool {
        return cefObject.clear_exception(cefObjectPtr) != 0
    }
    
    public func willRethrowExceptions() -> Bool {
        return cefObject.will_rethrow_exceptions(cefObjectPtr) != 0
    }
    
    public func setRethrowExcepions(value: Bool) -> Bool {
        return cefObject.set_rethrow_exceptions(cefObjectPtr, value ? 1 : 0) != 0
    }

    public func hasValue(forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.has_value_bykey(cefObjectPtr, cefKeyPtr) != 0
    }

    public func hasValue(atIndex index: Int) -> Bool {
        return cefObject.has_value_byindex(cefObjectPtr, Int32(index)) != 0
    }
    
    public func deleteValue(forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.delete_value_bykey(cefObjectPtr, cefKeyPtr) != 0
    }
    
    public func deleteValue(atIndex index: Int) -> Bool {
        return cefObject.delete_value_byindex(cefObjectPtr, Int32(index)) != 0
    }

    public func getValue(forKey key: String) -> CEFV8Value? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefValue = cefObject.get_value_bykey(cefObjectPtr, cefKeyPtr)
        return CEFV8Value.fromCEF(cefValue)
    }

    public func getValue(atIndex index: Int) -> CEFV8Value? {
        let cefValue = cefObject.get_value_byindex(cefObjectPtr, Int32(index))
        return CEFV8Value.fromCEF(cefValue)
    }

    public func setValue(value: CEFV8Value, forKey key: String, attribute: PropertyAttribute) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value_bykey(cefObjectPtr, cefKeyPtr, value.toCEF(), attribute.toCEF()) != 0
    }

    public func setValue(value: CEFV8Value, atIndex index: Int) -> Bool {
        return cefObject.set_value_byindex(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }
    
    public func setValue(forKey key: String, access: AccessControl, attribute: PropertyAttribute) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value_byaccessor(cefObjectPtr, cefKeyPtr, access.toCEF(), attribute.toCEF()) != 0
    }
    
    public func getKeys() -> [String]? {
        let cefKeys = cef_string_list_alloc()
        defer { cef_string_list_free(cefKeys) }
        
        guard cefObject.get_keys(cefObjectPtr, cefKeys) != 0 else {
            return nil
        }
        
        return CEFStringListToSwiftArray(cefKeys)
    }
    
    public func setUserData(userData: CEFUserData?) -> Bool {
        let cefUserData = userData != nil ? userData!.toCEF() : nil
        return cefObject.set_user_data(cefObjectPtr, cefUserData) != 0
    }
    
    public func getUserData() -> CEFUserData? {
        let cefUserData = cefObject.get_user_data(cefObjectPtr)
        return CEFUserData.fromCEF(cefUserData)
    }
    
    public func getExternallyAllocatedMemory() -> Int {
        return Int(cefObject.get_externally_allocated_memory(cefObjectPtr))
    }
    
    public func adjustExternallyAllocatedMemory(change: Int) -> Int {
        return Int(cefObject.adjust_externally_allocated_memory(cefObjectPtr, Int32(change)))
    }
    
    // array methods

    public func getArrayLength() -> Int {
        return Int(cefObject.get_array_length(cefObjectPtr))
    }
    
    // function methods
    
    public func getFunctionName() -> String {
        let cefStrPtr = cefObject.get_function_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getFunctionHandler() -> CEFV8Handler? {
        let cefHandler = cefObject.get_function_handler(cefObjectPtr)
        return cefHandler.toSwift()
    }
    
    public func executeFunction(object: CEFV8Value, arguments: [CEFV8Value]) -> CEFV8Value? {
        let cefArgs = UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>.alloc(arguments.count)
        defer { cefArgs.dealloc(arguments.count) }
        
        for i in 0..<arguments.count {
            let cefArg = arguments[i].toCEF()
            cefArgs.advancedBy(i).initialize(cefArg)
        }
        
        let cefValue = cefObject.execute_function(cefObjectPtr, object.toCEF(), arguments.count, cefArgs)
        return CEFV8Value.fromCEF(cefValue)
    }
    
    public func executeFunctionWithContext(context: CEFV8Context, object: CEFV8Value, arguments: [CEFV8Value]) -> CEFV8Value? {
        let cefArgs = UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>.alloc(arguments.count)
        defer { cefArgs.dealloc(arguments.count) }
        
        for i in 0..<arguments.count {
            let cefArg = arguments[i].toCEF()
            cefArgs.advancedBy(i).initialize(cefArg)
        }
        
        let cefValue = cefObject.execute_function_with_context(cefObjectPtr,
                                                               context.toCEF(),
                                                               object.toCEF(),
                                                               arguments.count,
                                                               cefArgs)
        return CEFV8Value.fromCEF(cefValue)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFV8Value? {
        return CEFV8Value(ptr: ptr)
    }

}