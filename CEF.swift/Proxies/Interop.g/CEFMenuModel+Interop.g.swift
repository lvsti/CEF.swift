//
//  CEFMenuModel+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_menu_model.h.
//

import Foundation

extension cef_menu_model_t: CEFObject {}

/// Supports creation and modification of menus. See cef_menu_id_t for the
/// command ids that have default implementations. All user-defined command ids
/// should be between MENU_ID_USER_FIRST and MENU_ID_USER_LAST. The methods of
/// this class can only be accessed on the browser process the UI thread.
public class CEFMenuModel: CEFProxy<cef_menu_model_t> {
    override init?(ptr: UnsafeMutablePointer<cef_menu_model_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_menu_model_t>?) -> CEFMenuModel? {
        return CEFMenuModel(ptr: ptr)
    }
}

