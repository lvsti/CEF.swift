//
//  CEFImage.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 04..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

public typealias CEFImageResult = (binary: CEFBinaryValue, width: Int, height: Int)

public extension CEFImage {

    /// Create a new CefImage. It will initially be empty. Use the Add*() methods
    /// to add representations at different scale factors.
    /// CEF name: `Create`
    public convenience init?(){
        self.init(ptr: cef_image_create())
    }
    
    /// Returns true if this Image is empty.
    /// CEF name: `IsEmpty`
    public var isEmpty: Bool {
        return cefObject.is_empty(cefObjectPtr) != 0
    }
    
    /// Returns true if this Image and |that| Image share the same underlying
    /// storage. Will also return true if both images are empty.
    /// CEF name: `IsSame`
    public func isSameAs(_ other: CEFImage) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Add a bitmap image representation for |scale_factor|. Only 32-bit RGBA/BGRA
    /// formats are supported. |pixel_width| and |pixel_height| are the bitmap
    /// representation size in pixel coordinates. |pixel_data| is the array of
    /// pixel data and should be |pixel_width| x |pixel_height| x 4 bytes in size.
    /// |color_type| and |alpha_type| values specify the pixel format.
    /// CEF name: `AddBitmap`
    public func addBitmap(scaleFactor: Float,
                          pixelWidth: Int,
                          pixelHeight: Int,
                          colorType: CEFColorType,
                          alphaType: CEFAlphaType,
                          data: NSData) -> Bool {
        return cefObject.add_bitmap(cefObjectPtr,
                                    scaleFactor,
                                    Int32(pixelWidth),
                                    Int32(pixelHeight),
                                    colorType.toCEF(),
                                    alphaType.toCEF(),
                                    data.bytes,
                                    data.length) != 0
    }
    
    /// Add a PNG image representation for |scale_factor|. |png_data| is the image
    /// data of size |png_data_size|. Any alpha transparency in the PNG data will
    /// be maintained.
    /// CEF name: `AddPNG`
    public func addPNG(scaleFactor: Float, data: NSData) -> Bool {
        return cefObject.add_png(cefObjectPtr,
                                 scaleFactor,
                                 data.bytes,
                                 data.length) != 0
    }
    
    // Create a JPEG image representation for |scale_factor|. |jpeg_data| is the
    // image data of size |jpeg_data_size|. The JPEG format does not support
    // transparency so the alpha byte will be set to 0xFF for all pixels.
    /// CEF name: `AddJPEG`
    public func addJPEG(scaleFactor: Float, data: NSData) -> Bool {
        return cefObject.add_jpeg(cefObjectPtr,
                                  scaleFactor,
                                  data.bytes,
                                  data.length) != 0
    }
    
    /// Returns the image width in density independent pixel (DIP) units.
    /// CEF name: `GetWidth`
    public var width: Int {
        return cefObject.get_width(cefObjectPtr)
    }
    
    /// Returns the image height in density independent pixel (DIP) units.
    /// CEF name: `GetHeight`
    public var height: Int {
        return cefObject.get_height(cefObjectPtr)
    }
    
    /// Returns true if this image contains a representation for |scale_factor|.
    /// CEF name: `HasRepresentation`
    public func hasRepresentationForScaleFactor(scaleFactor: Float) -> Bool {
        return cefObject.has_representation(cefObjectPtr, scaleFactor) != 0
    }
    
    /// Removes the representation for |scale_factor|. Returns true on success.
    /// CEF name: `RemoveRepresentation`
    public func removeRepresentationForScaleFactor(scaleFactor: Float) -> Bool {
        return cefObject.remove_representation(cefObjectPtr, scaleFactor) != 0
    }
    
    /// Returns information for the representation that most closely matches
    /// |scale_factor|. |actual_scale_factor| is the actual scale factor for the
    /// representation. |pixel_width| and |pixel_height| are the representation
    /// size in pixel coordinates. Returns true on success.
    /// CEF name: `GetRepresentationInfo`
    public func representationInfoForScaleFactor(scaleFactor: Float) -> (scaleFactor: Float, width: Int, height: Int)? {
        var actualSF: Float = 0
        var width: Int32 = 0
        var height: Int32 = 0
        
        let success = cefObject.get_representation_info(cefObjectPtr, scaleFactor, &actualSF, &width, &height) != 0
        guard success else {
            return nil
        }
        
        return (scaleFactor: actualSF, width: Int(width), height: Int(height))
    }
    
    /// Returns the bitmap representation that most closely matches |scale_factor|.
    /// Only 32-bit RGBA/BGRA formats are supported. |color_type| and |alpha_type|
    /// values specify the desired output pixel format. |pixel_width| and
    /// |pixel_height| are the output representation size in pixel coordinates.
    /// Returns a CefBinaryValue containing the pixel data on success or NULL on
    /// failure.
    /// CEF name: `GetAsBitmap`
    public func getAsBitmap(scaleFactor: Float, colorType: CEFColorType, alphaType: CEFAlphaType) -> CEFImageResult? {
        var width: Int32 = 0
        var height: Int32 = 0
        let cefBinary = cefObject.get_as_bitmap(cefObjectPtr,
                                                scaleFactor,
                                                colorType.toCEF(),
                                                alphaType.toCEF(),
                                                &width,
                                                &height)
        guard cefBinary != nil else {
            return nil
        }
        
        return (binary: CEFBinaryValue.fromCEF(cefBinary)!, width: Int(width), height: Int(height))
    }
    
    // Returns the PNG representation that most closely matches |scale_factor|. If
    // |with_transparency| is true any alpha transparency in the image will be
    // represented in the resulting PNG data. |pixel_width| and |pixel_height| are
    // the output representation size in pixel coordinates. Returns a
    // CefBinaryValue containing the PNG image data on success or NULL on failure.
    /// CEF name: `GetAsPNG`
    public func getAsPNG(scaleFactor: Float, transparency: Bool) -> CEFImageResult? {
        var width: Int32 = 0
        var height: Int32 = 0
        let cefBinary = cefObject.get_as_png(cefObjectPtr,
                                             scaleFactor,
                                             transparency ? 1 : 0,
                                             &width,
                                             &height)
        guard cefBinary != nil else {
            return nil
        }
        
        return (binary: CEFBinaryValue.fromCEF(cefBinary)!, width: Int(width), height: Int(height))
    }
    
    /// Returns the JPEG representation that most closely matches |scale_factor|.
    /// |quality| determines the compression level with 0 == lowest and 100 ==
    /// highest. The JPEG format does not support alpha transparency and the alpha
    /// channel, if any, will be discarded. |pixel_width| and |pixel_height| are
    /// the output representation size in pixel coordinates. Returns a
    /// CefBinaryValue containing the JPEG image data on success or NULL on
    /// failure.
    /// CEF name: `GetAsJPEG`
    public func getAsJPEG(scaleFactor: Float, quality: Int) -> CEFImageResult? {
        var width: Int32 = 0
        var height: Int32 = 0
        let cefBinary = cefObject.get_as_jpeg(cefObjectPtr,
                                              scaleFactor,
                                              Int32(quality),
                                              &width,
                                              &height)
        guard cefBinary != nil else {
            return nil
        }
        
        return (binary: CEFBinaryValue.fromCEF(cefBinary)!, width: Int(width), height: Int(height))
    }

}

