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
    private let _cefPtr: UnsafeMutablePointer<T>
    var cefObjectPtr: UnsafeMutablePointer<T> { get { return _cefPtr } }
    var cefObject: T { get { return _cefPtr.memory } }
    
    init?(ptr: UnsafeMutablePointer<T>) {
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
    
    func release() {
        _cefPtr.memory.base.release(&_cefPtr.memory.base)
    }
    
    func hasOneRef() -> Bool {
        return _cefPtr.memory.base.has_one_ref(&_cefPtr.memory.base) != 0
    }
}
