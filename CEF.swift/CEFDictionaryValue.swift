//
//  CEFDictionaryValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_dictionary_value_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

class CEFDictionaryValue: CEFProxyBase<cef_dictionary_value_t> {

    init?() {
        super.init(ptr: cef_dictionary_value_create())
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
    
    func isSame(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    func isEqual(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    func copy(excludesEmptyChildren: Bool) -> CEFDictionaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr, excludesEmptyChildren ? 1 : 0)
        return CEFDictionaryValue.fromCEF(copiedObj)
    }

    func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }

    func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    func hasKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.has_key(cefObjectPtr, cefKeyPtr) != 0
    }
    
    func getKeys() -> [String] {
        let cefKeys = cef_string_list_alloc()
        defer { cef_string_list_free(cefKeys) }

        if cefObject.get_keys(cefObjectPtr, cefKeys) != 0 {
            return CEFStringListToSwiftArray(cefKeys)
        }
        return []
    }
    
    func remove(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.remove(cefObjectPtr, cefKeyPtr) != 0
    }

    func getType(key: String) -> CEFValueType {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefType = cefObject.get_type(cefObjectPtr, cefKeyPtr)
        return CEFValueType(rawValue: Int(cefType.rawValue))!
    }

    func getValue(key: String) -> CEFValue {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefValue = cefObject.get_value(cefObjectPtr, cefKeyPtr)
        return CEFValue.fromCEF(cefValue)!
    }

    func getBool(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.get_bool(cefObjectPtr, cefKeyPtr) != 0
    }

    func getInt(key: String) -> Int {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return Int(cefObject.get_int(cefObjectPtr, cefKeyPtr))
    }

    func getDouble(key: String) -> Double {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.get_double(cefObjectPtr, cefKeyPtr)
    }
    
    func getString(key: String) -> String {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefStrPtr = cefObject.get_string(cefObjectPtr, cefKeyPtr)
        defer { cef_string_userfree_utf16_free(cefStrPtr) }

        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    func getBinary(key: String) -> CEFBinaryValue {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefBinary = cefObject.get_binary(cefObjectPtr, cefKeyPtr)
        return CEFBinaryValue.fromCEF(cefBinary)!
    }

    func getDictionary(key: String) -> CEFDictionaryValue {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefDict = cefObject.get_dictionary(cefObjectPtr, cefKeyPtr)
        return CEFDictionaryValue.fromCEF(cefDict)!
    }

    func getList(key: String) -> CEFListValue {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefList = cefObject.get_list(cefObjectPtr, cefKeyPtr)
        return CEFListValue.fromCEF(cefList)!
    }

    func setValue(key: String, value: CEFValue) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_value(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    func setNull(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_null(cefObjectPtr, cefKeyPtr) != 0
    }

    func setBool(key: String, value: Bool) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_bool(cefObjectPtr, cefKeyPtr, value ? 1 : 0) != 0
    }

    func setInt(key: String, value: Int) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(value)) != 0
    }

    func setDouble(key: String, value: Double) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_double(cefObjectPtr, cefKeyPtr, value) != 0
    }

    func setString(key: String, string: String) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        let cefStrPtr = CEFStringPtrFromSwiftString(string)
        let retval = cefObject.set_string(cefObjectPtr, cefKeyPtr, cefStrPtr) != 0
        cef_string_userfree_utf16_free(cefStrPtr)
        return retval
    }

    func setBinary(key: String, value: CEFBinaryValue) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_binary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }
    
    func setDictionary(key: String, value: CEFDictionaryValue) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_dictionary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    func setList(key: String, value: CEFListValue) -> Bool {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        defer { cef_string_userfree_utf16_free(cefKeyPtr) }
        return cefObject.set_list(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

}

