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

public class CEFPOSTData: CEFProxy<cef_post_data_t> {
    
    public init?() {
        super.init(ptr: cef_post_data_create())
    }
    
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    public func getElementCount() -> size_t {
        return cefObject.get_element_count(cefObjectPtr)
    }
    
    public func getElements() -> [CEFPOSTDataElement] {
        var count:size_t = 0
        var cefElements = UnsafeMutablePointer<cef_post_data_element_t>()
        
        cefObject.get_elements(cefObjectPtr, &count, &cefElements)
        
        var elements = [CEFPOSTDataElement]()
        for i in 0..<count {
            let cefPDEPtr = cefElements.advancedBy(i)
            if let pde = CEFPOSTDataElement.fromCEF(cefPDEPtr) {
                elements.append(pde)
            }
        }
        
        return elements
    }
    
    public func removeElement(element: CEFPOSTDataElement) {
        cefObject.remove_element(cefObjectPtr, element.toCEF())
    }
    
    public func addElement(element: CEFPOSTDataElement) {
        cefObject.add_element(cefObjectPtr, element.toCEF())
    }
    
    public func removeElements() {
        cefObject.remove_elements(cefObjectPtr)
    }

}
