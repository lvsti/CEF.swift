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

enum CEFValueType: Int {
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


class CEFValue: CEFProxyBase<cef_value_t> {

    init?() {
        super.init(ptr: cef_value_create())
    }
    
    func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    func isOwned() -> Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    func isSame(other: CEFValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    func isEqual(other: CEFValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    func copy() -> CEFValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFValue.fromCEF(copiedObj)
    }

    func getType() -> CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFValueType(rawValue: Int(cefType.rawValue))!
    }

    func getBool() -> Bool {
        return cefObject.get_bool(cefObjectPtr) != 0
    }

    func getInt() -> Int {
        return Int(cefObject.get_int(cefObjectPtr))
    }

    func getDouble() -> Double {
        return cefObject.get_double(cefObjectPtr)
    }
    
    func getString() -> String {
        let cefStrPtr = cefObject.get_string(cefObjectPtr)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        
        return retval
    }

    func getBinary() -> CEFBinaryValue {
        let cefBinary = cefObject.get_binary(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)!
    }

    func getDictionary() -> CEFDictionaryValue {
        let cefDict = cefObject.get_dictionary(cefObjectPtr)
        return CEFDictionaryValue.fromCEF(cefDict)!
    }

    func getList() -> CEFListValue {
        let cefList = cefObject.get_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)!
    }

    func setNull() -> Bool {
        return cefObject.set_null(cefObjectPtr) != 0
    }

    func setBool(value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, value ? 1 : 0) != 0
    }

    func setInt(value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(value)) != 0
    }

    func setDouble(value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, value) != 0
    }

    func setString(string: String) -> Bool {
        let cefStrPtr = CEFStringPtrFromSwiftString(string)
        let retval = cefObject.set_string(cefObjectPtr, cefStrPtr) != 0
        cef_string_userfree_utf16_free(cefStrPtr)
        return retval
    }

    func setBinary(value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, value.toCEF()) != 0
    }
    
    func setDictionary(value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, value.toCEF()) != 0
    }

    func setList(value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, value.toCEF()) != 0
    }

}
