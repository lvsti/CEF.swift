//
//  ListValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_list_value_t: CEFObject {
}

/// Class representing a list value. Can be used on any process and thread.
public class ListValue: Proxy<cef_list_value_t> {

    /// Creates a new object that is not owned by any other object.
    public init?() {
        super.init(ptr: cef_list_value_create())
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
    public func isSameAs(other: ListValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    public func isEqualTo(other: ListValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a writable copy of this object.
    public func copy() -> ListValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return ListValue.fromCEF(copiedObj)
    }

    /// The number of values.
    public var size: Int {
        get { return cefObject.get_size(cefObjectPtr) }
        set { cefObject.set_size(cefObjectPtr, newValue) }
    }

    /// Sets the number of values. If the number of values is expanded all
    /// new value slots will default to type null. Returns true on success.
    @available(*, deprecated=1.0, message="use the `size` property")
    public func setSize(size: Int) -> Bool {
        return cefObject.set_size(cefObjectPtr, size) != 0
    }

    /// Removes all values. Returns true on success.
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    /// Removes the value at the specified index.
    public func removeValueAtIndex(index: Int) -> Bool {
        return cefObject.remove(cefObjectPtr, Int32(index)) != 0
    }

    /// Returns the value type at the specified index.
    public func typeAtIndex(index: Int) -> ValueType {
        let cefType = cefObject.get_type(cefObjectPtr, Int32(index))
        return ValueType.fromCEF(cefType)
    }

    /// Returns the value at the specified index. For simple types the returned
    /// value will copy existing data and modifications to the value will not
    /// modify this object. For complex types (binary, dictionary and list) the
    /// returned value will reference existing data and modifications to the value
    /// will modify this object.
    public func valueAtIndex(index: Int) -> Value? {
        let cefValue = cefObject.get_value(cefObjectPtr, Int32(index))
        return Value.fromCEF(cefValue)
    }

    /// Returns the value at the specified index as type bool.
    public func boolAtIndex(index: Int) -> Bool {
        return cefObject.get_bool(cefObjectPtr, Int32(index)) != 0
    }

    /// Returns the value at the specified index as type int.
    public func intAtIndex(index: Int) -> Int {
        return Int(cefObject.get_int(cefObjectPtr, Int32(index)))
    }

    /// Returns the value at the specified index as type double.
    public func doubleAtIndex(index: Int) -> Double {
        return cefObject.get_double(cefObjectPtr, Int32(index))
    }
    
    /// Returns the value at the specified index as type string.
    public func stringAtIndex(index: Int) -> String? {
        let cefStrPtr = cefObject.get_string(cefObjectPtr, Int32(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }

    /// Returns the value at the specified index as type binary. The returned
    /// value will reference existing data.
    public func binaryAtIndex(index: Int) -> BinaryValue? {
        let cefBinary = cefObject.get_binary(cefObjectPtr, Int32(index))
        return BinaryValue.fromCEF(cefBinary)
    }

    /// Returns the value at the specified index as type dictionary. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    public func dictionaryAtIndex(index: Int) -> DictionaryValue? {
        let cefDict = cefObject.get_dictionary(cefObjectPtr, Int32(index))
        return DictionaryValue.fromCEF(cefDict)
    }

    /// Returns the value at the specified index as type list. The returned
    /// value will reference existing data and modifications to the value will
    /// modify this object.
    public func listAtIndex(index: Int) -> ListValue? {
        let cefList = cefObject.get_list(cefObjectPtr, Int32(index))
        return ListValue.fromCEF(cefList)
    }

    /// Sets the value at the specified index. Returns true if the value was set
    /// successfully. If |value| represents simple data then the underlying data
    /// will be copied and modifications to |value| will not modify this object. If
    /// |value| represents complex data (binary, dictionary or list) then the
    /// underlying data will be referenced and modifications to |value| will modify
    /// this object.
    public func setValue(value: Value, atIndex index: Int) -> Bool {
        return cefObject.set_value(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    /// Sets the value at the specified index as type null. Returns true if the
    /// value was set successfully.
    public func setNullAtIndex(index: Int) -> Bool {
        return cefObject.set_null(cefObjectPtr, Int32(index)) != 0
    }

    /// Sets the value at the specified index as type bool. Returns true if the
    /// value was set successfully.
    public func setBool(value: Bool, atIndex index: Int) -> Bool {
        return cefObject.set_bool(cefObjectPtr, Int32(index), value ? 1 : 0) != 0
    }

    /// Sets the value at the specified index as type int. Returns true if the
    /// value was set successfully.
    public func setInt(value: Int, atIndex index: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(index), Int32(value)) != 0
    }

    /// Sets the value at the specified index as type double. Returns true if the
    /// value was set successfully.
    public func setDouble(value: Double, atIndex index: Int) -> Bool {
        return cefObject.set_double(cefObjectPtr, Int32(index), value) != 0
    }

    /// Sets the value at the specified index as type string. Returns true if the
    /// value was set successfully.
    public func setString(string: String, atIndex index: Int) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_string(cefObjectPtr, Int32(index), cefStrPtr) != 0
    }

    /// Sets the value at the specified index as type binary. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setBinary(value: BinaryValue, atIndex index: Int) -> Bool {
        return cefObject.set_binary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }
    
    /// Sets the value at the specified index as type dict. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setDictionary(value: DictionaryValue, atIndex index: Int) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    /// Sets the value at the specified index as type list. Returns true if the
    /// value was set successfully. If |value| is currently owned by another object
    /// then the value will be copied and the |value| reference will not change.
    /// Otherwise, ownership will be transferred to this object and the |value|
    /// reference will be invalidated.
    public func setList(value: ListValue, atIndex index: Int) -> Bool {
        return cefObject.set_list(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> ListValue? {
        return ListValue(ptr: ptr)
    }
}

