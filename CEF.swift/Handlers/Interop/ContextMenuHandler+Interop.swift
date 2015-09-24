//
//  ContextMenuHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 04..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


func ContextMenuHandler_on_before_context_menu(ptr: UnsafeMutablePointer<cef_context_menu_handler_t>,
                                               browser: UnsafeMutablePointer<cef_browser_t>,
                                               frame: UnsafeMutablePointer<cef_frame_t>,
                                               params: UnsafeMutablePointer<cef_context_menu_params_t>,
                                               model: UnsafeMutablePointer<cef_menu_model_t>) {
    guard let obj = ContextMenuHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onBeforeContextMenu(Browser.fromCEF(browser)!,
                            frame: Frame.fromCEF(frame)!,
                            params: ContextMenuParams.fromCEF(params)!,
                            model: MenuModel.fromCEF(model)!)
}


func ContextMenuHandler_on_context_menu_command(ptr: UnsafeMutablePointer<cef_context_menu_handler_t>,
                                                browser: UnsafeMutablePointer<cef_browser_t>,
                                                frame: UnsafeMutablePointer<cef_frame_t>,
                                                params: UnsafeMutablePointer<cef_context_menu_params_t>,
                                                commandID: Int32,
                                                eventFlags: cef_event_flags_t) -> Int32 {
    guard let obj = ContextMenuHandlerMarshaller.get(ptr) else {
        return 0
    }

    return obj.onContextMenuCommand(Browser.fromCEF(browser)!,
                                    frame: Frame.fromCEF(frame)!,
                                    params: ContextMenuParams.fromCEF(params)!,
                                    commandID: MenuID.fromCEF(commandID),
                                    eventFlags: EventFlags.fromCEF(eventFlags)) ? 1 : 0
}

func ContextMenuHandler_on_context_menu_dismissed(ptr: UnsafeMutablePointer<cef_context_menu_handler_t>,
                                                  browser: UnsafeMutablePointer<cef_browser_t>,
                                                  frame: UnsafeMutablePointer<cef_frame_t>) {
    guard let obj = ContextMenuHandlerMarshaller.get(ptr) else {
        return
    }

    obj.onContextMenuDismissed(Browser.fromCEF(browser)!, frame: Frame.fromCEF(frame)!)
}

