//
//  CEFPrintSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFPrintSettings {
    
    /// Create a new CefPrintSettings object.
    public convenience init?() {
        self.init(ptr: cef_print_settings_create())
    }
    
    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns a writable copy of this object.
    public func copy() -> CEFPrintSettings? {
        let cefSettings = cefObject.copy(cefObjectPtr)
        return CEFPrintSettings.fromCEF(cefSettings)
    }

    /// Page orientation.
    public var orientation: CEFPageOrientation {
        get { return cefObject.is_landscape(cefObjectPtr) != 0 ? .Landscape : .Portrait }
        set { cefObject.set_orientation(cefObjectPtr, newValue == .Landscape ? 1 : 0) }
    }

    /// Set the printer printable area in device units.
    /// Some platforms already provide flipped area. Set |landscape_needs_flip|
    /// to false on those platforms to avoid double flipping.
    public func setPrinterPrintableArea(physicalSize: NSSize, printableArea: NSRect, landscapeNeedsFlip: Bool) {
        var cefSize = physicalSize.toCEF()
        var cefArea = printableArea.toCEF()
        cefObject.set_printer_printable_area(cefObjectPtr, &cefSize, &cefArea, landscapeNeedsFlip ? 1 : 0)
    }
    
    /// Device name.
    public var deviceName: String? {
        get {
            let cefStrPtr = cefObject.get_device_name(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr) }
            return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.pointee) : nil
        }
        set {
            let cefStrPtr = newValue != nil ? CEFStringPtrCreateFromSwiftString(newValue!) : nil
            defer { CEFStringPtrRelease(cefStrPtr) }
            cefObject.set_device_name(cefObjectPtr, cefStrPtr)
        }
    }
    
    /// DPI (dots per inch).
    public var dpi: Int {
        get { return Int(cefObject.get_dpi(cefObjectPtr)) }
        set { cefObject.set_dpi(cefObjectPtr, Int32(newValue)) }
    }

    /// Set the page ranges.
    private func setPageRanges(ranges: [CEFRange]) {
        let cefRangesPtr = UnsafeMutablePointer<cef_range_t>.alloc(ranges.count)
        defer { cefRangesPtr.dealloc(ranges.count) }
        
        for i in 0..<ranges.count {
            cefRangesPtr.advancedBy(i).pointee = ranges[i].toCEF()
        }
        
        cefObject.set_page_ranges(cefObjectPtr, size_t(ranges.count), cefRangesPtr)
    }
    
    /// Returns the number of page ranges that currently exist.
    public func pageRangesCount() -> size_t {
        return cefObject.get_page_ranges_count(cefObjectPtr)
    }

    /// Retrieve the page ranges.
    private func getPageRanges() -> [CEFRange] {
        var count: size_t = 0
        let cefRangesPtr: UnsafeMutablePointer<cef_range_t> = nil
        cefObject.get_page_ranges(cefObjectPtr, &count, cefRangesPtr)

        var ranges = [CEFRange]()
        for i in 0..<count {
            ranges.append(CEFRange.fromCEF(cefRangesPtr.advancedBy(i).pointee))
        }
        
        return ranges
    }
    
    /// Page ranges.
    public var pageRanges: [CEFRange] {
        get { return getPageRanges() }
        set { setPageRanges(newValue) }
    }

    /// Whether only the selection will be printed.
    public var isSelectionOnly: Bool {
        get { return cefObject.is_selection_only(cefObjectPtr) != 0 }
        set { cefObject.set_selection_only(cefObjectPtr, newValue ? 1 : 0) }
    }

    /// Whether pages will be collated.
    public var isCollationEnabled: Bool {
        get { return cefObject.will_collate(cefObjectPtr) != 0 }
        set { cefObject.set_collate(cefObjectPtr, newValue ? 1 : 0) }
    }
    
    /// Color model.
    public var colorModel: CEFColorModel {
        get {
            let cefModel = cefObject.get_color_model(cefObjectPtr)
            return CEFColorModel.fromCEF(cefModel)
        }
        set { cefObject.set_color_model(cefObjectPtr, newValue.toCEF()) }
    }

    /// The number of copies.
    public var copyCount: Int {
        get { return Int(cefObject.get_copies(cefObjectPtr)) }
        set { cefObject.set_copies(cefObjectPtr, Int32(newValue)) }
    }

    /// Duplex mode.
    public var duplexMode: CEFDuplexMode {
        get {
            let cefMode = cefObject.get_duplex_mode(cefObjectPtr)
            return CEFDuplexMode.fromCEF(cefMode)
        }
        set { cefObject.set_duplex_mode(cefObjectPtr, newValue.toCEF()) }
    }
    
}

