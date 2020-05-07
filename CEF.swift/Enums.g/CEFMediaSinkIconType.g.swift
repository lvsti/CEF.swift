//
//  CEFMediaSinkIconType.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Icon types for a MediaSink object. Should be kept in sync with Chromium's
/// media_router::SinkIconType type.
/// CEF name: `cef_media_sink_icon_type_t`.
public enum CEFMediaSinkIconType: Int32 {
    /// CEF name: `CEF_MSIT_CAST`.
    case cast
    /// CEF name: `CEF_MSIT_CAST_AUDIO_GROUP`.
    case castAudioGroup
    /// CEF name: `CEF_MSIT_CAST_AUDIO`.
    case castAudio
    /// CEF name: `CEF_MSIT_MEETING`.
    case meeting
    /// CEF name: `CEF_MSIT_HANGOUT`.
    case hangout
    /// CEF name: `CEF_MSIT_EDUCATION`.
    case education
    /// CEF name: `CEF_MSIT_WIRED_DISPLAY`.
    case wiredDisplay
    /// CEF name: `CEF_MSIT_GENERIC`.
    case generic

    ///
    // The total number of values.
    ///
    /// CEF name: `CEF_MSIT_TOTAL_COUNT`.
    case totalCount
}

extension CEFMediaSinkIconType {
    static func fromCEF(_ value: cef_media_sink_icon_type_t) -> CEFMediaSinkIconType {
        return CEFMediaSinkIconType(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_media_sink_icon_type_t {
        return cef_media_sink_icon_type_t(rawValue: UInt32(rawValue))
    }
}

