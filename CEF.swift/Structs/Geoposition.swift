//
//  Geoposition.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class representing a geoposition.
public struct Geoposition {
    /// Latitude in decimal degrees north (WGS84 coordinate frame).
    public let latitude: Double
    
    /// Longitude in decimal degrees west (WGS84 coordinate frame).
    public let longitude: Double
    
    /// Altitude in meters (above WGS84 datum).
    public let altitude: Double
    
    /// Accuracy of horizontal position in meters.
    public let accuracy: Double
    
    /// Accuracy of altitude in meters.
    public let altitudeAccuracy: Double
    
    /// Heading in decimal degrees clockwise from true north.
    public let heading: Double
    
    /// Horizontal component of device velocity in meters per second.
    public let speed: Double
    
    /// Time of position measurement in milliseconds since Epoch in UTC time. This
    /// is taken from the host computer's system clock.
    public let timestamp: NSDate
    
    /// Error code, see enum above.
    public let errorCode: GeopositionErrorCode
    
    /// Human-readable error message.
    public let errorMessage: String?

}

extension Geoposition {
    static func fromCEF(cefStruct: cef_geoposition_t) -> Geoposition {
        return Geoposition(
            latitude: cefStruct.latitude,
            longitude: cefStruct.longitude,
            altitude: cefStruct.altitude,
            accuracy: cefStruct.accuracy,
            altitudeAccuracy: cefStruct.altitude_accuracy,
            heading: cefStruct.heading,
            speed: cefStruct.speed,
            timestamp: CEFTimeToNSDate(cefStruct.timestamp),
            errorCode: GeopositionErrorCode.fromCEF(cefStruct.error_code),
            errorMessage: cefStruct.error_message.str != nil ? CEFStringToSwiftString(cefStruct.error_message) : nil
        )
    }
}


