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
    
    let cefSelf: UnsafeMutablePointer<T>
    var object: T { return cefSelf.memory }
    
    init(proxiedObject obj: T) {
        self.cefSelf = UnsafeMutablePointer<T>.alloc(1)
        self.cefSelf.memory = obj
    }

    init(pointer ptr: UnsafeMutablePointer<T>) {
        self.cefSelf = ptr
    }

    deinit {
        self.cefSelf.memory.base.release(&self.cefSelf.memory.base)
    }
    
}
