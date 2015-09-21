//
//  ColorModel.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Print job color mode values.
public enum ColorModel: Int32 {
    case Unknown
    case Gray
    case Color
    case CMYK
    case CMY
    case KCMY

    /// CMY_K represents CMY+K.
    case CMYPlusK
    case Black
    case Grayscale
    case RGB
    case RGB16
    case RGBA

    /// Used in samsung printer ppds.
    case ColorModeColor

    /// Used in samsung printer ppds.
    case ColorModeMonochrome

    /// Used in HP color printer ppds.
    case HPColorColor

    /// Used in HP color printer ppds.
    case HPColorBlack

    /// Used in foomatic ppds.
    case PrintoutModeNormal

    /// Used in foomatic ppds.
    case PrintoutModeNormalGray

    /// Used in canon printer ppds.
    case ProcessColorModelCMYK

    /// Used in canon printer ppds.
    case ProcessColorModelGrayscale

    /// Used in canon printer ppds
    case ProcessColorModelRGB
}

extension ColorModel {
    static func fromCEF(value: cef_color_model_t) -> ColorModel {
        return ColorModel(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_color_model_t {
        return cef_color_model_t(rawValue: UInt32(rawValue))
    }
}

