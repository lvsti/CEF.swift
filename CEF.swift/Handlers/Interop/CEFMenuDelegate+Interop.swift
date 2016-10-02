//
//  CEFMenuDelegate+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFMenuModelDelegate_execute_command(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>,
                                          menu: UnsafeMutablePointer<cef_menu_model_t>,
                                          commandID: Int32,
                                          flags: cef_event_flags_t) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onExecuteCommand(menuModel: CEFMenuModel.fromCEF(menu)!,
                         commandID: CEFMenuID.fromCEF(commandID),
                         eventFlags: CEFEventFlags.fromCEF(flags))
}

func CEFMenuModelDelegate_menu_will_show(ptr: UnsafeMutablePointer<cef_menu_model_delegate_t>,
                                         menu: UnsafeMutablePointer<cef_menu_model_t>) {
    guard let obj = CEFMenuModelDelegateMarshaller.get(ptr) else {
        return
    }
    
    obj.onMenuWillShow(menuModel: CEFMenuModel.fromCEF(menu)!)
}

// TODO: more to come
