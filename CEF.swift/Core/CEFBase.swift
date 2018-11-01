//
//  CEFBase.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 10..
//
//

import Foundation


public protocol CEFObject: DefaultInitializable {
    var base: cef_base_ref_counted_t { get set }
}

public protocol CEFScopedObject: DefaultInitializable {
    var base: cef_base_scoped_t { get set }
}

protocol CEFRefCounting: class {
    func addRef()
    func release() -> Bool
    func hasOneRef() -> Bool
    func hasAtLeastOneRef() -> Bool
}


public class CEFProxy<T : CEFObject>: CEFRefCounting {
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: UnsafeMutablePointer<T>
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { return _cefPtr }
    var cefObject: ObjectType { return _cefPtr.pointee }
    
    init?(ptr: UnsafeMutablePointer<T>?) {
        guard let ptr = ptr else {
            return nil
        }
        
        _cefPtr = ptr
    }
    
    deinit {
        release()
    }

    func addRef() {
        _cefPtr.withMemoryRebound(to: cef_base_ref_counted_t.self, capacity: 1) { basePtr in
            _cefPtr.pointee.base.add_ref(basePtr)
        }
    }
    
    @discardableResult
    func release() -> Bool {
        return _cefPtr.withMemoryRebound(to: cef_base_ref_counted_t.self, capacity: 1) { basePtr in
            return _cefPtr.pointee.base.release(basePtr) != 0
        }
    }
    
    func hasOneRef() -> Bool {
        return _cefPtr.withMemoryRebound(to: cef_base_ref_counted_t.self, capacity: 1) { basePtr in
            return _cefPtr.pointee.base.has_one_ref(basePtr) != 0
        }
    }
    
    func hasAtLeastOneRef() -> Bool {
        return _cefPtr.withMemoryRebound(to: cef_base_ref_counted_t.self, capacity: 1) { basePtr in
            return _cefPtr.pointee.base.has_at_least_one_ref(basePtr) != 0
        }
    }

    func toCEF() -> UnsafeMutablePointer<ObjectType> {
        addRef()
        return cefObjectPtr
    }
}

public class CEFScopedProxy<T : CEFScopedObject> {
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: UnsafeMutablePointer<T>
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { return _cefPtr }
    var cefObject: ObjectType { return _cefPtr.pointee }
    
    init?(ptr: UnsafeMutablePointer<T>?) {
        guard let ptr = ptr else {
            return nil
        }
        
        _cefPtr = ptr
    }
    
    func delete() {
        _cefPtr.withMemoryRebound(to: cef_base_scoped_t.self, capacity: 1) { basePtr in
            _cefPtr.pointee.base.del(basePtr)
        }
    }
    
    func toCEF() -> UnsafeMutablePointer<ObjectType> {
        return cefObjectPtr
    }
}

