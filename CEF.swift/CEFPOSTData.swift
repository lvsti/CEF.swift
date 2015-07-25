//
//  CEFPOSTData.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_post_data_t: CEFObject {
}

public class CEFPOSTData: CEFProxyBase<cef_post_data_t> {
    
    init?() {
        super.init(ptr: cef_post_data_create())
    }
    
    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    func getElementCount() -> size_t {
        return cefObject.get_element_count(cefObjectPtr)
    }
    
    func getElements() -> [CEFPOSTDataElement] {
        var count:size_t = 0
        let elementsPtr = UnsafeMutablePointer<UnsafeMutablePointer<cef_post_data_element_t>>()
        
        cefObject.get_elements(cefObjectPtr, &count, elementsPtr)
        
        var elements = [CEFPOSTDataElement]()
        for i in 0..<count {
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
