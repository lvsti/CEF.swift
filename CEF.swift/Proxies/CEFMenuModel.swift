//
//  CEFMenuModel.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMenuModel {

    public typealias CommandID = CEFMenuID
    public typealias GroupID = Int32
    
    public convenience init?(delegate: CEFMenuModelDelegate? = nil) {
        var cefDelegatePtr: UnsafeMutablePointer<cef_menu_model_delegate_t> = nil
        if let delegate = delegate {
            cefDelegatePtr = delegate.toCEF()
        }
        
        self.init(ptr: cef_menu_model_create(cefDelegatePtr))
    }

    /// Clears the menu. Returns true on success.
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }
    
    /// Returns the number of items in this menu.
    public var count: Int {
        return Int(cefObject.get_count(cefObjectPtr))
    }

    /// Add a separator to the menu. Returns true on success.
    public func addSeparator() -> Bool {
        return cefObject.add_separator(cefObjectPtr) != 0
    }
    
    /// Add an item to the menu. Returns true on success.
    public func addItem(label: String, withCommandID commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    //
    // Add a check item to the menu. Returns true on success.
    ///
    public func addCheckItem(label: String, withCommandID commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_check_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }

    //
    // Add a radio item to the menu. Only a single item with the specified
    // |group_id| can be checked at a time. Returns true on success.
    ///
    public func addRadioItem(label: String, withCommandID commandID: CommandID, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_radio_item(cefObjectPtr, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    //
    // Add a sub-menu to the menu. The new sub-menu is returned.
    ///
    public func addSubmenu(label: String, withCommandID commandID: CommandID) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.add_sub_menu(cefObjectPtr, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    //
    // Insert a separator in the menu at the specified |index|. Returns true on
    // success.
    ///
    public func insertSeparatorAtIndex(index: Int32) -> Bool {
        return cefObject.insert_separator_at(cefObjectPtr, index) != 0
    }

    //
    // Insert an item in the menu at the specified |index|. Returns true on
    // success.
    ///
    public func insertItem(label: String, atIndex index: Int32, withCommandID commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr) != 0
    }

    //
    // Insert a check item in the menu at the specified |index|. Returns true on
    // success.
    ///
    public func insertCheckItem(label: String, atIndex index: Int32, withCommandID commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_check_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr) != 0
    }
    
    //
    // Insert a radio item in the menu at the specified |index|. Only a single
    // item with the specified |group_id| can be checked at a time. Returns true
    // on success.
    ///
    public func insertRadioItem(label: String, atIndex index: Int32, withCommandID commandID: CommandID, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_radio_item_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    //
    // Insert a sub-menu in the menu at the specified |index|. The new sub-menu
    // is returned.
    ///
    public func insertSubmenu(label: String, atIndex index: Int32, withCommandID commandID: CommandID) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.insert_sub_menu_at(cefObjectPtr, index, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Removes the item with the specified |command_id|. Returns true on success.
    public func removeItemWithCommandID(commandID: CommandID) -> Bool {
        return cefObject.remove(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Removes the item at the specified |index|. Returns true on success.
    public func removeItemAtIndex(index: Int32) -> Bool {
        return cefObject.remove_at(cefObjectPtr, index) != 0
    }
    
    /// Returns the index associated with the specified |command_id| or -1 if not
    /// found due to the command id not existing in the menu.
    public func indexForCommandID(commandID: CommandID) -> Int32 {
        return cefObject.get_index_of(cefObjectPtr, commandID.toCEF())
    }
    
    /// Returns the command id at the specified |index| or -1 if not found due to
    /// invalid range or the index being a separator.
    public func commandIDAtIndex(index: Int32) -> CommandID {
        let cefID = cefObject.get_command_id_at(cefObjectPtr, index)
        return CommandID.fromCEF(cefID)
    }
    
    /// Sets the command id at the specified |index|. Returns true on success.
    public func setCommandID(commandID: CommandID, atIndex index: Int32) -> Bool {
        return cefObject.set_command_id_at(cefObjectPtr, index, commandID.toCEF()) != 0
    }
    
    /// Returns the label for the specified |command_id| or empty if not found.
    public func labelForCommandID(commandID: CommandID) -> String? {
        let cefStrPtr = cefObject.get_label(cefObjectPtr, commandID.toCEF())
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.pointee) : nil
    }
    
    /// Returns the label at the specified |index| or empty if not found due to
    /// invalid range or the index being a separator.
    public func labelAtIndex(index: Int32) -> String? {
        let cefStrPtr = cefObject.get_label_at(cefObjectPtr, index)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.pointee) : nil
    }
    
    /// Sets the label for the specified |command_id|. Returns true on success.
    public func setLabel(label: String, forCommandID commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Set the label at the specified |index|. Returns true on success.
    public func setLabel(label: String, atIndex index: Int32) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label_at(cefObjectPtr, index, cefStrPtr) != 0
    }
    
    /// Returns the item type for the specified |command_id|.
    public func typeForCommandID(commandID: CommandID) -> CEFMenuItemType {
        let cefType = cefObject.get_type(cefObjectPtr, commandID.toCEF())
        return CEFMenuItemType.fromCEF(cefType)
    }

    /// Returns the item type at the specified |index|.
    public func typeAtIndex(index: Int32) -> CEFMenuItemType {
        let cefType = cefObject.get_type_at(cefObjectPtr, index)
        return CEFMenuItemType.fromCEF(cefType)
    }
    
    /// Returns the group id for the specified |command_id| or -1 if invalid.
    public func groupIDForCommandID(commandID: CommandID) -> GroupID {
        return cefObject.get_group_id(cefObjectPtr, commandID.toCEF())
    }
    
    /// Returns the group id at the specified |index| or -1 if invalid.
    public func groupIDAtIndex(index: Int32) -> GroupID {
        return cefObject.get_group_id_at(cefObjectPtr, index)
    }
    
    /// Sets the group id for the specified |command_id|. Returns true on success.
    public func setGroupID(groupID: GroupID, forCommandID commandID: CommandID) -> Bool {
        return cefObject.set_group_id(cefObjectPtr, commandID.toCEF(), groupID) != 0
    }
    
    /// Sets the group id at the specified |index|. Returns true on success.
    public func setGroupID(groupID: GroupID, atIndex index: Int32) -> Bool {
        return cefObject.set_group_id_at(cefObjectPtr, index, groupID) != 0
    }
    
    /// Returns the submenu for the specified |command_id| or empty if invalid.
    public func submenuForCommandID(commandID: CommandID) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu(cefObjectPtr, commandID.toCEF())
        return CEFMenuModel.fromCEF(cefMenu)
    }

    /// Returns the submenu at the specified |index| or empty if invalid.
    public func submenuAtIndex(index: Int32) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu_at(cefObjectPtr, index)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    //
    // Returns true if the specified |command_id| is visible.
    ///
    public func isVisibleForCommandID(commandID: CommandID) -> Bool {
        return cefObject.is_visible(cefObjectPtr, commandID.toCEF()) != 0
    }

    //
    // Returns true if the specified |index| is visible.
    ///
    public func isVisibleAtIndex(index: Int32) -> Bool {
        return cefObject.is_visible_at(cefObjectPtr, index) != 0
    }

    //
    // Change the visibility of the specified |command_id|. Returns true on
    // success.
    ///
    public func setVisible(visible: Bool, forCommandID commandID: CommandID) -> Bool {
        return cefObject.set_visible(cefObjectPtr, commandID.toCEF(), visible ? 1 : 0) != 0
    }

    //
    // Change the visibility at the specified |index|. Returns true on success.
    ///
    public func setVisible(visible: Bool, atIndex index: Int32) -> Bool {
        return cefObject.set_visible_at(cefObjectPtr, index, visible ? 1 : 0) != 0
    }

    //
    // Returns true if the specified |command_id| is enabled.
    ///
    public func isEnabledForCommandID(commandID: CommandID) -> Bool {
        return cefObject.is_enabled(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    //
    // Returns true if the specified |index| is enabled.
    ///
    public func isEnabledAtIndex(index: Int32) -> Bool {
        return cefObject.is_enabled_at(cefObjectPtr, index) != 0
    }

    //
    // Change the enabled status of the specified |command_id|. Returns true on
    // success.
    ///
    public func setEnabled(enabled: Bool, forCommandID commandID: CommandID) -> Bool {
        return cefObject.set_enabled(cefObjectPtr, commandID.toCEF(), enabled ? 1 : 0) != 0
    }

    //
    // Change the enabled status at the specified |index|. Returns true on
    // success.
    ///
    public func setEnabled(enabled: Bool, atIndex index: Int32) -> Bool {
        return cefObject.set_enabled_at(cefObjectPtr, index, enabled ? 1 : 0) != 0
    }
    
    //
    // Returns true if the specified |command_id| is checked. Only applies to
    // check and radio items.
    ///
    public func isCheckedForCommandID(commandID: CommandID) -> Bool {
        return cefObject.is_checked(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    //
    // Returns true if the specified |index| is checked. Only applies to check
    // and radio items.
    ///
    public func isCheckedAtIndex(index: Int32) -> Bool {
        return cefObject.is_checked_at(cefObjectPtr, index) != 0
    }
    
    //
    // Check the specified |command_id|. Only applies to check and radio items.
    // Returns true on success.
    ///
    public func setChecked(checked: Bool, forCommandID commandID: CommandID) -> Bool {
        return cefObject.set_checked(cefObjectPtr, commandID.toCEF(), checked ? 1 : 0) != 0
    }
    
    //
    // Check the specified |index|. Only applies to check and radio items. Returns
    // true on success.
    ///
    public func setChecked(checked: Bool, atIndex index: Int32) -> Bool {
        return cefObject.set_checked_at(cefObjectPtr, index, checked ? 1 : 0) != 0
    }
    
    //
    // Returns true if the specified |command_id| has a keyboard accelerator
    // assigned.
    ///
    public func hasAcceleratorForCommandID(commandID: CommandID) -> Bool {
        return cefObject.has_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    //
    // Returns true if the specified |index| has a keyboard accelerator assigned.
    ///
    public func hasAcceleratorAtIndex(index: Int32) -> Bool {
        return cefObject.has_accelerator_at(cefObjectPtr, index) != 0
    }
    
    //
    // Set the keyboard accelerator for the specified |command_id|. |key_code| can
    // be any virtual key or character value. Returns true on success.
    ///
    public func setAccelerator(accelerator: CEFMenuItemAccelerator, forCommandID commandID: CommandID) -> Bool {
        return cefObject.set_accelerator(cefObjectPtr,
                                         commandID.toCEF(),
                                         accelerator.keyCode,
                                         accelerator.shift ? 1 : 0,
                                         accelerator.control ? 1 : 0,
                                         accelerator.alt ? 1 : 0) != 0
    }

    //
    // Set the keyboard accelerator at the specified |index|. |key_code| can be
    // any virtual key or character value. Returns true on success.
    ///
    public func setAccelerator(accelerator: CEFMenuItemAccelerator, atIndex index: Int32) -> Bool {
        return cefObject.set_accelerator_at(cefObjectPtr,
                                            index,
                                            accelerator.keyCode,
                                            accelerator.shift ? 1 : 0,
                                            accelerator.control ? 1 : 0,
                                            accelerator.alt ? 1 : 0) != 0
    }
    
    //
    // Remove the keyboard accelerator for the specified |command_id|. Returns
    // true on success.
    ///
    public func removeAcceleratorForCommandID(commandID: CommandID) -> Bool {
        return cefObject.remove_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }

    //
    // Remove the keyboard accelerator at the specified |index|. Returns true on
    // success.
    ///
    public func removeAcceleratorAtIndex(index: Int32) -> Bool {
        return cefObject.remove_accelerator_at(cefObjectPtr, index) != 0
    }
    
    //
    // Retrieves the keyboard accelerator for the specified |command_id|. Returns
    // true on success.
    ///
    public func acceleratorForCommandID(commandID: CommandID) -> CEFMenuItemAccelerator? {
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
    public func acceleratorAtIndex(index: Int32) -> CEFMenuItemAccelerator? {
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
    
}
