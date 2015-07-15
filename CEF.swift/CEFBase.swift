//
//  CEFBase.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 10..
//
//

import Foundation

public protocol CEFObject {
    var base: cef_base_t { get nonmutating set }
}

public class CEFBase<T : CEFObject> {
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: ObjectPtrType
    var cefObjectPtr: ObjectPtrType { get { return _cefPtr } }
    var cefObject: ObjectType { get { return _cefPtr.memory } }
    
    public required init?(ptr: ObjectPtrType) {
        if ptr == nil {
            _cefPtr = nil
            return nil
        }
        
        _cefPtr = ptr
    }
    
    deinit {
        if _cefPtr != nil {
            release()
        }
    }
    
    func addRef() {
        _cefPtr.memory.base.add_ref(&_cefPtr.memory.base)
    }
    
    func release() -> Bool {
        return _cefPtr.memory.base.release(&_cefPtr.memory.base) != 0
    }
    
    func hasOneRef() -> Bool {
        return _cefPtr.memory.base.has_one_ref(&_cefPtr.memory.base) != 0
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> Self? {
        return self.init(ptr: ptr)
    }
    
    func toCEF() -> ObjectPtrType {
        addRef()
        return cefObjectPtr
    }
}
