//
//  CEFMenuModelDelegate+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFMenuModelDelegate_execute_command(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                          menu: UnsafeMutablePointer<cef_menu_model_t>?,
                                          commandID: Int32,
                                          flags: cef_event_flags_t) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onExecuteCommand(menuModel: CEFMenuModel.fromCEF(menu)!,
                         commandID: CEFMenuID.fromCEF(commandID),
                         eventFlags: CEFEventFlags.fromCEF(flags))
}

func CEFMenuModelDelegate_mouse_outside_menu(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                             menu: UnsafeMutablePointer<cef_menu_model_t>?,
                                             point: UnsafePointer<cef_point_t>?) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onMouseOutsideMenu(menuModel: CEFMenuModel.fromCEF(menu)!,
                           at: NSPoint.fromCEF(point!.pointee))
}

func CEFMenuModelDelegate_unhandled_open_submenu(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                                 menu: UnsafeMutablePointer<cef_menu_model_t>?,
                                                 isRTL: Int32) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onUnhandledOpenSubmenu(menuModel: CEFMenuModel.fromCEF(menu)!,
                               isRTL: isRTL != 0)
}

func CEFMenuModelDelegate_unhandled_close_submenu(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                                  menu: UnsafeMutablePointer<cef_menu_model_t>?,
                                                  isRTL: Int32) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onUnhandledCloseSubmenu(menuModel: CEFMenuModel.fromCEF(menu)!,
                                isRTL: isRTL != 0)
}

func CEFMenuModelDelegate_menu_will_show(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                         menu: UnsafeMutablePointer<cef_menu_model_t>?) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onMenuWillShow(menuModel: CEFMenuModel.fromCEF(menu)!)
}

func CEFMenuModelDelegate_menu_closed(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                      menu: UnsafeMutablePointer<cef_menu_model_t>?) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onMenuClosed(menuModel: CEFMenuModel.fromCEF(menu)!)
}

func CEFMenuModelDelegate_format_label(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>?,
                                       menu: UnsafeMutablePointer<cef_menu_model_t>?,
                                       label: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return 0
    }
    
    let newLabel = obj.onFormatLabel(menuModel: CEFMenuModel.fromCEF(menu)!,
                                     label: CEFStringToSwiftString(label!.pointee))
    
    if let newLabel = newLabel {
        CEFStringSetFromSwiftString(newLabel, cefStringPtr: label!)
        return 1
    }
    
    return 0
}
