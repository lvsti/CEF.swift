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
    
    let router = CEFMessageRouterRendererSide(config: CEFMessageRouterConfig())!
    
    var renderProcessHandler: CEFRenderProcessHandler? {
        return self
    }
    
    func onContextCreated(browser: CEFBrowser, frame: CEFFrame, context: CEFV8Context) {
        router.onContextCreated(browser: browser, frame: frame, context: context)
        
        context.enter()
        let v8Str = CEFV8Value.createString("Hello World!")
        print("\(v8Str!.stringValue)")
        context.exit()
    }
    
    func onContextReleased(browser: CEFBrowser, frame: CEFFrame, context: CEFV8Context) {
        router.onContextReleased(browser: browser, frame: frame, context: context)
    }
    
    func onProcessMessageReceived(browser: CEFBrowser,
                                  processID: CEFProcessID,
                                  message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        return router.onProcessMessageReceived(browser: browser, processID: processID, message: message)
    }
}

