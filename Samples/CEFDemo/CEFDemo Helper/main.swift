//
//  main.swift
//  CEFDemo Helper
//
//  Created by Tamas Lustyik on 2017. 11. 08..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Darwin
import CEFswift

#error("Important notice")
// This helper written in Swift does not YET support the new macOS sandboxing mechanism.
// You are encouraged to use the provided C or C++ helper implementations instead.
// If that is not an option for you, you may try falling back to using the legacy sandbox
// by setting the USE_LEGACY_SANDBOX compilation condition in the CEFDemo target.
// NOTE: This workaround is not guaranteed to work in subsequent CEF releases.

let mainArgs = CEFMainArgs(arguments: CommandLine.arguments)
let commandLine = CEFCommandLine()!
commandLine.initFromArguments(CommandLine.arguments)

let retval: Int
if commandLine.switchValue(for: "type") == "renderer" {
    // renderer process
    // uncomment the following line in order to have the process paused until a debugger is attached
    //raise(SIGSTOP)
    retval = CEFProcessUtils.executeProcess(with: mainArgs, app: App())
}
else {
    // other helper processes spawned by CEF
    retval = CEFProcessUtils.executeProcess(with: mainArgs)
}

exit(Int32(retval))
