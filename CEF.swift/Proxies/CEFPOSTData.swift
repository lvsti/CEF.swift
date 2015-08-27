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

/// Class used to represent post data for a web request. The methods of this
/// class may be called on any thread.
public class CEFPOSTData: CEFProxy<cef_post_data_t> {
    
    /// Create a new CefPostData object.
    public init?() {
        super.init(ptr: cef_post_data_create())
    }
    
    /// Returns true if this object is read-only.
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns the number of existing post data elements.
    public func getElementCount() -> size_t {
        return cefObject.get_element_count(cefObjectPtr)
    }
    
    /// Retrieve the post data elements.
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
    
    /// Remove the specified post data element.  Returns true if the removal
    /// succeeds.
    public func removeElement(element: CEFPOSTDataElement) {
        cefObject.remove_element(cefObjectPtr, element.toCEF())
    }
    
    /// Add the specified post data element.  Returns true if the add succeeds.
    public func addElement(element: CEFPOSTDataElement) {
        cefObject.add_element(cefObjectPtr, element.toCEF())
    }
    
    /// Remove all existing post data elements.
    public func removeElements() {
        cefObject.remove_elements(cefObjectPtr)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFPOSTData? {
        return CEFPOSTData(ptr: ptr)
    }
}
