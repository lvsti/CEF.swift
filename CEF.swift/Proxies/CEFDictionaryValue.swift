//
//  CEFDictionaryValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDictionaryValue {

    /// Creates a new object that is not owned by any other object.
    public convenience init?() {
        self.init(ptr: cef_dictionary_value_create())
    }
    
    /// Returns true if this object is valid. This object may become invalid if
    /// the underlying data is owned by another object (e.g. list or dictionary)
    /// and that other object is then modified or destroyed. Do not call any other
    /// methods if this method returns false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if this object is currently owned by another object.
    public var isOwned: Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data. If true modifications to this object will also affect |that| object
    /// and vice-versa.
    public func isSameAs(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    public func isEqualTo(other: CEFDictionaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a writable copy of this object. If |exclude_empty_children| is true
    /// any empty dictionaries or lists will be excluded from the copy.
    public func copy(excludesEmptyChildren: Bool) -> CEFDictionaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr, excludesEmptyChildren ? 1 : 0)
        return CEFDictionaryValue.fromCEF(copiedObj)
    }

    /// Returns the number of values.
    public var count: Int {
        return Int(cefObject.get_size(cefObjectPtr))
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
    public var allKeys: [String] {
        let cefKeys = cef_string_list_alloc()
        defer { cef_string_list_free(cefKeys) }

        if cefObject.get_keys(cefObjectPtr, cefKeys) != 0 {
            return CEFStringListToSwiftArray(cefKeys)
        }
        return []
    }
    
    /// Removes the value at the specified key. Returns true is the value was
    /// removed successfully.
    public func removeValueForKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.remove(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns the value type for the specified key.
    public func typeForKey(key: String) -> CEFValueType {
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
    public func valueForKey(key: String) -> CEFValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefValue = cefObject.get_value(cefObjectPtr, cefKeyPtr)
        return CEFValue.fromCEF(cefValue)
    }

    /// Returns the value at the specified key as type bool.
    public func boolForKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_bool(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns the value at the specified key as type int.
    public func intForKey(key: String) -> Int {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return Int(cefObject.get_int(cefObjectPtr, cefKeyPtr))
    }

    /// Returns the value at the specified key as type double.
    public func doubleForKey(key: String) -> Double {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_double(cefObjectPtr, cefKeyPtr)
    }
    
    /// Returns the value at the specified key as type string.
    public func stringForKey(key: String) -> String? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefStrPtr = cefObject.get_string(cefObjectPtr, cefKeyPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }

        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }

    /// Returns the value at the specified key as type binary. The returned
    /// value will reference existing data.
    public func binaryForKey(key: String) -> CEFBinaryValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefBinary = cefObject.get_binary(cefObjectPtr, cefKeyPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the value at the specified key as type dictionary. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    public func dictionaryForKey(key: String) -> CEFDictionaryValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefDict = cefObject.get_dictionary(cefObjectPtr, cefKeyPtr)
        return CEFDictionaryValue.fromCEF(cefDict)
    }

    /// Returns the value at the specified key as type list. The returned value
    /// will reference existing data and modifications to the value will modify
    /// this object.
    public func listForKey(key: String) -> CEFListValue? {
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
    public func setValue(value: CEFValue, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    /// Sets the value at the specified key as type null. Returns true if the
    /// value was set successfully.
    public func setNullForKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_null(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Sets the value at the specified key as type bool. Returns true if the
    /// value was set successfully.
    public func setBool(value: Bool, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_bool(cefObjectPtr, cefKeyPtr, value ? 1 : 0) != 0
    }

    /// Sets the value at the specified key as type int. Returns true if the
    /// value was set successfully.
    public func setInt(value: Int, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(value)) != 0
    }

    /// Sets the value at the specified key as type double. Returns true if the
    /// value was set successfully.
    public func setDouble(value: Double, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_double(cefObjectPtr, cefKeyPtr, value) != 0
    }

    /// Sets the value at the specified key as type string. Returns true if the
    /// value was set successfully.
    public func setString(string: String, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
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
    public func setBinary(value: CEFBinaryValue, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_binary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }
    
    /// Sets the value at the specified key as type dict. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setDictionary(value: CEFDictionaryValue, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_dictionary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    /// Sets the value at the specified key as type list. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setList(value: CEFListValue, forKey key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_list(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

}

