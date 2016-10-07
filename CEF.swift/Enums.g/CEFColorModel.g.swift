//
//  CEFColorModel.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Print job color mode values.
/// CEF name: `cef_color_model_t`.
public enum CEFColorModel: Int32 {
    /// CEF name: `COLOR_MODEL_UNKNOWN`.
    case unknown
    /// CEF name: `COLOR_MODEL_GRAY`.
    case gray
    /// CEF name: `COLOR_MODEL_COLOR`.
    case color
    /// CEF name: `COLOR_MODEL_CMYK`.
    case cmyk
    /// CEF name: `COLOR_MODEL_CMY`.
    case cmy
    /// CEF name: `COLOR_MODEL_KCMY`.
    case kcmy

    /// CMY_K represents CMY+K.
    /// CEF name: `COLOR_MODEL_CMY_K`.
    case cmyPlusK
    /// CEF name: `COLOR_MODEL_BLACK`.
    case black
    /// CEF name: `COLOR_MODEL_GRAYSCALE`.
    case grayscale
    /// CEF name: `COLOR_MODEL_RGB`.
    case rgb
    /// CEF name: `COLOR_MODEL_RGB16`.
    case rgb16
    /// CEF name: `COLOR_MODEL_RGBA`.
    case rgba

    /// Used in samsung printer ppds.
    /// CEF name: `COLOR_MODEL_COLORMODE_COLOR`.
    case colorModeColor

    /// Used in samsung printer ppds.
    /// CEF name: `COLOR_MODEL_COLORMODE_MONOCHROME`.
    case colorModeMonochrome

    /// Used in HP color printer ppds.
    /// CEF name: `COLOR_MODEL_HP_COLOR_COLOR`.
    case hpColorColor

    /// Used in HP color printer ppds.
    /// CEF name: `COLOR_MODEL_HP_COLOR_BLACK`.
    case hpColorBlack

    /// Used in foomatic ppds.
    /// CEF name: `COLOR_MODEL_PRINTOUTMODE_NORMAL`.
    case printoutModeNormal

    /// Used in foomatic ppds.
    /// CEF name: `COLOR_MODEL_PRINTOUTMODE_NORMAL_GRAY`.
    case printoutModeNormalGray

    /// Used in canon printer ppds.
    /// CEF name: `COLOR_MODEL_PROCESSCOLORMODEL_CMYK`.
    case processColorModelCMYK

    /// Used in canon printer ppds.
    /// CEF name: `COLOR_MODEL_PROCESSCOLORMODEL_GREYSCALE`.
    case processColorModelGrayscale

    /// Used in canon printer ppds
    /// CEF name: `COLOR_MODEL_PROCESSCOLORMODEL_RGB`.
    case processColorModelRGB
}

extension CEFColorModel {
    static func fromCEF(_ value: cef_color_model_t) -> CEFColorModel {
        return CEFColorModel(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_color_model_t {
        return cef_color_model_t(rawValue: UInt32(rawValue))
    }
}

