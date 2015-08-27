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

/// Class representing a list value. Can be used on any process and thread.
public class CEFListValue: CEFProxy<cef_list_value_t> {

    /// Creates a new object that is not owned by any other object.
    public init?() {
        super.init(ptr: cef_list_value_create())
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
    public func isSame(other: CEFListValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    public func isEqual(other: CEFListValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a writable copy of this object.
    public func copy() -> CEFListValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFListValue.fromCEF(copiedObj)
    }

    /// Sets the number of values. If the number of values is expanded all
    /// new value slots will default to type null. Returns true on success.
    public func setSize(size: size_t) {
        cefObject.set_size(cefObjectPtr, size)
    }

    /// Returns the number of values.
    public func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }

    /// Removes all values. Returns true on success.
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    /// Removes the value at the specified index.
    public func remove(index: Int) -> Bool {
        return cefObject.remove(cefObjectPtr, Int32(index)) != 0
    }

    /// Returns the value type at the specified index.
    public func getType(index: Int) -> CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr, Int32(index))
        return CEFValueType.fromCEF(cefType)
    }

    /// Returns the value at the specified index. For simple types the returned
    /// value will copy existing data and modifications to the value will not
    /// modify this object. For complex types (binary, dictionary and list) the
    /// returned value will reference existing data and modifications to the value
    /// will modify this object.
    public func getValue(index: Int) -> CEFValue {
        let cefValue = cefObject.get_value(cefObjectPtr, Int32(index))
        return CEFValue.fromCEF(cefValue)!
    }

    /// Returns the value at the specified index as type bool.
    public func getBool(index: Int) -> Bool {
        return cefObject.get_bool(cefObjectPtr, Int32(index)) != 0
    }

    /// Returns the value at the specified index as type int.
    public func getInt(index: Int) -> Int {
        return Int(cefObject.get_int(cefObjectPtr, Int32(index)))
    }

    /// Returns the value at the specified index as type double.
    public func getDouble(index: Int) -> Double {
        return cefObject.get_double(cefObjectPtr, Int32(index))
    }
    
    /// Returns the value at the specified index as type string.
    public func getString(index: Int) -> String? {
        let cefStrPtr = cefObject.get_string(cefObjectPtr, Int32(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }

    /// Returns the value at the specified index as type binary. The returned
    /// value will reference existing data.
    public func getBinary(index: Int) -> CEFBinaryValue? {
        let cefBinary = cefObject.get_binary(cefObjectPtr, Int32(index))
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the value at the specified index as type dictionary. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    public func getDictionary(index: Int) -> CEFDictionaryValue? {
        let cefDict = cefObject.get_dictionary(cefObjectPtr, Int32(index))
        return CEFDictionaryValue.fromCEF(cefDict)
    }

    /// Returns the value at the specified index as type list. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    public func getList(index: Int) -> CEFListValue? {
        let cefList = cefObject.get_list(cefObjectPtr, Int32(index))
        return CEFListValue.fromCEF(cefList)
    }

    /// Sets the value at the specified index. Returns true if the value was set
    /// successfully. If |value| represents simple data then the underlying data
    /// will be copied and modifications to |value| will not modify this object. If
    /// |value| represents complex data (binary, dictionary or list) then the
    /// underlying data will be referenced and modifications to |value| will modify
    /// this object.
    public func setValue(index: Int, value: CEFValue) -> Bool {
        return cefObject.set_value(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    /// Sets the value at the specified index as type null. Returns true if the
    /// value was set successfully.
    public func setNull(index: Int) -> Bool {
        return cefObject.set_null(cefObjectPtr, Int32(index)) != 0
    }

    /// Sets the value at the specified index as type bool. Returns true if the
    /// value was set successfully.
    public func setBool(index: Int, value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, Int32(index), value ? 1 : 0) != 0
    }

    /// Sets the value at the specified index as type int. Returns true if the
    /// value was set successfully.
    public func setInt(index: Int, value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(index), Int32(value)) != 0
    }

    /// Sets the value at the specified index as type double. Returns true if the
    /// value was set successfully.
    public func setDouble(index: Int, value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, Int32(index), value) != 0
    }

    /// Sets the value at the specified index as type string. Returns true if the
    /// value was set successfully.
    public func setString(index: Int, string: String?) -> Bool {
        let cefStrPtr = string != nil ? CEFStringPtrCreateFromSwiftString(string!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_string(cefObjectPtr, Int32(index), cefStrPtr) != 0
    }

    /// Sets the value at the specified index as type binary. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setBinary(index: Int, value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }
    
    /// Sets the value at the specified index as type dict. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setDictionary(index: Int, value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    /// Sets the value at the specified index as type list. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setList(index: Int, value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFListValue? {
        return CEFListValue(ptr: ptr)
    }
}

