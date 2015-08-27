//
//  CEFSeekPosition.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// typed version of SEEK_{SET,CUR,END}
public enum CEFSeekPosition: Int32 {
    case Set = 0
    case Current
    case End
}
