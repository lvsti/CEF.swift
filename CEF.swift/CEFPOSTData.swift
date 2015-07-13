//
//  CEFPOSTData.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_post_data_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

public class CEFPOSTData: CEFBase<cef_post_data_t> {
    
    init() {
        super.init(pointer: cef_post_data_create())
    }
    
    override init(proxiedObject obj: cef_post_data_t) {
        super.init(proxiedObject: obj)
    }
    
    func isReadOnly() -> Bool {
        return object.is_read_only(cefSelf) != 0
    }

    func getElementCount() -> size_t {
        return object.get_element_count(cefSelf)
    }
    
    func getElements() -> [CEFPOSTDataElement] {
        let countPtr = UnsafeMutablePointer<size_t>()
        let elementsPtr = UnsafeMutablePointer<UnsafeMutablePointer<cef_post_data_element_t>>()
        
        object.get_elements(cefSelf, countPtr, elementsPtr)
        
        var elements = [CEFPOSTDataElement]()
        for i in 0..<countPtr.memory {
            let pde = elementsPtr.advancedBy(i).memory.memory
            elements.append(CEFPOSTDataElement(proxiedObject: pde))
        }
        
        return elements
    }
    
    func removeElement(element: CEFPOSTDataElement) {
        object.remove_element(cefSelf, element.cefSelf)
    }
    
    func addElement(element: CEFPOSTDataElement) {
        object.add_element(cefSelf, element.cefSelf)
    }
    
    func removeElements() {
        object.remove_elements(cefSelf)
    }

}
