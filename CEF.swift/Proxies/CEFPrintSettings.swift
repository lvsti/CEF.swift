//
//  CEFPrintSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_print_settings_t: CEFObject {
}

///
// Class representing print settings.
///
public class CEFPrintSettings: CEFProxy<cef_print_settings_t> {
    ///
    // Create a new CefPrintSettings object.
    ///
    public init?() {
        super.init(ptr: cef_print_settings_create())
    }
    
    ///
    // Returns true if this object is valid. Do not call any other methods if this
    // function returns false.
    ///
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    ///
    // Returns true if the values of this object are read-only. Some APIs may
    // expose read-only objects.
    ///
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    ///
    // Returns a writable copy of this object.
    ///
    public func copy() -> CEFPrintSettings? {
        let cefSettings = cefObject.copy(cefObjectPtr)
        return CEFPrintSettings.fromCEF(cefSettings)
    }

    ///
    // Set the page orientation.
    ///
    public func setOrientation(landscape: Bool) {
        cefObject.set_orientation(cefObjectPtr, landscape ? 1 : 0)
    }

    ///
    // Returns true if the orientation is landscape.
    ///
    public func isLandscape() -> Bool {
        return cefObject.is_landscape(cefObjectPtr) != 0
    }

    ///
    // Set the printer printable area in device units.
    // Some platforms already provide flipped area. Set |landscape_needs_flip|
    // to false on those platforms to avoid double flipping.
    ///
    public func setPrinterPrintableArea(physicalSize: NSSize, printableArea: NSRect, landscapeNeedsFlip: Bool) {
        var cefSize = physicalSize.toCEF()
        var cefArea = printableArea.toCEF()
        cefObject.set_printer_printable_area(cefObjectPtr, &cefSize, &cefArea, landscapeNeedsFlip ? 1 : 0)
    }
    
    ///
    // Set the device name.
    ///
    public func setDeviceName(name: String?) {
        let cefStrPtr = name != nil ? CEFStringPtrCreateFromSwiftString(name!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_device_name(cefObjectPtr, cefStrPtr)
    }

    ///
    // Get the device name.
    ///
    public func getDeviceName() -> String? {
        let cefStrPtr = cefObject.get_device_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    ///
    // Set the DPI (dots per inch).
    ///
    public func setDPI(dpi: Int) {
        cefObject.set_dpi(cefObjectPtr, Int32(dpi))
    }

    ///
    // Get the DPI (dots per inch).
    ///
    public func getDPI() -> Int {
        return Int(cefObject.get_dpi(cefObjectPtr))
    }
    
    ///
    // Set the page ranges.
    ///
    public func setPageRanges(ranges: [CEFPageRange]) {
        let cefRangesPtr = UnsafeMutablePointer<cef_page_range_t>.alloc(ranges.count)
        defer { cefRangesPtr.dealloc(ranges.count) }
        
        for i in 0..<ranges.count {
            cefRangesPtr.advancedBy(i).memory = ranges[i].toCEF()
        }
        
        cefObject.set_page_ranges(cefObjectPtr, size_t(ranges.count), cefRangesPtr)
    }
    
    ///
    // Returns the number of page ranges that currently exist.
    ///
    public func getPageRangesCount() -> size_t {
        return cefObject.get_page_ranges_count(cefObjectPtr)
    }

    ///
    // Retrieve the page ranges.
    ///
    public func getPageRanges() -> [CEFPageRange] {
        var count: size_t = 0
        let cefRangesPtr: UnsafeMutablePointer<cef_page_range_t> = nil
        cefObject.get_page_ranges(cefObjectPtr, &count, cefRangesPtr)

        var ranges = [CEFPageRange]()
        for i in 0..<count {
            ranges.append(CEFPageRange.fromCEF(cefRangesPtr.advancedBy(i).memory))
        }
        
        return ranges
    }

    ///
    // Set whether only the selection will be printed.
    ///
    public func setSelectionOnly(selectionOnly: Bool) {
        cefObject.set_selection_only(cefObjectPtr, selectionOnly ? 1 : 0)
    }

    ///
    // Returns true if only the selection will be printed.
    ///
    public func isSelectionOnly() -> Bool {
        return cefObject.is_selection_only(cefObjectPtr) != 0
    }

    ///
    // Set whether pages will be collated.
    ///
    public func setCollate(collate: Bool) {
        cefObject.set_collate(cefObjectPtr, collate ? 1 : 0)
    }

    ///
    // Returns true if pages will be collated.
    ///
    public func willCollate() -> Bool {
        return cefObject.will_collate(cefObjectPtr) != 0
    }

    ///
    // Set the color model.
    ///
    public func setColorModel(model: CEFColorModel) {
        cefObject.set_color_model(cefObjectPtr, model.toCEF())
    }
    
    ///
    // Get the color model.
    ///
    public func getColorModel() -> CEFColorModel {
        let cefModel = cefObject.get_color_model(cefObjectPtr)
        return CEFColorModel.fromCEF(cefModel)
    }

    ///
    // Set the number of copies.
    ///
    public func setCopies(number: Int) {
        cefObject.set_copies(cefObjectPtr, Int32(number))
    }
    
    ///
    // Get the number of copies.
    ///
    public func getCopies() -> Int {
        return Int(cefObject.get_copies(cefObjectPtr))
    }

    ///
    // Set the duplex mode.
    ///
    public func setDuplexMode(mode: CEFDuplexMode) {
        cefObject.set_duplex_mode(cefObjectPtr, mode.toCEF())
    }

    ///
    // Get the duplex mode.
    ///
    public func getDuplexMode() -> CEFDuplexMode {
        let cefMode = cefObject.get_duplex_mode(cefObjectPtr)
        return CEFDuplexMode.fromCEF(cefMode)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFPrintSettings? {
        return CEFPrintSettings(ptr: ptr)
    }
}

