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

/// Class that wraps other data value types. Complex types (binary, dictionary
/// and list) will be referenced but not owned by this object. Can be used on any
/// process and thread.
public class CEFValue: CEFProxy<cef_value_t> {

    /// Creates a new object.
    public init?() {
        super.init(ptr: cef_value_create())
    }
    
    /// Returns true if the underlying data is valid. This will always be true for
    /// simple types. For complex types (binary, dictionary and list) the
    /// underlying data may become invalid if owned by another object (e.g. list or
    /// dictionary) and that other object is then modified or destroyed. This value
    /// object can be re-used by calling Set*() even if the underlying data is
    /// invalid.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the underlying data is owned by another object.
    public var isOwned: Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    /// Returns true if the underlying data is read-only. Some APIs may expose
    /// read-only objects.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data. If true modifications to this object will also affect |that| object
    /// and vice-versa.
    public func isSameAs(other: CEFValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    public func isEqualTo(other: CEFValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a copy of this object. The underlying data will also be copied.
    public func copy() -> CEFValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFValue.fromCEF(copiedObj)
    }

    /// Returns the underlying value type.
    public var type: CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFValueType.fromCEF(cefType)
    }

    /// Returns the underlying value as type bool.
    public var boolValue: Bool {
        return cefObject.get_bool(cefObjectPtr) != 0
    }

    /// Returns the underlying value as type int.
    public var intValue: Int {
        return Int(cefObject.get_int(cefObjectPtr))
    }

    /// Returns the underlying value as type double.
    public var doubleValue: Double {
        return cefObject.get_double(cefObjectPtr)
    }
    
    /// Returns the underlying value as type string.
    public var stringValue: String? {
        let cefStrPtr = cefObject.get_string(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }

    /// Returns the underlying value as type binary. The returned reference may
    /// become invalid if the value is owned by another object or if ownership is
    /// transferred to another object in the future. To maintain a reference to
    /// the value after assigning ownership to a dictionary or list pass this
    /// object to the SetValue() method instead of passing the returned reference
    /// to SetBinary().
    public var binaryValue: CEFBinaryValue? {
        let cefBinary = cefObject.get_binary(cefObjectPtr)
        return CEFBinaryValue.fromCEF(cefBinary)
    }

    /// Returns the underlying value as type dictionary. The returned reference may
    /// become invalid if the value is owned by another object or if ownership is
    /// transferred to another object in the future. To maintain a reference to
    /// the value after assigning ownership to a dictionary or list pass this
    /// object to the SetValue() method instead of passing the returned reference
    /// to SetDictionary().
    public var dictionaryValue: CEFDictionaryValue? {
        let cefDict = cefObject.get_dictionary(cefObjectPtr)
        return CEFDictionaryValue.fromCEF(cefDict)
    }

    /// Returns the underlying value as type list. The returned reference may
    /// become invalid if the value is owned by another object or if ownership is
    /// transferred to another object in the future. To maintain a reference to
    /// the value after assigning ownership to a dictionary or list pass this
    /// object to the SetValue() method instead of passing the returned reference
    /// to SetList().
    public var listValue: CEFListValue? {
        let cefList = cefObject.get_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)
    }

    /// Sets the underlying value as type null. Returns true if the value was set
    /// successfully.
    public func setNull() -> Bool {
        return cefObject.set_null(cefObjectPtr) != 0
    }

    /// Sets the underlying value as type bool. Returns true if the value was set
    /// successfully.
    public func setBool(value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, value ? 1 : 0) != 0
    }

    /// Sets the underlying value as type int. Returns true if the value was set
    /// successfully.
    public func setInt(value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(value)) != 0
    }

    /// Sets the underlying value as type double. Returns true if the value was set
    /// successfully.
    public func setDouble(value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, value) != 0
    }

    /// Sets the underlying value as type string. Returns true if the value was set
    /// successfully.
    public func setString(string: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_string(cefObjectPtr, cefStrPtr) != 0
    }

    /// Sets the underlying value as type binary. Returns true if the value was set
    /// successfully. This object keeps a reference to |value| and ownership of the
    /// underlying data remains unchanged.
    public func setBinary(value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, value.toCEF()) != 0
    }
    
    /// Sets the underlying value as type dict. Returns true if the value was set
    /// successfully. This object keeps a reference to |value| and ownership of the
    /// underlying data remains unchanged.
    public func setDictionary(value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, value.toCEF()) != 0
    }

    /// Sets the underlying value as type list. Returns true if the value was set
    /// successfully. This object keeps a reference to |value| and ownership of the
    /// underlying data remains unchanged.
    public func setList(value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, value.toCEF()) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFValue? {
        return CEFValue(ptr: ptr)
    }
}
