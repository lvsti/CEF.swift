//
//  CEFListValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_list_value_t: CEFObject {
}

class CEFListValue: CEFProxyBase<cef_list_value_t> {

    init?() {
        super.init(ptr: cef_list_value_create())
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
    
    func isSame(other: CEFListValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    func isEqual(other: CEFListValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    func copy() -> CEFListValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFListValue.fromCEF(copiedObj)
    }

    func setSize(size: size_t) {
        cefObject.set_size(cefObjectPtr, size)
    }

    func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }

    func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    func remove(index: Int) -> Bool {
        return cefObject.remove(cefObjectPtr, Int32(index)) != 0
    }

    func getType(index: Int) -> CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr, Int32(index))
        return CEFValueType(rawValue: Int(cefType.rawValue))!
    }

    func getValue(index: Int) -> CEFValue {
        let cefValue = cefObject.get_value(cefObjectPtr, Int32(index))
        return CEFValue.fromCEF(cefValue)!
    }

    func getBool(index: Int) -> Bool {
        return cefObject.get_bool(cefObjectPtr, Int32(index)) != 0
    }

    func getInt(index: Int) -> Int {
        return Int(cefObject.get_int(cefObjectPtr, Int32(index)))
    }

    func getDouble(index: Int) -> Double {
        return cefObject.get_double(cefObjectPtr, Int32(index))
    }
    
    func getString(index: Int) -> String {
        let cefStrPtr = cefObject.get_string(cefObjectPtr, Int32(index))
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        cef_string_userfree_utf16_free(cefStrPtr)
        
        return retval
    }

    func getBinary(index: Int) -> CEFBinaryValue {
        let cefBinary = cefObject.get_binary(cefObjectPtr, Int32(index))
        return CEFBinaryValue.fromCEF(cefBinary)!
    }

    func getDictionary(index: Int) -> CEFDictionaryValue {
        let cefDict = cefObject.get_dictionary(cefObjectPtr, Int32(index))
        return CEFDictionaryValue.fromCEF(cefDict)!
    }

    func getList(index: Int) -> CEFListValue {
        let cefList = cefObject.get_list(cefObjectPtr, Int32(index))
        return CEFListValue.fromCEF(cefList)!
    }

    func setValue(index: Int, value: CEFValue) -> Bool {
        return cefObject.set_value(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    func setNull(index: Int) -> Bool {
        return cefObject.set_null(cefObjectPtr, Int32(index)) != 0
    }

    func setBool(index: Int, value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, Int32(index), value ? 1 : 0) != 0
    }

    func setInt(index: Int, value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(index), Int32(value)) != 0
    }

    func setDouble(index: Int, value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, Int32(index), value) != 0
    }

    func setString(index: Int, string: String) -> Bool {
        let cefStrPtr = CEFStringPtrFromSwiftString(string)
        let retval = cefObject.set_string(cefObjectPtr, Int32(index), cefStrPtr) != 0
        cef_string_userfree_utf16_free(cefStrPtr)
        return retval
    }

    func setBinary(index: Int, value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }
    
    func setDictionary(index: Int, value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    func setList(index: Int, value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

}

