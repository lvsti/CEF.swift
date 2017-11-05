//
//  CEFGeoposition.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class representing a geoposition.
/// CEF name: `cef_geoposition_t`
public struct CEFGeoposition {
    /// Latitude in decimal degrees north (WGS84 coordinate frame).
    /// CEF name: `latitude`
    public let latitude: Double
    
    /// Longitude in decimal degrees west (WGS84 coordinate frame).
    /// CEF name: `longitude`
    public let longitude: Double
    
    /// Altitude in meters (above WGS84 datum).
    /// CEF name: `altitude`
    public let altitude: Double
    
    /// Accuracy of horizontal position in meters.
    /// CEF name: `accuracy`
    public let accuracy: Double
    
    /// Accuracy of altitude in meters.
    /// CEF name: `altitude_accuracy`
    public let altitudeAccuracy: Double
    
    /// Heading in decimal degrees clockwise from true north.
    /// CEF name: `heading`
    public let heading: Double
    
    /// Horizontal component of device velocity in meters per second.
    /// CEF name: `speed`
    public let speed: Double
    
    /// Time of position measurement in milliseconds since Epoch in UTC time. This
    /// is taken from the host computer's system clock.
    /// CEF name: `timestamp`
    public let timestamp: Date
    
    /// Error code, see enum above.
    /// CEF name: `error_code`
    public let errorCode: CEFGeopositionErrorCode
    
    /// Human-readable error message.
    /// CEF name: `error_message`
    public let errorMessage: String?

}

extension CEFGeoposition {
    static func fromCEF(_ value: cef_geoposition_t) -> CEFGeoposition {
        return CEFGeoposition(
            latitude: value.latitude,
            longitude: value.longitude,
            altitude: value.altitude,
            accuracy: value.accuracy,
            altitudeAccuracy: value.altitude_accuracy,
            heading: value.heading,
            speed: value.speed,
            timestamp: CEFTimeToSwiftDate(value.timestamp),
            errorCode: CEFGeopositionErrorCode.fromCEF(value.error_code),
            errorMessage: value.error_message.str != nil ? CEFStringToSwiftString(value.error_message) : nil
        )
    }
}


