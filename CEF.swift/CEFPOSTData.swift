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
    
    override init?(ptr: UnsafeMutablePointer<cef_post_data_t>) {
        super.init(ptr: ptr)
    }
    
    func toCEF() -> UnsafeMutablePointer<cef_post_data_t> {
        addRef()
        return cefObjectPtr
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_post_data_t>) -> CEFPOSTData? {
        return CEFPOSTData(ptr: ptr)
    }
    
    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    func getElementCount() -> size_t {
        return cefObject.get_element_count(cefObjectPtr)
    }
    
    func getElements() -> [CEFPOSTDataElement] {
        let countPtr = UnsafeMutablePointer<size_t>()
        let elementsPtr = UnsafeMutablePointer<UnsafeMutablePointer<cef_post_data_element_t>>()
        
        cefObject.get_elements(cefObjectPtr, countPtr, elementsPtr)
        
        var elements = [CEFPOSTDataElement]()
        for i in 0..<countPtr.memory {
            let cefPDEPtr = elementsPtr.advancedBy(i).memory
            if let pde = CEFPOSTDataElement.fromCEF(cefPDEPtr) {
                elements.append(pde)
            }
        }
        
        return elements
    }
    
    func removeElement(element: CEFPOSTDataElement) {
        cefObject.remove_element(cefObjectPtr, element.cefObjectPtr)
    }
    
    func addElement(element: CEFPOSTDataElement) {
        cefObject.add_element(cefObjectPtr, element.cefObjectPtr)
    }
    
    func removeElements() {
        cefObject.remove_elements(cefObjectPtr)
    }

}
