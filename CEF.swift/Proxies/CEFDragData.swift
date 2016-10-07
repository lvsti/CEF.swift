//
//  CEFDragData.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDragData {

    /// Create a new CefDragData object.
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_drag_data_create())
    }
    
    /// Returns a copy of the current object.
    /// CEF name: `Clone`
    public func clone() -> CEFDragData? {
        let cefData = cefObject.clone(cefObjectPtr)
        return CEFDragData.fromCEF(cefData)
    }

    /// Returns true if this object is read-only.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns true if the drag data is a link.
    /// CEF name: `IsLink`
    public var isLink: Bool {
        return cefObject.is_link(cefObjectPtr) != 0
    }

    /// Returns true if the drag data is a text or html fragment.
    /// CEF name: `IsFragment`
    public var isFragment: Bool {
        return cefObject.is_fragment(cefObjectPtr) != 0
    }
    
    /// Returns true if the drag data is a file.
    /// CEF name: `IsFile`
    public var isFile: Bool {
        return cefObject.is_file(cefObjectPtr) != 0
    }

    /// Return the link URL that is being dragged.
    /// CEF name: `GetLinkURL`
    public var linkURL: NSURL? {
        let cefStrPtr = cefObject.get_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? NSURL(string: CEFStringToSwiftString(cefStrPtr!.pointee))! : nil
    }

    /// Return the title associated with the link being dragged.
    /// CEF name: `GetLinkTitle`
    public var linkTitle: String? {
        let cefStrPtr = cefObject.get_link_title(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
    }
    
    /// Return the metadata, if any, associated with the link being dragged.
    /// CEF name: `GetLinkMetadata`
    public var linkMetadata: String? {
        let cefStrPtr = cefObject.get_link_metadata(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
    }
    
    /// Return the plain text fragment that is being dragged.
    /// CEF name: `GetFragmentText`
    public var fragmentText: String {
        let cefStrPtr = cefObject.get_fragment_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Return the text/html fragment that is being dragged.
    /// CEF name: `GetFragmentHtml`
    public var fragmentHTML: String {
        let cefStrPtr = cefObject.get_fragment_html(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Return the base URL that the fragment came from. This value is used for
    /// resolving relative URLs and may be empty.
    /// CEF name: `GetFragmentBaseURL`
    public var fragmentBaseURL: NSURL? {
        let cefStrPtr = cefObject.get_fragment_base_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr!.pointee))
    }
    
    /// Return the name of the file being dragged out of the browser window.
    /// CEF name: `GetFileName`
    public var fileName: String {
        let cefStrPtr = cefObject.get_file_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Write the contents of the file being dragged out of the web view into
    /// |writer|. Returns the number of bytes sent to |writer|. If |writer| is
    /// NULL this method will return the size of the file contents in bytes.
    /// Call GetFileName() to get a suggested name for the file.
    /// CEF name: `GetFileContents`
    public func getFileContents(writer: CEFStreamWriter? = nil) -> size_t {
        let cefWriter = writer?.toCEF()
        return cefObject.get_file_contents(cefObjectPtr, cefWriter)
    }
    
    /// Retrieve the list of file names that are being dragged into the browser
    /// window.
    /// CEF name: `GetFileNames`
    public var fileNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { CEFStringListRelease(cefList) }
        _ = cefObject.get_file_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }
    
    /// Set the link URL that is being dragged.
    /// CEF name: `SetLinkURL`
    public func setLinkURL(url: NSURL?)  {
        let cefStrPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_url(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the title associated with the link being dragged.
    /// CEF name: `SetLinkTitle`
    public func setLinkTitle(title: String?)  {
        let cefStrPtr = title != nil ? CEFStringPtrCreateFromSwiftString(title!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_title(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the metadata associated with the link being dragged.
    /// CEF name: `SetLinkMetadata`
    public func setLinkMetadata(metadata: String?)  {
        let cefStrPtr = metadata != nil ? CEFStringPtrCreateFromSwiftString(metadata!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_metadata(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the plain text fragment that is being dragged.
    /// CEF name: `SetFragmentText`
    public func setFragmentText(text: String?)  {
        let cefStrPtr = text != nil ? CEFStringPtrCreateFromSwiftString(text!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_fragment_text(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the text/html fragment that is being dragged.
    /// CEF name: `SetFragmentHtml`
    public func setFragmentHTML(html: String?)  {
        let cefStrPtr = html != nil ? CEFStringPtrCreateFromSwiftString(html!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_fragment_html(cefObjectPtr, cefStrPtr)
    }
    
    /// Set the base URL that the fragment came from.
    /// CEF name: `SetFragmentBaseURL`
    public func setFragmentBaseURL(url: NSURL?)  {
        let cefStrPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_link_metadata(cefObjectPtr, cefStrPtr)
    }
    
    /// Reset the file contents. You should do this before calling
    /// CefBrowserHost::DragTargetDragEnter as the web view does not allow us to
    /// drag in this kind of data.
    /// CEF name: `ResetFileContents`
    public func resetFileContents() {
        cefObject.reset_file_contents(cefObjectPtr)
    }

    /// Add a file that is being dragged into the webview.
    /// CEF name: `AddFile`
    public func addFileWithPath(path: String, displayName: String? = nil)  {
        let cefPathPtr = CEFStringPtrCreateFromSwiftString(path)
        let cefNamePtr = displayName != nil ? CEFStringPtrCreateFromSwiftString(displayName!) : nil
        defer {
            CEFStringPtrRelease(cefPathPtr)
            CEFStringPtrRelease(cefNamePtr)
        }
        cefObject.add_file(cefObjectPtr, cefPathPtr, cefNamePtr)
    }

}
