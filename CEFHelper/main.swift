//
//  main.swift
//  CEFDemo Helper
//
//  Created by Tamas Lustyik on 2017. 11. 08..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Darwin
import CEFswift

class App: CEFApp, CEFRenderProcessHandler {
    var renderProcessHandler: CEFRenderProcessHandler? {
        return self
    }
    
    func onContextCreated(browser: CEFBrowser, frame: CEFFrame, context: CEFV8Context) {
        context.enter()
        let v8Str = CEFV8Value.createString("Hello World!")
        print("\(v8Str!.stringValue)")
        context.exit()
    }
}

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
