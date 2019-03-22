//
//  CEFChannelLayout.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Enumerates the various representations of the ordering of audio channels.
/// Logged to UMA, so never reuse a value, always add new/greater ones!
/// See media\base\channel_layout.h
/// CEF name: `cef_channel_layout_t`.
public enum CEFChannelLayout: Int32 {
    /// CEF name: `CEF_CHANNEL_LAYOUT_NONE`.
    case none = 0
    /// CEF name: `CEF_CHANNEL_LAYOUT_UNSUPPORTED`.
    case unsupported = 1

    /// Front C
    /// CEF name: `CEF_CHANNEL_LAYOUT_MONO`.
    case mono = 2

    /// Front L, Front R
    /// CEF name: `CEF_CHANNEL_LAYOUT_STEREO`.
    case stereo = 3

    /// Front L, Front R, Back C
    /// CEF name: `CEF_CHANNEL_LAYOUT_2_1`.
    case layout_2_1 = 4

    /// Front L, Front R, Front C
    /// CEF name: `CEF_CHANNEL_LAYOUT_SURROUND`.
    case surround = 5

    /// Front L, Front R, Front C, Back C
    /// CEF name: `CEF_CHANNEL_LAYOUT_4_0`.
    case layout_4_0 = 6

    /// Front L, Front R, Side L, Side R
    /// CEF name: `CEF_CHANNEL_LAYOUT_2_2`.
    case layout_2_2 = 7

    /// Front L, Front R, Back L, Back R
    /// CEF name: `CEF_CHANNEL_LAYOUT_QUAD`.
    case quad = 8

    /// Front L, Front R, Front C, Side L, Side R
    /// CEF name: `CEF_CHANNEL_LAYOUT_5_0`.
    case layout_5_0 = 9

    /// Front L, Front R, Front C, LFE, Side L, Side R
    /// CEF name: `CEF_CHANNEL_LAYOUT_5_1`.
    case layout_5_1 = 10

    /// Front L, Front R, Front C, Back L, Back R
    /// CEF name: `CEF_CHANNEL_LAYOUT_5_0_BACK`.
    case layout_5_0_back = 11

    /// Front L, Front R, Front C, LFE, Back L, Back R
    /// CEF name: `CEF_CHANNEL_LAYOUT_5_1_BACK`.
    case layout_5_1_back = 12

    /// Front L, Front R, Front C, Side L, Side R, Back L, Back R
    /// CEF name: `CEF_CHANNEL_LAYOUT_7_0`.
    case layout_7_0 = 13

    /// Front L, Front R, Front C, LFE, Side L, Side R, Back L, Back R
    /// CEF name: `CEF_CHANNEL_LAYOUT_7_1`.
    case layout_7_1 = 14

    /// Front L, Front R, Front C, LFE, Side L, Side R, Front LofC, Front RofC
    /// CEF name: `CEF_CHANNEL_LAYOUT_7_1_WIDE`.
    case layout_7_1_wide = 15

    /// Stereo L, Stereo R
    /// CEF name: `CEF_CHANNEL_LAYOUT_STEREO_DOWNMIX`.
    case stereoDownmix = 16

    /// Stereo L, Stereo R, LFE
    /// CEF name: `CEF_CHANNEL_LAYOUT_2POINT1`.
    case layout_2point1 = 17

    /// Stereo L, Stereo R, Front C, LFE
    /// CEF name: `CEF_CHANNEL_LAYOUT_3_1`.
    case layout_3_1 = 18

    /// Stereo L, Stereo R, Front C, Rear C, LFE
    /// CEF name: `CEF_CHANNEL_LAYOUT_4_1`.
    case layout_4_1 = 19

    /// Stereo L, Stereo R, Front C, Side L, Side R, Back C
    /// CEF name: `CEF_CHANNEL_LAYOUT_6_0`.
    case layout_6_0 = 20

    /// Stereo L, Stereo R, Side L, Side R, Front LofC, Front RofC
    /// CEF name: `CEF_CHANNEL_LAYOUT_6_0_FRONT`.
    case layout_6_0_front = 21

    /// Stereo L, Stereo R, Front C, Rear L, Rear R, Rear C
    /// CEF name: `CEF_CHANNEL_LAYOUT_HEXAGONAL`.
    case hexagonal = 22

    /// Stereo L, Stereo R, Front C, LFE, Side L, Side R, Rear Center
    /// CEF name: `CEF_CHANNEL_LAYOUT_6_1`.
    case layout_6_1 = 23

    /// Stereo L, Stereo R, Front C, LFE, Back L, Back R, Rear Center
    /// CEF name: `CEF_CHANNEL_LAYOUT_6_1_BACK`.
    case layout_6_1_back = 24

    /// Stereo L, Stereo R, Side L, Side R, Front LofC, Front RofC, LFE
    /// CEF name: `CEF_CHANNEL_LAYOUT_6_1_FRONT`.
    case layout_6_1_front = 25

    /// Front L, Front R, Front C, Side L, Side R, Front LofC, Front RofC
    /// CEF name: `CEF_CHANNEL_LAYOUT_7_0_FRONT`.
    case layout_7_0_front = 26

    /// Front L, Front R, Front C, LFE, Back L, Back R, Front LofC, Front RofC
    /// CEF name: `CEF_CHANNEL_LAYOUT_7_1_WIDE_BACK`.
    case layout_7_1_wideBack = 27

    /// Front L, Front R, Front C, Side L, Side R, Rear L, Back R, Back C.
    /// CEF name: `CEF_CHANNEL_LAYOUT_OCTAGONAL`.
    case octagonal = 28

    /// Channels are not explicitly mapped to speakers.
    /// CEF name: `CEF_CHANNEL_LAYOUT_DISCRETE`.
    case discrete = 29

    /// Front L, Front R, Front C. Front C contains the keyboard mic audio. This
    /// layout is only intended for input for WebRTC. The Front C channel
    /// is stripped away in the WebRTC audio input pipeline and never seen outside
    /// of that.
    /// CEF name: `CEF_CHANNEL_LAYOUT_STEREO_AND_KEYBOARD_MIC`.
    case stereoAndKeyboardMic = 30

    /// Front L, Front R, Side L, Side R, LFE
    /// CEF name: `CEF_CHANNEL_LAYOUT_4_1_QUAD_SIDE`.
    case layout_4_1_quadSide = 31

    /// Actual channel layout is specified in the bitstream and the actual channel
    /// count is unknown at Chromium media pipeline level (useful for audio
    /// pass-through mode).
    /// CEF name: `CEF_CHANNEL_LAYOUT_BITSTREAM`.
    case bitstream = 32

    /// Max value, must always equal the largest entry ever logged.
    /// CEF name: `CEF_CHANNEL_LAYOUT_MAX`.
    public static let max: CEFChannelLayout = .bitstream
}

extension CEFChannelLayout {
    static func fromCEF(_ value: cef_channel_layout_t) -> CEFChannelLayout {
        return CEFChannelLayout(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_channel_layout_t {
        return cef_channel_layout_t(rawValue: UInt32(rawValue))
    }
}

