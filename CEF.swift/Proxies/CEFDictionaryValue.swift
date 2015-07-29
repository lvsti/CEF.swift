//
//  CEFDictionaryValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_dictionary_value_t: CEFObject {
}

public class CEFDictionaryValue: CEFProxy<cef_dictionary_value_t> {

    public init?() {
        super.init(ptr: cef_dictionary_value_create())
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
    
    public func isSame(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    public func isEqual(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    public func copy(excludesEmptyChildren: Bool) -> CEFDictionaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr, excludesEmptyChildren ? 1 : 0)
        return CEFDictionaryValue.fromCEF(copiedObj)
    }

    public func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }

    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    public func hasKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.has_key(cefObjectPtr, cefKeyPtr) != 0
    }
    
    public func getKeys() -> [String] {
        let cefKeys = cef_string_list_alloc()
        defer { cef_string_list_free(cefKeys) }

        if cefObject.get_keys(cefObjectPtr, cefKeys) != 0 {
            return CEFStringListToSwiftArray(cefKeys)
        }
        return []
    }
    
    public func remove(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.remove(cefObjectPtr, cefKeyPtr) != 0
    }

    public func getType(key: String) -> CEFValueType {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefType = cefObject.get_type(cefObjectPtr, cefKeyPtr)
        return CEFValueType(rawValue: Int(cefType.rawValue))!
    }

    public func getValue(key: String) -> CEFValue {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefValue = cefObject.get_value(cefObjectPtr, cefKeyPtr)
        return CEFValue.fromCEF(cefValue)!
    }

    public func getBool(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_bool(cefObjectPtr, cefKeyPtr) != 0
    }

    public func getInt(key: String) -> Int {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return Int(cefObject.get_int(cefObjectPtr, cefKeyPtr))
    }

    public func getDouble(key: String) -> Double {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_double(cefObjectPtr, cefKeyPtr)
    }
    
    public func getString(key: String) -> String {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefStrPtr = cefObject.get_string(cefObjectPtr, cefKeyPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }

        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getBinary(key: String) -> CEFBinaryValue {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefBinary = cefObject.get_binary(cefObjectPtr, cefKeyPtr)
        return CEFBinaryValue.fromCEF(cefBinary)!
    }

    public func getDictionary(key: String) -> CEFDictionaryValue {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefDict = cefObject.get_dictionary(cefObjectPtr, cefKeyPtr)
        return CEFDictionaryValue.fromCEF(cefDict)!
    }

    public func getList(key: String) -> CEFListValue {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefList = cefObject.get_list(cefObjectPtr, cefKeyPtr)
        return CEFListValue.fromCEF(cefList)!
    }

    public func setValue(key: String, value: CEFValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    public func setNull(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_null(cefObjectPtr, cefKeyPtr) != 0
    }

    public func setBool(key: String, value: Bool) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_bool(cefObjectPtr, cefKeyPtr, value ? 1 : 0) != 0
    }

    public func setInt(key: String, value: Int) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(value)) != 0
    }

    public func setDouble(key: String, value: Double) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_double(cefObjectPtr, cefKeyPtr, value) != 0
    }

    public func setString(key: String, string: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        defer {
            CEFStringPtrRelease(cefKeyPtr)
            CEFStringPtrRelease(cefStrPtr)
        }
        return cefObject.set_string(cefObjectPtr, cefKeyPtr, cefStrPtr) != 0
    }

    public func setBinary(key: String, value: CEFBinaryValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_binary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }
    
    public func setDictionary(key: String, value: CEFDictionaryValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_dictionary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    public func setList(key: String, value: CEFListValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_list(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDictionaryValue? {
        return CEFDictionaryValue(ptr: ptr)
    }
}

