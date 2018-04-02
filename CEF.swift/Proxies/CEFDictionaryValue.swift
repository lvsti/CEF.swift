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
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_dictionary_value_create())
    }

    public convenience init?(_ value: [String: Any]) {
        self.init(ptr: cef_dictionary_value_create())

        for (key, el) in value {
            if el is String {
                set(el as! String, for: key)
            } else if el is Int64 {
                set(el as! Int64, for: key)
            } else if el is UInt64 {
                set(el as! UInt64, for: key)
            } else if el is Int32 {
                set(el as! Int32, for: key)
            } else if el is UInt32 {
                set(el as! UInt32, for: key)
            } else if el is Int {
                set(el as! Int, for: key)
            } else if el is UInt {
                set(el as! UInt, for: key)
            } else if el is Double {
                set(el as! Double, for: key)
            } else if el is Bool {
                set(el as! Bool, for: key)
            } else if el is NSNull {
                setNull(for: key)
            } else if el is [Any] {
                if let l = CEFListValue(el as! [Any]) {
                    set(l, for: key)
                }
            } else if el is [String: Any] {
                if let d = CEFDictionaryValue(el as! [String: Any]) {
                    set(d, for: key)
                }
            }
        }
    }
    
    /// Returns true if this object is valid. This object may become invalid if
    /// the underlying data is owned by another object (e.g. list or dictionary)
    /// and that other object is then modified or destroyed. Do not call any other
    /// methods if this method returns false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if this object is currently owned by another object.
    /// CEF name: `IsOwned`
    public var isOwned: Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data. If true modifications to this object will also affect |that| object
    /// and vice-versa.
    /// CEF name: `IsSame`
    public func isSame(as other: CEFDictionaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    /// CEF name: `IsEqual`
    public func isEqual(to other: CEFDictionaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a writable copy of this object. If |exclude_empty_children| is true
    /// any empty dictionaries or lists will be excluded from the copy.
    /// CEF name: `Copy`
    public func copy(excludesEmptyChildren: Bool) -> CEFDictionaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr, excludesEmptyChildren ? 1 : 0)
        return CEFDictionaryValue.fromCEF(copiedObj)
    }

    /// Returns the number of values.
    /// CEF name: `GetSize`
    public var count: Int {
        return Int(cefObject.get_size(cefObjectPtr))
    }

    /// Removes all values. Returns true on success.
    /// CEF name: `Clear`
    @discardableResult
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    /// Returns true if the current dictionary has a value for the given key.
    /// CEF name: `HasKey`
    public func hasKey(_ key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.has_key(cefObjectPtr, cefKeyPtr) != 0
    }
    
    /// Reads all keys for this dictionary into the specified vector.
    /// CEF name: `GetKeys`
    public var allKeys: [String] {
        let cefKeys = cef_string_list_alloc()!
        defer { cef_string_list_free(cefKeys) }

        if cefObject.get_keys(cefObjectPtr, cefKeys) != 0 {
            return CEFStringListToSwiftArray(cefKeys)
        }
        return []
    }
    
    /// Removes the value at the specified key. Returns true is the value was
    /// removed successfully.
    /// CEF name: `Remove`
    @discardableResult
    public func removeValue(for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.remove(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns the value type for the specified key.
    /// CEF name: `GetType`
    public func type(for key: String) -> CEFValueType {
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
    /// CEF name: `GetValue`
    public func value(for key: String) -> CEFValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefValue = cefObject.get_value(cefObjectPtr, cefKeyPtr)
        return CEFValue.fromCEF(cefValue)
    }

    /// Returns the value at the specified key as type bool.
    /// CEF name: `GetBool`
    public func bool(for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_bool(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns the value at the specified key as type int.
    /// CEF name: `GetInt`
    public func int(for key: String) -> Int {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return Int(cefObject.get_int(cefObjectPtr, cefKeyPtr))
    }

    public func uint(for key: String) -> UInt {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return UInt(bitPattern: Int(cefObject.get_int(cefObjectPtr, cefKeyPtr)))
    }

    public func int32(for key: String) -> Int32 {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_int(cefObjectPtr, cefKeyPtr)
    }

    public func uint32(for key: String) -> UInt32 {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return UInt32(bitPattern: cefObject.get_int(cefObjectPtr, cefKeyPtr))
    }

    public func int64(for key: String) -> Int64 {
        if let b = binary(for: key) {
            return b.int64
        }
        return 0
    }

    public func uint64(for key: String) -> UInt64 {
        if let b = binary(for: key) {
            return b.uint64
        }
        return 0
    }

    /// Returns the value at the specified key as type double.
    /// CEF name: `GetDouble`
    public func double(for key: String) -> Double {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.get_double(cefObjectPtr, cefKeyPtr)
    }
    
    /// Returns the value at the specified key as type string.
    /// CEF name: `GetString`
    public func string(for key: String) -> String? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefStrPtr = cefObject.get_string(cefObjectPtr, cefKeyPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }

        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns the value at the specified key as type binary. The returned
    /// value will reference existing data.
    /// CEF name: `GetBinary`
    public func binary(for key: String) -> CEFBinaryValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefBinary = cefObject.get_binary(cefObjectPtr, cefKeyPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the value at the specified key as type dictionary. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    /// CEF name: `GetDictionary`
    public func dictionary(for key: String) -> CEFDictionaryValue? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefDict = cefObject.get_dictionary(cefObjectPtr, cefKeyPtr)
        return CEFDictionaryValue.fromCEF(cefDict)
    }

    /// Returns the value at the specified key as type list. The returned value
    /// will reference existing data and modifications to the value will modify
    /// this object.
    /// CEF name: `GetList`
    public func list(for key: String) -> CEFListValue? {
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
    /// CEF name: `SetValue`
    @discardableResult
    public func set(_ value: CEFValue, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    /// Sets the value at the specified key as type null. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetNull`
    @discardableResult
    public func setNull(for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_null(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Sets the value at the specified key as type bool. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetBool`
    @discardableResult
    public func set(_ value: Bool, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_bool(cefObjectPtr, cefKeyPtr, value ? 1 : 0) != 0
    }

    /// Sets the value at the specified key as type int. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetInt`
    @discardableResult
    public func set(_ value: Int, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(value)) != 0
    }

    @discardableResult
    public func set(_ value: UInt, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(bitPattern: UInt32(value))) != 0
    }

    @discardableResult
    public func set(_ value: Int32, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, value) != 0
    }

    @discardableResult
    public func set(_ value: UInt32, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_int(cefObjectPtr, cefKeyPtr, Int32(bitPattern: value)) != 0
    }

    @discardableResult
    public func set(_ value: Int64, for key: String) -> Bool {
        if let b = CEFBinaryValue(value) {
            set(b, for: key)
        }
        return false
    }

    @discardableResult
    public func set(_ value: UInt64, for key: String) -> Bool {
        if let b = CEFBinaryValue(value) {
            set(b, for: key)
        }
        return false
    }

    /// Sets the value at the specified key as type double. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetDouble`
    @discardableResult
    public func set(_ value: Double, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_double(cefObjectPtr, cefKeyPtr, value) != 0
    }

    /// Sets the value at the specified key as type string. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetString`
    @discardableResult
    public func set(_ string: String, for key: String) -> Bool {
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
    /// CEF name: `SetBinary`
    @discardableResult
    public func set(_ value: CEFBinaryValue, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_binary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }
    
    /// Sets the value at the specified key as type dict. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    /// CEF name: `SetDictionary`
    @discardableResult
    public func set(_ value: CEFDictionaryValue, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_dictionary(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

    /// Sets the value at the specified key as type list. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    /// CEF name: `SetList`
    @discardableResult
    public func set(_ value: CEFListValue, for key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_list(cefObjectPtr, cefKeyPtr, value.toCEF()) != 0
    }

}

