//
//  CEFColorModel.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Print job color mode values.
public enum CEFColorModel: Int32 {
    case unknown
    case gray
    case color
    case cmyk
    case cmy
    case kcmy

    /// CMY_K represents CMY+K.
    case cmyPlusK
    case black
    case grayscale
    case rgb
    case rgb16
    case rgba

    /// Used in samsung printer ppds.
    case colorModeColor

    /// Used in samsung printer ppds.
    case colorModeMonochrome

    /// Used in HP color printer ppds.
    case hpColorColor

    /// Used in HP color printer ppds.
    case hpColorBlack

    /// Used in foomatic ppds.
    case printoutModeNormal

    /// Used in foomatic ppds.
    case printoutModeNormalGray

    /// Used in canon printer ppds.
    case processColorModelCMYK

    /// Used in canon printer ppds.
    case processColorModelGrayscale

    /// Used in canon printer ppds
    case processColorModelRGB
}

extension CEFColorModel {
    static func fromCEF(value: cef_color_model_t) -> CEFColorModel {
        return CEFColorModel(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_color_model_t {
        return cef_color_model_t(rawValue: UInt32(rawValue))
    }
}

