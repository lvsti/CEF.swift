//
//  main.swift
//  CEFDemo Helper
//
//  Created by Tamas Lustyik on 2017. 11. 08..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Darwin
import CEFswift

let mainArgs = CEFMainArgs(arguments: CommandLine.arguments)
let retval = CEFProcessUtils.executeProcess(with: mainArgs)
exit(Int32(retval))
