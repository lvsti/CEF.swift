//
//  App.swift
//  CEFDemo Helper (Swift)
//
//  Created by Tamas Lustyik on 2018. 12. 01..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

import Foundation
import CEFswift

final class App: CEFApp, CEFRenderProcessHandler {
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

