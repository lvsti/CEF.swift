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

/// Class representing a dictionary value. Can be used on any process and thread.
public class CEFDictionaryValue: CEFProxy<cef_dictionary_value_t> {

    /// Creates a new object that is not owned by any other object.
    public init?() {
        super.init(ptr: cef_dictionary_value_create())
    }
    
    /// Returns true if this object is valid. This object may become invalid if
    /// the underlying data is owned by another object (e.g. list or dictionary)
    /// and that other object is then modified or destroyed. Do not call any other
    /// methods if this method returns false.
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if this object is currently owned by another object.
    public func isOwned() -> Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data. If true modifications to this object will also affect |that| object
    /// and vice-versa.
    public func isSame(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    public func isEqual(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a writable copy of this object. If |exclude_empty_children| is true
    /// any empty dictionaries or lists will be excluded from the copy.
    public func copy(excludesEmptyChildren: Bool) -> CEFDictionaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr, excludesEmptyChildren ? 1 : 0)
        return CEFDictionaryValue.fromCEF(copiedObj)
    }

    /// Returns the number of values.
    public func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }

    /// Removes all values. Returns true on success.
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    /// Returns true if the current dictionary has a value for the given key.
    public func hasKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.has_key(cefObjectPtr, cefKeyPtr) != 0
    }
    
    /// Reads all keys for this dictionary into the specified vector.
    public func getKeys() -> [String] {
        let cefKeys = cef_string_list_alloc()
        defer { cef_string_list_free(cefKeys) }

        if cefObject.get_keys(cefObjectPtr, cefKeys) != 0 {
            return CEFStringListToSwiftArray(cefKeys)
        }
        return []
    }
    
    /// Removes the value at the specified key. Returns true is the value was
    /// removed successfully.
    public func remove(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.remove(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns the value type for the specified key.
    public func getType(key: String) -> CEFValueType {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefType = cefObject.get_type(cefObjectPtr, cefKeyPtr)
        return CEFValueType.fromCEF(cefType)
    }

    /// Returns the value at the specified key. For simple types the returned
    /// value will copy existing data and modifications to the value will not
    /// modify this object. For complex types (binary, dictionary and list) the
    /// returned value will reference existing data and modifications to the value
    /// will modify this object.
    public func getValue(key: String) -> CEFValue {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefValue = cefObject.get_value(cefObjectPtr, cefKeyPtr)
        return CEFValue.fromCEF(cefValue)!
    }

    /// Returns the value at the specified key as type bool.
    public func getBool(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_bool(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns the value at the specified key as type int.
    public func getInt(key: String) -> Int {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return Int(cefObject.get_int(cefObjectPtr, cefKeyPtr))
    }

    /// Returns the value at the specified key as type double.
    public func getDouble(key: String) -> Double {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_double(cefObjectPtr, cefKeyPtr)
    }
    
    /// Returns the value at the specified key as type string.
    public func getString(key: String) -> String? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefStrPtr = cefObject.get_string(cefObjectPtr, cefKeyPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }

        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }

    /// Returns the value at the specified key as type binary. The returned
    /// value will reference existing data.
    public func getBinary(key: String) -> CEFBinaryValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefBinary = cefObject.get_binary(cefObjectPtr, cefKeyPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the value at the specified key as type dictionary. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    public func getDictionary(key: String) -> CEFDictionaryValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefDict = cefObject.get_dictionary(cefObjectPtr, cefKeyPtr)
        return CEFDictionaryValue.fromCEF(cefDict)
    }

    /// Returns the value at the specified key as type list. The returned value
    /// will reference existing data and modifications to the value will modify
    /// this object.
    public func getList(key: String) -> CEFListValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefList = cefObject.get_list(cefObjectPtr, cefKeyPtr)
        return CEFListValue.fromCEF(cefList)
    }

    /// Sets the value at the specified key. Returns true if the value was set
    /// successfully. If |value| represents simple data then the underlying data
    /// will be copied and modifications to |value| will not modify this object. If
    /// |value| represents complex data (binary, dictionary or list) then the
    /// underlying data will be referenced and modifications to |value| will modify
    /// this object.
    public func setValue(key: String, value: CEFValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    /// Sets the value at the specified key as type null. Returns true if the
    /// value was set successfully.
    public func setNull(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_null(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Sets the value at the specified key as type bool. Returns true if the
    /// value was set successfully.
    public func setBool(key: String, value: Bool) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_bool(cefObjectPtr, cefKeyPtr, value ? 1 : 0) != 0
    }

    /// Sets the value at the specified key as type int. Returns true if the
    /// value was set successfully.
    public func setInt(key: String, value: Int) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(value)) != 0
    }

    /// Sets the value at the specified key as type double. Returns true if the
    /// value was set successfully.
    public func setDouble(key: String, value: Double) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_double(cefObjectPtr, cefKeyPtr, value) != 0
    }

    /// Sets the value at the specified key as type string. Returns true if the
    /// value was set successfully.
    public func setString(key: String, string: String?) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefStrPtr = string != nil ? CEFStringPtrCreateFromSwiftString(string!) : nil
        defer {
            CEFStringPtrRelease(cefKeyPtr)
            CEFStringPtrRelease(cefStrPtr)
        }
        return cefObject.set_string(cefObjectPtr, cefKeyPtr, cefStrPtr) != 0
    }

    /// Sets the value at the specified key as type binary. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setBinary(key: String, value: CEFBinaryValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_binary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }
    
    /// Sets the value at the specified key as type dict. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setDictionary(key: String, value: CEFDictionaryValue) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_dictionary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    /// Sets the value at the specified key as type list. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
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

