//
//  CEFImage+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_image.h.
//

import Foundation

extension cef_image_t: CEFObject {}

/// Container for a single image represented at different scale factors. All
/// image representations should be the same size in density independent pixel
/// (DIP) units. For example, if the image at scale factor 1.0 is 100x100 pixels
/// then the image at scale factor 2.0 should be 200x200 pixels -- both images
/// will display with a DIP size of 100x100 units. The methods of this class must
/// be called on the browser process UI thread.
public class CEFImage: CEFProxy<cef_image_t> {
    override init?(ptr: UnsafeMutablePointer<cef_image_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_image_t>) -> CEFImage? {
        return CEFImage(ptr: ptr)
    }
}

