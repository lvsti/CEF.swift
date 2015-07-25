//
//  CEFValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_value_t: CEFObject {
}

public enum CEFValueType: Int {
    case Invalid = 0
    case Null
    case Bool
    case Int
    case Double
    case String
    case Binary
    case Dictionary
    case List
}


public class CEFValue: CEFProxyBase<cef_value_t> {

    public init?() {
        super.init(ptr: cef_value_create())
    }
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func isOwned() -> Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    public func isSame(other: CEFValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    public func isEqual(other: CEFValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    public func copy() -> CEFValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFValue.fromCEF(copiedObj)
    }

    public func getType() -> CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFValueType(rawValue: Int(cefType.rawValue))!
    }

    public func getBool() -> Bool {
        return cefObject.get_bool(cefObjectPtr) != 0
    }

    public func getInt() -> Int {
        return Int(cefObject.get_int(cefObjectPtr))
    }

    public func getDouble() -> Double {
        return cefObject.get_double(cefObjectPtr)
    }
    
    public func getString() -> String {
        let cefStrPtr = cefObject.get_string(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        CEFStringPtrRelease(cefStrPtr)
        
        return retval
    }

    public func getBinary() -> CEFBinaryValue {
        let cefBinary = cefObject.get_binary(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)!
    }

    public func getDictionary() -> CEFDictionaryValue {
        let cefDict = cefObject.get_dictionary(cefObjectPtr)
        return CEFDictionaryValue.fromCEF(cefDict)!
    }

    public func getList() -> CEFListValue {
        let cefList = cefObject.get_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)!
    }

    public func setNull() -> Bool {
        return cefObject.set_null(cefObjectPtr) != 0
    }

    public func setBool(value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, value ? 1 : 0) != 0
    }

    public func setInt(value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(value)) != 0
    }

    public func setDouble(value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, value) != 0
    }

    public func setString(string: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        let retval = cefObject.set_string(cefObjectPtr, cefStrPtr) != 0
        CEFStringPtrRelease(cefStrPtr)
        return retval
    }

    public func setBinary(value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, value.toCEF()) != 0
    }
    
    public func setDictionary(value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, value.toCEF()) != 0
    }

    public func setList(value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, value.toCEF()) != 0
    }

}
