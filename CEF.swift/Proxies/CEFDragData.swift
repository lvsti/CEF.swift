//
//  CEFDragData.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_drag_data_t: CEFObject {
}

/// Class used to represent drag data. The methods of this class may be called
/// on any thread.
public class CEFDragData: CEFProxy<cef_drag_data_t> {

    /// Create a new CefDragData object.
    public init?() {
        super.init(ptr: cef_drag_data_create())
    }
    
    /// Returns a copy of the current object.
    public func clone() -> CEFDragData? {
        let cefData = cefObject.clone(cefObjectPtr)
        return CEFDragData.fromCEF(cefData)
    }

    /// Returns true if this object is read-only.
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns true if the drag data is a link.
    public func isLink() -> Bool {
        return cefObject.is_link(cefObjectPtr) != 0
    }

    /// Returns true if the drag data is a text or html fragment.
    public func isFragment() -> Bool {
        return cefObject.is_fragment(cefObjectPtr) != 0
    }
    
    /// Returns true if the drag data is a file.
    public func isFile() -> Bool {
        return cefObject.is_file(cefObjectPtr) != 0
    }

    /// Return the link URL that is being dragged.
    public func getLinkURL() -> NSURL? {
        let cefStrPtr = cefObject.get_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))! : nil
    }

    /// Return the title associated with the link being dragged.
    public func getLinkTitle() -> String? {
        let cefStrPtr = cefObject.get_link_title(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    /// Return the metadata, if any, associated with the link being dragged.
    public func getLinkMetadata() -> String? {
        let cefStrPtr = cefObject.get_link_metadata(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    /// Return the plain text fragment that is being dragged.
    public func getFragmentText() -> String {
        let cefStrPtr = cefObject.get_fragment_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Return the text/html fragment that is being dragged.
    public func getFragmentHTML() -> String {
        let cefStrPtr = cefObject.get_fragment_html(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Return the base URL that the fragment came from. This value is used for
    /// resolving relative URLs and may be empty.
    public func getFragmentBaseURL() -> NSURL? {
        let cefStrPtr = cefObject.get_fragment_base_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))
    }
    
    /// Return the name of the file being dragged out of the browser window.
    public func getFileName() -> String {
        let cefStrPtr = cefObject.get_file_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Write the contents of the file being dragged out of the web view into
    /// |writer|. Returns the number of bytes sent to |writer|. If |writer| is
    /// NULL this method will return the size of the file contents in bytes.
    /// Call GetFileName() to get a suggested name for the file.
    public func getFileContents(writer: CEFStreamWriter? = nil) -> size_t {
        let cefWriter: UnsafeMutablePointer<cef_stream_writer_t> =
            writer != nil ? writer!.toCEF() : nil
        return cefObject.get_file_contents(cefObjectPtr, cefWriter)
    }
    
    /// Retrieve the list of file names that are being dragged into the browser
    /// window.
    public func getFileNames() -> [String]? {
        let cefList = cef_string_list_alloc()
        defer { CEFStringListRelease(cefList) }
        let retval = cefObject.get_file_names(cefObjectPtr, cefList)
        return retval != 0 ? CEFStringListToSwiftArray(cefList) : nil
    }
    
    /// Set the link URL that is being dragged.
    public func setLinkURL(url: NSURL?)  {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_url(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the title associated with the link being dragged.
    public func setLinkTitle(title: String?)  {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            title != nil ? CEFStringPtrCreateFromSwiftString(title!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_title(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the metadata associated with the link being dragged.
    public func setLinkMetadata(metadata: String?)  {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            metadata != nil ? CEFStringPtrCreateFromSwiftString(metadata!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_metadata(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the plain text fragment that is being dragged.
    public func setFragmentText(text: String?)  {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            text != nil ? CEFStringPtrCreateFromSwiftString(text!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_fragment_text(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the text/html fragment that is being dragged.
    public func setFragmentHTML(html: String?)  {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            html != nil ? CEFStringPtrCreateFromSwiftString(html!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_fragment_html(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the base URL that the fragment came from.
    public func setFragmentBaseURL(url: NSURL?)  {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_metadata(cefObjectPtr, cefStrPtr)
    }
    
    /// Reset the file contents. You should do this before calling
    /// CefBrowserHost::DragTargetDragEnter as the web view does not allow us to
    /// drag in this kind of data.
    public func resetFileContents() {
        cefObject.reset_file_contents(cefObjectPtr)
    }

    /// Add a file that is being dragged into the webview.
    public func addFile(path: String, displayName: String? = nil)  {
        let cefPathPtr = CEFStringPtrCreateFromSwiftString(path)
        let cefNamePtr: UnsafeMutablePointer<cef_string_t> =
            displayName != nil ? CEFStringPtrCreateFromSwiftString(displayName!) : nil
        defer {
            CEFStringPtrRelease(cefPathPtr)
            CEFStringPtrRelease(cefNamePtr)
        }
        cefObject.add_file(cefObjectPtr, cefPathPtr, cefNamePtr)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDragData? {
        return CEFDragData(ptr: ptr)
    }
}
