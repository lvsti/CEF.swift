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

public class CEFListValue: CEFProxy<cef_list_value_t> {

    public init?() {
        super.init(ptr: cef_list_value_create())
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
    
    public func isSame(other: CEFListValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    public func isEqual(other: CEFListValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }

    public func copy() -> CEFListValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFListValue.fromCEF(copiedObj)
    }

    public func setSize(size: size_t) {
        cefObject.set_size(cefObjectPtr, size)
    }

    public func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }

    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }

    public func remove(index: Int) -> Bool {
        return cefObject.remove(cefObjectPtr, Int32(index)) != 0
    }

    public func getType(index: Int) -> CEFValueType {
        let cefType = cefObject.get_type(cefObjectPtr, Int32(index))
        return CEFValueType(rawValue: Int(cefType.rawValue))!
    }

    public func getValue(index: Int) -> CEFValue {
        let cefValue = cefObject.get_value(cefObjectPtr, Int32(index))
        return CEFValue.fromCEF(cefValue)!
    }

    public func getBool(index: Int) -> Bool {
        return cefObject.get_bool(cefObjectPtr, Int32(index)) != 0
    }

    public func getInt(index: Int) -> Int {
        return Int(cefObject.get_int(cefObjectPtr, Int32(index)))
    }

    public func getDouble(index: Int) -> Double {
        return cefObject.get_double(cefObjectPtr, Int32(index))
    }
    
    public func getString(index: Int) -> String {
        let cefStrPtr = cefObject.get_string(cefObjectPtr, Int32(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getBinary(index: Int) -> CEFBinaryValue {
        let cefBinary = cefObject.get_binary(cefObjectPtr, Int32(index))
        return CEFBinaryValue.fromCEF(cefBinary)!
    }

    public func getDictionary(index: Int) -> CEFDictionaryValue {
        let cefDict = cefObject.get_dictionary(cefObjectPtr, Int32(index))
        return CEFDictionaryValue.fromCEF(cefDict)!
    }

    public func getList(index: Int) -> CEFListValue {
        let cefList = cefObject.get_list(cefObjectPtr, Int32(index))
        return CEFListValue.fromCEF(cefList)!
    }

    public func setValue(index: Int, value: CEFValue) -> Bool {
        return cefObject.set_value(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    public func setNull(index: Int) -> Bool {
        return cefObject.set_null(cefObjectPtr, Int32(index)) != 0
    }

    public func setBool(index: Int, value: Bool) -> Bool {
        return cefObject.set_bool(cefObjectPtr, Int32(index), value ? 1 : 0) != 0
    }

    public func setInt(index: Int, value: Int) -> Bool {
        return cefObject.set_int(cefObjectPtr, Int32(index), Int32(value)) != 0
    }

    public func setDouble(index: Int, value: Double) -> Bool {
        return cefObject.set_double(cefObjectPtr, Int32(index), value) != 0
    }

    public func setString(index: Int, string: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(string)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_string(cefObjectPtr, Int32(index), cefStrPtr) != 0
    }

    public func setBinary(index: Int, value: CEFBinaryValue) -> Bool {
        return cefObject.set_binary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }
    
    public func setDictionary(index: Int, value: CEFDictionaryValue) -> Bool {
        return cefObject.set_dictionary(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

    public func setList(index: Int, value: CEFListValue) -> Bool {
        return cefObject.set_list(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }

}

