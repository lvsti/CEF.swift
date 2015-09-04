//
//  CEFV8Value.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 31..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


extension cef_v8value_t: CEFObject {
}


/// Class representing a V8 value handle. V8 handles can only be accessed from
/// the thread on which they are created. Valid threads for creating a V8 handle
/// include the render process main thread (TID_RENDERER) and WebWorker threads.
/// A task runner for posting tasks on the associated thread can be retrieved via
/// the CefV8Context::GetTaskRunner() method.
public class CEFV8Value: CEFProxy<cef_v8value_t> {
 
    /// Create a new CefV8Value object of type undefined.
    public static func createUndefined() -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_undefined())
    }
    
    /// Create a new CefV8Value object of type null.
    public static func createNull() -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_null())
    }
    
    /// Create a new CefV8Value object of type bool.
    public static func createBool(value: Bool) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_bool(value ? 1 : 0))
    }

    /// Create a new CefV8Value object of type int.
    public static func createInt(value: Int) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_int(Int32(value)))
    }

    /// Create a new CefV8Value object of type unsigned int.
    public static func createUInt(value: UInt) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_uint(UInt32(value)))
    }
    
    /// Create a new CefV8Value object of type double.
    public static func createDouble(value: Double) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_double(value))
    }
    
    /// Create a new CefV8Value object of type Date. This method should only be
    /// called from within the scope of a CefRenderProcessHandler, CefV8Handler or
    /// CefV8Accessor callback, or in combination with calling Enter() and Exit()
    /// on a stored CefV8Context reference.
    public static func createDate(value: NSDate) -> CEFV8Value? {
        let cefTimePtr = CEFTimePtrCreateFromNSDate(value)
        defer { CEFTimePtrRelease(cefTimePtr) }
        return CEFV8Value.fromCEF(cef_v8value_create_date(cefTimePtr))
    }
    
    /// Create a new CefV8Value object of type string.
    public static func createString(value: String?) -> CEFV8Value? {
        let cefStrPtr = value != nil ? CEFStringPtrCreateFromSwiftString(value!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFV8Value.fromCEF(cef_v8value_create_string(cefStrPtr))
    }

    /// Create a new CefV8Value object of type object with optional accessor. This
    /// method should only be called from within the scope of a
    /// CefRenderProcessHandler, CefV8Handler or CefV8Accessor callback, or in
    /// combination with calling Enter() and Exit() on a stored CefV8Context
    /// reference.
    public static func createObject(accessor: CEFV8Accessor? = nil) -> CEFV8Value? {
        let cefAccessorPtr = (accessor != nil) ? accessor!.toCEF() : nil
        return CEFV8Value.fromCEF(cef_v8value_create_object(cefAccessorPtr))
    }

    /// Create a new CefV8Value object of type array with the specified |length|.
    /// If |length| is negative the returned array will have length 0. This method
    /// should only be called from within the scope of a CefRenderProcessHandler,
    /// CefV8Handler or CefV8Accessor callback, or in combination with calling
    /// Enter() and Exit() on a stored CefV8Context reference.
    public static func createArray(length: Int) -> CEFV8Value? {
        return CEFV8Value.fromCEF(cef_v8value_create_array(Int32(length)))
    }
    
    /// Create a new CefV8Value object of type function. This method should only be
    /// called from within the scope of a CefRenderProcessHandler, CefV8Handler or
    /// CefV8Accessor callback, or in combination with calling Enter() and Exit()
    /// on a stored CefV8Context reference.
    public static func createFunction(name: String, handler: CEFV8Handler? = nil) -> CEFV8Value? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefHandlerPtr = handler != nil ? handler!.toCEF() : nil
        return CEFV8Value.fromCEF(cef_v8value_create_function(cefStrPtr, cefHandlerPtr))
    }
    
    /// Returns true if the underlying handle is valid and it can be accessed on
    /// the current thread. Do not call any other methods if this method returns
    /// false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// True if the value type is undefined.
    public var isUndefined: Bool {
        return cefObject.is_undefined(cefObjectPtr) != 0
    }

    /// True if the value type is null.
    public var isNull: Bool {
        return cefObject.is_null(cefObjectPtr) != 0
    }

    /// True if the value type is bool.
    public var isBool: Bool {
        return cefObject.is_bool(cefObjectPtr) != 0
    }
    
    /// True if the value type is int.
    public var isInt: Bool {
        return cefObject.is_int(cefObjectPtr) != 0
    }
    
    /// True if the value type is unsigned int.
    public var isUInt: Bool {
        return cefObject.is_uint(cefObjectPtr) != 0
    }

    /// True if the value type is double.
    public var isDouble: Bool {
        return cefObject.is_double(cefObjectPtr) != 0
    }
    
    /// True if the value type is Date.
    public var isDate: Bool {
        return cefObject.is_date(cefObjectPtr) != 0
    }

    /// True if the value type is string.
    public var isString: Bool {
        return cefObject.is_string(cefObjectPtr) != 0
    }
    
    /// True if the value type is object.
    public var isObject: Bool {
        return cefObject.is_object(cefObjectPtr) != 0
    }
    
    /// True if the value type is array.
    public var isArray: Bool {
        return cefObject.is_array(cefObjectPtr) != 0
    }

    /// True if the value type is function.
    public var isFunction: Bool {
        return cefObject.is_function(cefObjectPtr) != 0
    }

    /// Returns true if this object is pointing to the same handle as |that|
    /// object.
    public func isSame(other: CEFV8Value) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Return a bool value.  The underlying data will be converted to if
    /// necessary.
    public var boolValue: Bool {
        return cefObject.get_bool_value(cefObjectPtr) != 0
    }
    
    /// Return an int value.  The underlying data will be converted to if
    /// necessary.
    public var intValue: Int {
        return Int(cefObject.get_int_value(cefObjectPtr))
    }
    
    /// Return an unisgned int value.  The underlying data will be converted to if
    /// necessary.
    public var uintValue: UInt {
        return UInt(cefObject.get_uint_value(cefObjectPtr))
    }
    
    /// Return a double value.  The underlying data will be converted to if
    /// necessary.
    public var doubleValue: Double {
        return cefObject.get_double_value(cefObjectPtr)
    }

    /// Return a Date value.  The underlying data will be converted to if
    /// necessary.
    public var dateValue: NSDate {
        let cefTime = cefObject.get_date_value(cefObjectPtr)
        return CEFTimeToNSDate(cefTime)
    }

    /// Return a string value.  The underlying data will be converted to if
    /// necessary.
    public var stringValue: String {
        let cefStrPtr = cefObject.get_string_value(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    // OBJECT METHODS - These methods are only available on objects. Arrays and
    // functions are also objects. String- and integer-based keys can be used
    // interchangably with the framework converting between them as necessary.
    
    /// Returns true if this is a user created object.
    public var isUserCreated: Bool {
        return cefObject.is_user_created(cefObjectPtr) != 0
    }

    /// Returns true if the last method call resulted in an exception. This
    /// attribute exists only in the scope of the current CEF value object.
    public var hasException: Bool {
        return cefObject.has_exception(cefObjectPtr) != 0
    }
    
    /// Returns the exception resulting from the last method call. This attribute
    /// exists only in the scope of the current CEF value object.
    public var exception: CEFV8Exception? {
        let cefExc = cefObject.get_exception(cefObjectPtr)
        return CEFV8Exception.fromCEF(cefExc)
    }
    
    /// Clears the last exception and returns true on success.
    public func clearException() -> Bool {
        return cefObject.clear_exception(cefObjectPtr) != 0
    }
    
    /// Whether this object will re-throw future exceptions. By default
    /// exceptions are not re-thrown. If a exception is re-thrown the current
    /// context should not be accessed again until after the exception has been
    /// caught and not re-thrown. Returns true on success. This attribute exists
    /// only in the scope of the current CEF value object.
    public var rethrowsExceptions: Bool {
        get { return cefObject.will_rethrow_exceptions(cefObjectPtr) != 0 }
        set { cefObject.set_rethrow_exceptions(cefObjectPtr, newValue ? 1 : 0) }
    }
    
    /// Set whether this object will re-throw future exceptions. By default
    /// exceptions are not re-thrown. If a exception is re-thrown the current
    /// context should not be accessed again until after the exception has been
    /// caught and not re-thrown. Returns true on success. This attribute exists
    /// only in the scope of the current CEF value object.
    public func setRethrowsExcepions(value: Bool) -> Bool {
        return cefObject.set_rethrow_exceptions(cefObjectPtr, value ? 1 : 0) != 0
    }

    /// Returns true if the object has a value with the specified identifier.
    public func hasValueForKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.has_value_bykey(cefObjectPtr, cefKeyPtr) != 0
    }

    /// Returns true if the object has a value with the specified identifier.
    public func hasValueAtIndex(index: Int) -> Bool {
        return cefObject.has_value_byindex(cefObjectPtr, Int32(index)) != 0
    }
    
    /// Deletes the value with the specified identifier and returns true on
    /// success. Returns false if this method is called incorrectly or an exception
    /// is thrown. For read-only and don't-delete values this method will return
    /// true even though deletion failed.
    public func removeValueForKey(key: String) -> Bool {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.delete_value_bykey(cefObjectPtr, cefKeyPtr) != 0
    }
    
    /// Deletes the value with the specified identifier and returns true on
    /// success. Returns false if this method is called incorrectly, deletion fails
    /// or an exception is thrown. For read-only and don't-delete values this
    /// method will return true even though deletion failed.
    public func removeValueAtIndex(index: Int) -> Bool {
        return cefObject.delete_value_byindex(cefObjectPtr, Int32(index)) != 0
    }

    /// Returns the value with the specified identifier on success. Returns NULL
    /// if this method is called incorrectly or an exception is thrown.
    public func valueForKey(key: String) -> CEFV8Value? {
        let cefKeyPtr = CEFStringPtrCreateFromSwiftString(key)
        defer { CEFStringPtrRelease(cefKeyPtr) }
        let cefValue = cefObject.get_value_bykey(cefObjectPtr, cefKeyPtr)
        return CEFV8Value.fromCEF(cefValue)
    }

    /// Returns the value with the specified identifier on success. Returns NULL
    /// if this method is called incorrectly or an exception is thrown.
    public func valueAtIndex(index: Int) -> CEFV8Value? {
        let cefValue = cefObject.get_value_byindex(cefObjectPtr, Int32(index))
        return CEFV8Value.fromCEF(cefValue)
    }

    /// Associates a value with the specified identifier and returns true on
    /// success. Returns false if this method is called incorrectly or an exception
    /// is thrown. For read-only values this method will return true even though
    /// assignment failed.
    public func setValue(value: CEFV8Value, forKey key: String?, attribute: CEFV8PropertyAttribute) -> Bool {
        let cefKeyPtr = key != nil ? CEFStringPtrCreateFromSwiftString(key!) : nil
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value_bykey(cefObjectPtr, cefKeyPtr, value.toCEF(), attribute.toCEF()) != 0
    }

    /// Associates a value with the specified identifier and returns true on
    /// success. Returns false if this method is called incorrectly or an exception
    /// is thrown. For read-only values this method will return true even though
    /// assignment failed.
    public func setValue(value: CEFV8Value, atIndex index: Int) -> Bool {
        return cefObject.set_value_byindex(cefObjectPtr, Int32(index), value.toCEF()) != 0
    }
    
    /// Registers an identifier and returns true on success. Access to the
    /// identifier will be forwarded to the CefV8Accessor instance passed to
    /// CefV8Value::CreateObject(). Returns false if this method is called
    /// incorrectly or an exception is thrown. For read-only values this method
    /// will return true even though assignment failed.
    public func setValue(forKey key: String?, access: CEFV8AccessControl, attribute: CEFV8PropertyAttribute) -> Bool {
        let cefKeyPtr = key != nil ? CEFStringPtrCreateFromSwiftString(key!) : nil
        defer { CEFStringPtrRelease(cefKeyPtr) }
        return cefObject.set_value_byaccessor(cefObjectPtr, cefKeyPtr, access.toCEF(), attribute.toCEF()) != 0
    }
    
    /// Read the keys for the object's values into the specified vector. Integer-
    /// based keys will also be returned as strings.
    public var allKeys: [String] {
        let cefKeys = cef_string_list_alloc()
        defer { cef_string_list_free(cefKeys) }
        cefObject.get_keys(cefObjectPtr, cefKeys)
        return CEFStringListToSwiftArray(cefKeys)
    }
    
    /// The user data for this object
    public var userData: CEFUserData? {
        get {
            let cefUserData = cefObject.get_user_data(cefObjectPtr)
            return CEFUserData.fromCEF(cefUserData)
        }
        set {
            let cefUserData = newValue != nil ? newValue!.toCEF() : nil
            cefObject.set_user_data(cefObjectPtr, cefUserData)
        }
    }
    
    /// Returns the amount of externally allocated memory registered for the
    /// object.
    public var externallyAllocatedMemory: Int {
        return Int(cefObject.get_externally_allocated_memory(cefObjectPtr))
    }
    
    /// Adjusts the amount of registered external memory for the object. Used to
    /// give V8 an indication of the amount of externally allocated memory that is
    /// kept alive by JavaScript objects. V8 uses this information to decide when
    /// to perform global garbage collection. Each CefV8Value tracks the amount of
    /// external memory associated with it and automatically decreases the global
    /// total by the appropriate amount on its destruction. |change_in_bytes|
    /// specifies the number of bytes to adjust by. This method returns the number
    /// of bytes associated with the object after the adjustment. This method can
    /// only be called on user created objects.
    public func adjustExternallyAllocatedMemory(change: Int) -> Int {
        return Int(cefObject.adjust_externally_allocated_memory(cefObjectPtr, Int32(change)))
    }
    
    // ARRAY METHODS - These methods are only available on arrays.
    
    /// Returns the number of elements in the array.
    public var arrayLength: Int {
        return Int(cefObject.get_array_length(cefObjectPtr))
    }
    
    // FUNCTION METHODS - These methods are only available on functions.
    
    /// Returns the function name.
    public var functionName: String {
        let cefStrPtr = cefObject.get_function_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the function handler or NULL if not a CEF-created function.
    public var functionHandler: CEFV8Handler? {
        let cefHandler = cefObject.get_function_handler(cefObjectPtr)
        return CEFV8HandlerMarshaller.take(cefHandler)
    }
    
    /// Execute the function using the current V8 context. This method should only
    /// be called from within the scope of a CefV8Handler or CefV8Accessor
    /// callback, or in combination with calling Enter() and Exit() on a stored
    /// CefV8Context reference. |object| is the receiver ('this' object) of the
    /// function. If |object| is empty the current context's global object will be
    /// used. |arguments| is the list of arguments that will be passed to the
    /// function. Returns the function return value on success. Returns NULL if
    /// this method is called incorrectly or an exception is thrown.
    public func executeFunction(object: CEFV8Value?, arguments: [CEFV8Value]) -> CEFV8Value? {
        let cefV8Obj = object != nil ? object!.toCEF() : nil
        let cefArgs = UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>.alloc(arguments.count)
        defer { cefArgs.dealloc(arguments.count) }
        
        for i in 0..<arguments.count {
            let cefArg = arguments[i].toCEF()
            cefArgs.advancedBy(i).initialize(cefArg)
        }
        
        let cefValue = cefObject.execute_function(cefObjectPtr, cefV8Obj, arguments.count, cefArgs)
        return CEFV8Value.fromCEF(cefValue)
    }
    
    /// Execute the function using the specified V8 context. |object| is the
    /// receiver ('this' object) of the function. If |object| is empty the
    /// specified context's global object will be used. |arguments| is the list of
    /// arguments that will be passed to the function. Returns the function return
    /// value on success. Returns NULL if this method is called incorrectly or an
    /// exception is thrown.
    public func executeFunctionWithContext(context: CEFV8Context, object: CEFV8Value?, arguments: [CEFV8Value]) -> CEFV8Value? {
        let cefV8Obj = object != nil ? object!.toCEF() : nil
        let cefArgs = UnsafeMutablePointer<UnsafeMutablePointer<cef_v8value_t>>.alloc(arguments.count)
        defer { cefArgs.dealloc(arguments.count) }
        
        for i in 0..<arguments.count {
            let cefArg = arguments[i].toCEF()
            cefArgs.advancedBy(i).initialize(cefArg)
        }
        
        let cefValue = cefObject.execute_function_with_context(cefObjectPtr,
                                                               context.toCEF(),
                                                               cefV8Obj,
                                                               arguments.count,
                                                               cefArgs)
        return CEFV8Value.fromCEF(cefValue)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFV8Value? {
        return CEFV8Value(ptr: ptr)
    }

}