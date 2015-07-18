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

protocol CEFBase: class, CEFRefCounting {
    typealias ObjectType : CEFObject
    typealias ObjectPtrType = UnsafeMutablePointer<ObjectType>
    
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { get set }
    var cefObject: ObjectType { get set }
    
    func toCEF() -> UnsafeMutablePointer<ObjectType>
}

extension CEFBase {
    func toCEF() -> UnsafeMutablePointer<ObjectType> {
        addRef()
        return cefObjectPtr
    }
}

protocol CEFRefCounting: class {
    func addRef()
    func release() -> Bool
    func hasOneRef() -> Bool
}


protocol CEFProxyRefCounting: CEFRefCounting {
    typealias ObjectType
}

extension CEFProxyRefCounting where Self : CEFBase {
    func addRef() {
        self.cefObject.base.add_ref(&self.cefObject.base)
    }
    
    func release() -> Bool {
        return self.cefObject.base.release(&self.cefObject.base) != 0
    }
    
    func hasOneRef() -> Bool {
        return self.cefObject.base.has_one_ref(&self.cefObject.base) != 0
    }
}


public class CEFProxyBase<T : CEFObject>: CEFBase, CEFProxyRefCounting {
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: ObjectPtrType
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { get { return _cefPtr } set {} }
    var cefObject: ObjectType { get { return _cefPtr.memory } set {} }
    
    public required init?(ptr: ObjectPtrType) {
        if ptr == nil {
            _cefPtr = nil
            return nil
        }
        
        _cefPtr = ptr
    }
    
    deinit {
        release()
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> Self? {
        return self.init(ptr: ptr)
    }
}
