//
//  CEFMenuModel.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_menu_model_t: CEFObject {
}

///
// Supports creation and modification of menus. See cef_menu_id_t for the
// command ids that have default implementations. All user-defined command ids
// should be between MENU_ID_USER_FIRST and MENU_ID_USER_LAST. The methods of
// this class can only be accessed on the browser process the UI thread.
///
public class CEFMenuModel: CEFProxy<cef_menu_model_t> {

    public typealias CommandID = CEFMenuID
    public typealias GroupID = Int32
    public typealias MenuItemType = CEFMenuItemType

    ///
    // Clears the menu. Returns true on success.
    ///
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }
    
    ///
    // Returns the number of items in this menu.
    ///
    public func getCount() -> Int {
        return Int(cefObject.get_count(cefObjectPtr))
    }

    ///
    // Add a separator to the menu. Returns true on success.
    ///
    public func addSeparator() -> Bool {
        return cefObject.add_separator(cefObjectPtr) != 0
    }
    
    ///
    // Add an item to the menu. Returns true on success.
    ///
    public func addItem(commandID: CommandID, label: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    //
    // Add a check item to the menu. Returns true on success.
    ///
    public func addCheckItem(commandID: CommandID, label: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_check_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }

    //
    // Add a radio item to the menu. Only a single item with the specified
    // |group_id| can be checked at a time. Returns true on success.
    ///
    public func addRadioItem(commandID: CommandID, label: String, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_radio_item(cefObjectPtr, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    //
    // Add a sub-menu to the menu. The new sub-menu is returned.
    ///
    public func addSubmenu(commandID: CommandID, label: String) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.add_sub_menu(cefObjectPtr, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    //
    // Insert a separator in the menu at the specified |index|. Returns true on
    // success.
    ///
    public func insertSeparatorAt(index: Int32) -> Bool {
        return cefObject.insert_separator_at(cefObjectPtr, index) != 0
    }

    //
    // Insert an item in the menu at the specified |index|. Returns true on
    // success.
    ///
    public func insertItemAt(index: Int32, commandID: CommandID, label: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr) != 0
    }

    //
    // Insert a check item in the menu at the specified |index|. Returns true on
    // success.
    ///
    public func insertCheckItemAt(index: Int32, commandID: CommandID, label: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_check_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr) != 0
    }
    
    //
    // Insert a radio item in the menu at the specified |index|. Only a single
    // item with the specified |group_id| can be checked at a time. Returns true
    // on success.
    ///
    public func insertRadioItemAt(index: Int32, commandID: CommandID, label: String, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_radio_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    //
    // Insert a sub-menu in the menu at the specified |index|. The new sub-menu
    // is returned.
    ///
    public func insertSubmenuAt(index: Int32, commandID: CommandID, label: String) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.insert_sub_menu_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    ///
    // Removes the item with the specified |command_id|. Returns true on success.
    ///
    public func remove(commandID: CommandID) -> Bool {
        return cefObject.remove(cefObjectPtr, commandID.toCEF()) != 0
    }

    ///
    // Removes the item at the specified |index|. Returns true on success.
    ///
    public func removeAt(index: Int32) -> Bool {
        return cefObject.remove_at(cefObjectPtr, index) != 0
    }
    
    ///
    // Returns the index associated with the specified |command_id| or -1 if not
    // found due to the command id not existing in the menu.
    ///
    public func getIndexOf(commandID: CommandID) -> Int32 {
        return cefObject.get_index_of(cefObjectPtr, commandID.toCEF())
    }
    
    ///
    // Returns the command id at the specified |index| or -1 if not found due to
    // invalid range or the index being a separator.
    ///
    public func getCommandIDAt(index: Int32) -> CommandID {
        let cefID = cefObject.get_command_id_at(cefObjectPtr, index)
        return CommandID.fromCEF(cefID)
    }
    
    ///
    // Sets the command id at the specified |index|. Returns true on success.
    ///
    public func setCommandIDAt(index: Int32, commandID: CommandID) -> Bool {
        return cefObject.set_command_id_at(cefObjectPtr, index, commandID.toCEF()) != 0
    }
    
    ///
    // Returns the label for the specified |command_id| or empty if not found.
    ///
    public func getLabel(commandID: CommandID) -> String {
        let cefStrPtr = cefObject.get_label(cefObjectPtr, commandID.toCEF())
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the label at the specified |index| or empty if not found due to
    // invalid range or the index being a separator.
    ///
    public func getLabelAt(index: Int32) -> String {
        let cefStrPtr = cefObject.get_label_at(cefObjectPtr, index)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Sets the label for the specified |command_id|. Returns true on success.
    ///
    public func setLabel(commandID: CommandID, label: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    ///
    // Set the label at the specified |index|. Returns true on success.
    ///
    public func setLabelAt(index: Int32, label: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label_at(cefObjectPtr, index, cefStrPtr) != 0
    }
    
    ///
    // Returns the item type for the specified |command_id|.
    ///
    public func getType(commandID: CommandID) -> MenuItemType {
        let cefType = cefObject.get_type(cefObjectPtr, commandID.toCEF())
        return MenuItemType.fromCEF(cefType)
    }

    ///
    // Returns the item type at the specified |index|.
    ///
    public func getTypeAt(index: Int32) -> MenuItemType {
        let cefType = cefObject.get_type_at(cefObjectPtr, index)
        return MenuItemType.fromCEF(cefType)
    }
    
    ///
    // Returns the group id for the specified |command_id| or -1 if invalid.
    ///
    public func getGroupID(commandID: CommandID) -> GroupID {
        return cefObject.get_group_id(cefObjectPtr, commandID.toCEF())
    }
    
    ///
    // Returns the group id at the specified |index| or -1 if invalid.
    ///
    public func getGroupIDAt(index: Int32) -> GroupID {
        return cefObject.get_group_id_at(cefObjectPtr, index)
    }
    
    ///
    // Sets the group id for the specified |command_id|. Returns true on success.
    ///
    public func setGroupID(commandID: CommandID, groupID: GroupID) -> Bool {
        return cefObject.set_group_id(cefObjectPtr, commandID.toCEF(), groupID) != 0
    }
    
    ///
    // Sets the group id at the specified |index|. Returns true on success.
    ///
    public func setGroupIDAt(index: Int32, groupID: GroupID) -> Bool {
        return cefObject.set_group_id_at(cefObjectPtr, index, groupID) != 0
    }
    
    ///
    // Returns the submenu for the specified |command_id| or empty if invalid.
    ///
    public func getSubmenu(commandID: CommandID) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu(cefObjectPtr, commandID.toCEF())
        return CEFMenuModel.fromCEF(cefMenu)
    }

    ///
    // Returns the submenu at the specified |index| or empty if invalid.
    ///
    public func getSubmenuAt(index: Int32) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu_at(cefObjectPtr, index)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    //
    // Returns true if the specified |command_id| is visible.
    ///
    public func isVisible(commandID: CommandID) -> Bool {
        return cefObject.is_visible(cefObjectPtr, commandID.toCEF()) != 0
    }

    //
    // Returns true if the specified |index| is visible.
    ///
    public func isVisibleAt(index: Int32) -> Bool {
        return cefObject.is_visible_at(cefObjectPtr, index) != 0
    }

    //
    // Change the visibility of the specified |command_id|. Returns true on
    // success.
    ///
    public func setVisible(commandID: CommandID, visible: Bool) -> Bool {
        return cefObject.set_visible(cefObjectPtr, commandID.toCEF(), visible ? 1 : 0) != 0
    }

    //
    // Change the visibility at the specified |index|. Returns true on success.
    ///
    public func setVisibleAt(index: Int32, visible: Bool) -> Bool {
        return cefObject.set_visible_at(cefObjectPtr, index, visible ? 1 : 0) != 0
    }

    //
    // Returns true if the specified |command_id| is enabled.
    ///
    public func isEnabled(commandID: CommandID) -> Bool {
        return cefObject.is_enabled(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    //
    // Returns true if the specified |index| is enabled.
    ///
    public func isEnabledAt(index: Int32) -> Bool {
        return cefObject.is_enabled_at(cefObjectPtr, index) != 0
    }

    //
    // Change the enabled status of the specified |command_id|. Returns true on
    // success.
    ///
    public func setEnabled(commandID: CommandID, enabled: Bool) -> Bool {
        return cefObject.set_enabled(cefObjectPtr, commandID.toCEF(), enabled ? 1 : 0) != 0
    }

    //
    // Change the enabled status at the specified |index|. Returns true on
    // success.
    ///
    public func setEnabledAt(index: Int32, enabled: Bool) -> Bool {
        return cefObject.set_enabled_at(cefObjectPtr, index, enabled ? 1 : 0) != 0
    }
    
    //
    // Returns true if the specified |command_id| is checked. Only applies to
    // check and radio items.
    ///
    public func isChecked(commandID: CommandID) -> Bool {
        return cefObject.is_checked(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    //
    // Returns true if the specified |index| is checked. Only applies to check
    // and radio items.
    ///
    public func isCheckedAt(index: Int32) -> Bool {
        return cefObject.is_checked_at(cefObjectPtr, index) != 0
    }
    
    //
    // Check the specified |command_id|. Only applies to check and radio items.
    // Returns true on success.
    ///
    public func setChecked(commandID: CommandID, checked: Bool) -> Bool {
        return cefObject.set_checked(cefObjectPtr, commandID.toCEF(), checked ? 1 : 0) != 0
    }
    
    //
    // Check the specified |index|. Only applies to check and radio items. Returns
    // true on success.
    ///
    public func setCheckedAt(index: Int32, checked: Bool) -> Bool {
        return cefObject.set_checked_at(cefObjectPtr, index, checked ? 1 : 0) != 0
    }
    
    //
    // Returns true if the specified |command_id| has a keyboard accelerator
    // assigned.
    ///
    public func hasAccelerator(commandID: CommandID) -> Bool {
        return cefObject.has_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    //
    // Returns true if the specified |index| has a keyboard accelerator assigned.
    ///
    public func hasAcceleratorAt(index: Int32) -> Bool {
        return cefObject.has_accelerator_at(cefObjectPtr, index) != 0
    }
    
    //
    // Set the keyboard accelerator for the specified |command_id|. |key_code| can
    // be any virtual key or character value. Returns true on success.
    ///
    public func setAccelerator(commandID: CommandID, accelerator acc: CEFMenuItemAccelerator) -> Bool {
        return cefObject.set_accelerator(cefObjectPtr,
                                         commandID.toCEF(),
                                         acc.keyCode,
                                         acc.shift ? 1 : 0,
                                         acc.control ? 1 : 0,
                                         acc.alt ? 1 : 0) != 0
    }

    //
    // Set the keyboard accelerator at the specified |index|. |key_code| can be
    // any virtual key or character value. Returns true on success.
    ///
    public func setAcceleratorAt(index: Int32, accelerator acc: CEFMenuItemAccelerator) -> Bool {
        return cefObject.set_accelerator_at(cefObjectPtr,
                                            index,
                                            acc.keyCode,
                                            acc.shift ? 1 : 0,
                                            acc.control ? 1 : 0,
                                            acc.alt ? 1 : 0) != 0
    }
    
    //
    // Remove the keyboard accelerator for the specified |command_id|. Returns
    // true on success.
    ///
    public func removeAccelerator(commandID: CommandID) -> Bool {
        return cefObject.remove_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }

    //
    // Remove the keyboard accelerator at the specified |index|. Returns true on
    // success.
    ///
    public func removeAcceleratorAt(index: Int32) -> Bool {
        return cefObject.remove_accelerator_at(cefObjectPtr, index) != 0
    }
    
    //
    // Retrieves the keyboard accelerator for the specified |command_id|. Returns
    // true on success.
    ///
    public func getAccelerator(commandID: CommandID) -> CEFMenuItemAccelerator? {
        var keyCode: Int32 = 0
        var shift: Int32 = 0
        var control: Int32 = 0
        var alt: Int32 = 0
        guard cefObject.get_accelerator(cefObjectPtr, commandID.toCEF(), &keyCode, &shift, &control, &alt) != 0 else {
            return nil
        }
        
        return CEFMenuItemAccelerator(keyCode: keyCode,
                                      shift: shift != 0,
                                      control: control != 0,
                                      alt: alt != 0)
    }

    //
    // Retrieves the keyboard accelerator for the specified |index|. Returns true
    // on success.
    ///
    public func getAcceleratorAt(index: Int32) -> CEFMenuItemAccelerator? {
        var keyCode: Int32 = 0
        var shift: Int32 = 0
        var control: Int32 = 0
        var alt: Int32 = 0
        guard cefObject.get_accelerator(cefObjectPtr, index, &keyCode, &shift, &control, &alt) != 0 else {
            return nil
        }
        
        return CEFMenuItemAccelerator(keyCode: keyCode,
                                      shift: shift != 0,
                                      control: control != 0,
                                      alt: alt != 0)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFMenuModel? {
        return CEFMenuModel(ptr: ptr)
    }
}