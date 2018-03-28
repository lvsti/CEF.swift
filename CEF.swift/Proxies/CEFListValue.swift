//
//  CEFListValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFListValue {

    /// Creates a new object that is not owned by any other object.
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_list_value_create())
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
    public func isSame(as other: CEFListValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    /// CEF name: `IsEqual`
    public func isEqual(to other: CEFListValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a writable copy of this object.
    /// CEF name: `Copy`
    public func copy() -> CEFListValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFListValue.fromCEF(copiedObj)
    }

    /// The number of values.
    /// CEF name: `GetSize`, `SetSize`
    public var size: Int {
        get { return cefObject.get_size(cefObjectPtr) }
        set { _ = cefObject.set_size(cefObjectPtr, newValue) }
    }

    /// Sets the number of values. If the number of values is expanded all
    /// new value slots will default to type null. Returns true on success.
    /// CEF name: `SetSize`
    @available(*, deprecated: 1.0, message: "use the `size` property")
    @discardableResult
    public func setSize(_ size: Int) -> Bool {
        return cefObject.set_size(cefObjectPtr, size) != 0
    }

    /// Removes all values. Returns true on success.
    /// CEF name: `Clear`
    @discardableResult
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    /// Removes the value at the specified index.
    /// CEF name: `Remove`
    @discardableResult
    public func remove(at index: Int) -> Bool {
        return cefObject.remove(cefObjectPtr, size_t(index)) != 0
    }

    /// Returns the value type at the specified index.
    /// CEF name: `GetType`
    public func type(at index: Int) -> CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr, size_t(index))
        return CEFValueType.fromCEF(cefType)
    }

    /// Returns the value at the specified index. For simple types the returned
    /// value will copy existing data and modifications to the value will not
    /// modify this object. For complex types (binary, dictionary and list) the
    /// returned value will reference existing data and modifications to the value
    /// will modify this object.
    /// CEF name: `GetValue`
    public func value(at index: Int) -> CEFValue? {
        let cefValue = cefObject.get_value(cefObjectPtr, size_t(index))
        return CEFValue.fromCEF(cefValue)
    }

    /// Returns the value at the specified index as type bool.
    /// CEF name: `GetBool`
    public func bool(at index: Int) -> Bool {
        return cefObject.get_bool(cefObjectPtr, size_t(index)) != 0
    }

    /// Returns the value at the specified index as type int.
    /// CEF name: `GetInt`
    public func int(at index: Int) -> Int {
        return Int(cefObject.get_int(cefObjectPtr, size_t(index)))
    }

    /// Returns the value at the specified index as type int.
    public func int32(at index: Int) -> Int32 {
        return Int32(cefObject.get_int(cefObjectPtr, size_t(index)))
    }

    /// Returns the value at the specified index as type Int64.
    /// CEF name: `GetInt`
    public func int64(at index: Int) -> Int64 {
        let high = Int32(cefObject.get_int(cefObjectPtr, size_t(index)))
        let low = Int32(cefObject.get_int(cefObjectPtr, size_t(index + 1)))
        return (Int64(high) << 32) | Int64(UInt32(bitPattern:low))
    }

    /// Returns the value at the specified index as type double.
    /// CEF name: `GetDouble`
    public func double(at index: Int) -> Double {
        return cefObject.get_double(cefObjectPtr, size_t(index))
    }
    
    /// Returns the value at the specified index as type string.
    /// CEF name: `GetString`
    public func string(at index: Int) -> String? {
        let cefStrPtr = cefObject.get_string(cefObjectPtr, size_t(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns the value at the specified index as type binary. The returned
    /// value will reference existing data.
    /// CEF name: `GetBinary`
    public func binary(at index: Int) -> CEFBinaryValue? {
        let cefBinary = cefObject.get_binary(cefObjectPtr, size_t(index))
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the value at the specified index as type dictionary. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    /// CEF name: `GetDictionary`
    public func dictionary(at index: Int) -> CEFDictionaryValue? {
        let cefDict = cefObject.get_dictionary(cefObjectPtr, size_t(index))
        return CEFDictionaryValue.fromCEF(cefDict)
    }

    /// Returns the value at the specified index as type list. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    /// CEF name: `GetList`
    public func list(at index: Int) -> CEFListValue? {
        let cefList = cefObject.get_list(cefObjectPtr, size_t(index))
        return CEFListValue.fromCEF(cefList)
    }

    // Returns the value at the specified index as type [String].
    // If the element in that index is array, it must only contaisn string.
    public func stringArray(at index: Int) -> [String]? {
        guard let array = list(at: index) else {
            return nil
        }

        var stringArray = [String]()
        var i = 0
        while i < array.size {
            stringArray.append(array.string(at: i)!)
            i += 1
        }

        return stringArray
    }

    /// Sets the value at the specified index. Returns true if the value was set
    /// successfully. If |value| represents simple data then the underlying data
    /// will be copied and modifications to |value| will not modify this object. If
    /// |value| represents complex data (binary, dictionary or list) then the
    /// underlying data will be referenced and modifications to |value| will modify
    /// this object.
    /// CEF name: `SetValue`
    @discardableResult
    public func set(_ value: CEFValue, at index: Int) -> Bool {
        return cefObject.set_value(cefObjectPtr, size_t(index), value.toCEF()) != 0
    }

    /// Sets the value at the specified index as type null. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetNull`
    @discardableResult
    public func setNull(at index: Int) -> Bool {
        return cefObject.set_null(cefObjectPtr, size_t(index)) != 0
    }

    /// Sets the value at the specified index as type bool. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetBool`
    @discardableResult
    public func set(_ value: Bool, at index: Int) -> Bool {
        return cefObject.set_bool(cefObjectPtr, size_t(index), value ? 1 : 0) != 0
    }

    /// Sets the value at the specified index as type int. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetInt`
    @discardableResult
    public func set(_ value: Int, at index: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, size_t(index), Int32(value)) != 0
    }

    /// Sets the value at the specified index as type int. Returns true if the
    /// value was set successfully.
    @discardableResult
    public func set(_ value: Int32, at index: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, size_t(index), value) != 0
    }

    /// Sets the value at the specified index as type int. Returns true if the
    /// value was set successfully.
    /// This will take up two index (index, index+1) to store the Int64
    @discardableResult
    public func set(_ value: Int64, at index: Int) -> Bool {
        let high = Int32(truncatingIfNeeded: value >> 32)
        let low = Int32(truncatingIfNeeded: (value & 0xFFFFFFFF))

        if cefObject.set_int(cefObjectPtr, size_t(index), high) != 0 {
            return cefObject.set_int(cefObjectPtr, size_t(index + 1), low) != 0
        }

        return false
    }

    /// Sets the value at the specified index as type double. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetDouble`
    @discardableResult
    public func set(_ value: Double, at index: Int) -> Bool {
        return cefObject.set_double(cefObjectPtr, size_t(index), value) != 0
    }

    /// Sets the value at the specified index as type string. Returns true if the
    /// value was set successfully.
    /// CEF name: `SetString`
    @discardableResult
    public func set(_ string: String, at index: Int) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_string(cefObjectPtr, size_t(index), cefStrPtr) != 0
    }

    /// Sets the value at the specified index as type binary. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    /// CEF name: `SetBinary`
    @discardableResult
    public func set(_ value: CEFBinaryValue, at index: Int) -> Bool {
        return cefObject.set_binary(cefObjectPtr, size_t(index), value.toCEF()) != 0
    }
    
    /// Sets the value at the specified index as type dict. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    /// CEF name: `SetDictionary`
    @discardableResult
    public func set(_ value: CEFDictionaryValue, at index: Int) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, size_t(index), value.toCEF()) != 0
    }

    /// Sets the value at the specified index as type list. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    /// CEF name: `SetList`
    @discardableResult
    public func set(_ value: CEFListValue, at index: Int) -> Bool {
        return cefObject.set_list(cefObjectPtr, size_t(index), value.toCEF()) != 0
    }

}

