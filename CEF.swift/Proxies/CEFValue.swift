//
//  CEFValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFValue {

    /// Creates a new object.
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_value_create())
    }

    public convenience init?(_ el: Any) {
        self.init(ptr: cef_value_create())

        // Type checking order is important
        if el is String {
            setString(el as! String)
        } else if el is Int64 {
            setInt64(el as! Int64)
        } else if el is UInt64 {
            setUInt64(el as! UInt64)
        } else if el is Int32 {
            setInt32(el as! Int32)
        } else if el is UInt32 {
            setUInt32(el as! UInt32)
        } else if el is Int {
            setInt(el as! Int)
        } else if el is UInt {
            setUInt(el as! UInt)
        } else if el is Double {
            setDouble(el as! Double)
        } else if el is Bool {
            setBool(el as! Bool)
        } else if el is NSNull {
            setNull()
        } else if el is [Any] {
            if let l = CEFListValue(el as! [Any]) {
                setList(l)
            }
        } else if el is [String: Any] {
            if let d = CEFDictionaryValue(el as! [String: Any]) {
                setDictionary(d)
            }
        }
    }

    /// Returns true if the underlying data is valid. This will always be true for
    /// simple types. For complex types (binary, dictionary and list) the
    /// underlying data may become invalid if owned by another object (e.g. list or
    /// dictionary) and that other object is then modified or destroyed. This value
    /// object can be re-used by calling Set*() even if the underlying data is
    /// invalid.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the underlying data is owned by another object.
    /// CEF name: `IsOwned`
    public var isOwned: Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }

    /// Returns true if the underlying data is read-only. Some APIs may expose
    /// read-only objects.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data. If true modifications to this object will also affect |that| object
    /// and vice-versa.
    /// CEF name: `IsSame`
    public func isSame(as other: CEFValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    /// CEF name: `IsEqual`
    public func isEqual(to other: CEFValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns a copy of this object. The underlying data will also be copied.
    /// CEF name: `Copy`
    public func copy() -> CEFValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFValue.fromCEF(copiedObj)
    }

    /// Returns the underlying value type.
    /// CEF name: `GetType`
    public var type: CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFValueType.fromCEF(cefType)
    }

    /// Returns the underlying value as type bool.
    /// CEF name: `GetBool`
    public var boolValue: Bool {
        return cefObject.get_bool(cefObjectPtr) != 0
    }

    /// Returns the underlying value as type int.
    /// CEF name: `GetInt`
    public var intValue: Int {
        return Int(cefObject.get_int(cefObjectPtr))
    }

    public var uintValue: UInt {
        return UInt(bitPattern: intValue)
    }

    public var int32Value: Int32 {
        return cefObject.get_int(cefObjectPtr)
    }

    public var uint32Value: UInt32 {
        return UInt32(bitPattern: cefObject.get_int(cefObjectPtr))
    }

    public var int64Value: Int64 {
        if let b = binaryValue {
            return b.int64
        }
        return 0
    }

    public var uint64Value: UInt64 {
        if let b = binaryValue {
            return b.uint64
        }
        return 0
    }

    /// Returns the underlying value as type double.
    /// CEF name: `GetDouble`
    public var doubleValue: Double {
        return cefObject.get_double(cefObjectPtr)
    }
    
    /// Returns the underlying value as type string.
    /// CEF name: `GetString`
    public var stringValue: String {
        let cefStrPtr = cefObject.get_string(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }

    /// Returns the underlying value as type binary. The returned reference may
    /// become invalid if the value is owned by another object or if ownership is
    /// transferred to another object in the future. To maintain a reference to
    /// the value after assigning ownership to a dictionary or list pass this
    /// object to the SetValue() method instead of passing the returned reference
    /// to SetBinary().
    /// CEF name: `GetBinary`
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
    /// CEF name: `GetDictionary`
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
    /// CEF name: `GetList`
    public var listValue: CEFListValue? {
        let cefList = cefObject.get_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)
    }

    /// Sets the underlying value as type null. Returns true if the value was set
    /// successfully.
    /// CEF name: `SetNull`
    @discardableResult
    public func setNull() -> Bool {
        return cefObject.set_null(cefObjectPtr) != 0
    }

    /// Sets the underlying value as type bool. Returns true if the value was set
    /// successfully.
    /// CEF name: `SetBool`
    @discardableResult
    public func setBool(_ value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, value ? 1 : 0) != 0
    }

    /// Sets the underlying value as type int. Returns true if the value was set
    /// successfully.
    /// CEF name: `SetInt`
    @discardableResult
    public func setInt(_ value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(value)) != 0
    }

    @discardableResult
    public func setUInt(_ value: UInt) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(bitPattern:UInt32(value))) != 0
    }

    @discardableResult
    public func setInt32(_ value: Int32) -> Bool {
        return cefObject.set_int(cefObjectPtr, value) != 0
    }

    @discardableResult
    public func setUInt32(_ value: UInt32) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(bitPattern:value)) != 0
    }

    @discardableResult
    public func setInt64(_ value: Int64) -> Bool {
        if let b = CEFBinaryValue(value) {
            return setBinary(b)
        }
        return false
    }

    @discardableResult
    public func setUInt64(_ value: UInt64) -> Bool {
        if let b = CEFBinaryValue(value) {
            return setBinary(b)
        }
        return false
    }

    /// Sets the underlying value as type double. Returns true if the value was set
    /// successfully.
    /// CEF name: `SetDouble`
    @discardableResult
    public func setDouble(_ value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, value) != 0
    }

    /// Sets the underlying value as type string. Returns true if the value was set
    /// successfully.
    /// CEF name: `SetString`
    @discardableResult
    public func setString(_ string: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_string(cefObjectPtr, cefStrPtr) != 0
    }

    /// Sets the underlying value as type binary. Returns true if the value was set
    /// successfully. This object keeps a reference to |value| and ownership of the
    /// underlying data remains unchanged.
    /// CEF name: `SetBinary`
    @discardableResult
    public func setBinary(_ value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, value.toCEF()) != 0
    }
    
    /// Sets the underlying value as type dict. Returns true if the value was set
    /// successfully. This object keeps a reference to |value| and ownership of the
    /// underlying data remains unchanged.
    /// CEF name: `SetDictionary`
    @discardableResult
    public func setDictionary(_ value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, value.toCEF()) != 0
    }

    /// Sets the underlying value as type list. Returns true if the value was set
    /// successfully. This object keeps a reference to |value| and ownership of the
    /// underlying data remains unchanged.
    /// CEF name: `SetList`
    @discardableResult
    public func setList(_ value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, value.toCEF()) != 0
    }
}
