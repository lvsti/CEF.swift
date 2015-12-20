//
//  CEFPOSTData.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

public extension CEFPOSTData {
    
    /// Create a new CefPostData object.
    public convenience init?() {
        self.init(ptr: cef_post_data_create())
    }
    
    /// Returns true if this object is read-only.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns true if the underlying POST data includes elements that are not
    /// represented by this CefPostData object (for example, multi-part file upload
    /// data). Modifying CefPostData objects with excluded elements may result in
    /// the request failing.
    public var hasExcludedElements: Bool {
        return cefObject.has_excluded_elements(cefObjectPtr) != 0
    }
    
    /// Returns the number of existing post data elements.
    public var elementCount: Int {
        return cefObject.get_element_count(cefObjectPtr)
    }
    
    /// Retrieve the post data elements.
    public var elements: [CEFPOSTDataElement] {
        var count: size_t = 0
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
    
    /// Remove the specified post data element.  Returns true if the removal
    /// succeeds.
    public func removeElement(element: CEFPOSTDataElement) -> Bool {
        return cefObject.remove_element(cefObjectPtr, element.toCEF()) != 0
    }
    
    /// Add the specified post data element.  Returns true if the add succeeds.
    public func addElement(element: CEFPOSTDataElement) -> Bool {
        return cefObject.add_element(cefObjectPtr, element.toCEF()) != 0
    }
    
    /// Remove all existing post data elements.
    public func removeAllElements() {
        cefObject.remove_elements(cefObjectPtr)
    }

}
