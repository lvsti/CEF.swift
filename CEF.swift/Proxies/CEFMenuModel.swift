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
    
    /// Create a new MenuModel with the specified |delegate|.
    /// CEF name: `CreateMenuModel`
    public convenience init?(delegate: CEFMenuModelDelegate? = nil) {
        let cefDelegatePtr = delegate?.toCEF()
        self.init(ptr: cef_menu_model_create(cefDelegatePtr))
    }

    /// Clears the menu. Returns true on success.
    /// CEF name: `Clear`
    public func clear() -> Bool {
        return cefObject.clear(cefObjectPtr) != 0
    }
    
    /// Returns the number of items in this menu.
    /// CEF name: `GetCount`
    public var count: Int {
        return Int(cefObject.get_count(cefObjectPtr))
    }

    /// Add a separator to the menu. Returns true on success.
    /// CEF name: `AddSeparator`
    public func addSeparator() -> Bool {
        return cefObject.add_separator(cefObjectPtr) != 0
    }
    
    /// Add an item to the menu. Returns true on success.
    /// CEF name: `AddItem`
    public func addItem(_ label: String, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Add a check item to the menu. Returns true on success.
    /// CEF name: `AddCheckItem`
    public func addCheckItem(_ label: String, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_check_item(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }

    /// Add a radio item to the menu. Only a single item with the specified
    /// |group_id| can be checked at a time. Returns true on success.
    /// CEF name: `AddRadioItem`
    public func addRadioItem(_ label: String, commandID: CommandID, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.add_radio_item(cefObjectPtr, commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    /// Add a sub-menu to the menu. The new sub-menu is returned.
    /// CEF name: `AddSubMenu`
    public func addSubmenu(_ label: String, commandID: CommandID) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.add_sub_menu(cefObjectPtr, commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Insert a separator in the menu at the specified |index|. Returns true on
    /// success.
    /// CEF name: `InsertSeparatorAt`
    public func insertSeparator(at index: Int) -> Bool {
        return cefObject.insert_separator_at(cefObjectPtr, Int32(index)) != 0
    }

    /// Insert an item in the menu at the specified |index|. Returns true on
    /// success.
    /// CEF name: `InsertItemAt`
    public func insertItem(_ label: String, at index: Int, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_item_at(cefObjectPtr, Int32(index), commandID.toCEF(), cefStrPtr) != 0
    }

    /// Insert a check item in the menu at the specified |index|. Returns true on
    /// success.
    /// CEF name: `InsertCheckItemAt`
    public func insertCheckItem(_ label: String, at index: Int, commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_check_item_at(cefObjectPtr, Int32(index), commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Insert a radio item in the menu at the specified |index|. Only a single
    /// item with the specified |group_id| can be checked at a time. Returns true
    /// on success.
    /// CEF name: `InsertRadioItemAt`
    public func insertRadioItem(_ label: String, at index: Int, commandID: CommandID, groupID: GroupID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.insert_radio_item_at(cefObjectPtr, Int32(index), commandID.toCEF(), cefStrPtr, groupID) != 0
    }
    
    /// Insert a sub-menu in the menu at the specified |index|. The new sub-menu
    /// is returned.
    /// CEF name: `InsertSubMenuAt`
    public func insertSubmenu(_ label: String, at index: Int, commandID: CommandID) -> CEFMenuModel? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefMenu = cefObject.insert_sub_menu_at(cefObjectPtr, Int32(index), commandID.toCEF(), cefStrPtr)
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Removes the item with the specified |command_id|. Returns true on success.
    /// CEF name: `Remove`
    public func removeItem(commandID: CommandID) -> Bool {
        return cefObject.remove(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Removes the item at the specified |index|. Returns true on success.
    /// CEF name: `RemoveAt`
    public func removeItem(at index: Int) -> Bool {
        return cefObject.remove_at(cefObjectPtr, Int32(index)) != 0
    }
    
    /// Returns the index associated with the specified |command_id| or -1 if not
    /// found due to the command id not existing in the menu.
    /// CEF name: `GetIndexOf`
    public func index(for commandID: CommandID) -> Int {
        return Int(cefObject.get_index_of(cefObjectPtr, commandID.toCEF()))
    }
    
    /// Returns the command id at the specified |index| or -1 if not found due to
    /// invalid range or the index being a separator.
    /// CEF name: `GetCommandIdAt`
    public func commandID(at index: Int) -> CommandID {
        let cefID = cefObject.get_command_id_at(cefObjectPtr, Int32(index))
        return CommandID.fromCEF(cefID)
    }
    
    /// Sets the command id at the specified |index|. Returns true on success.
    /// CEF name: `SetCommandIdAt`
    public func setCommandID(_ commandID: CommandID, at index: Int) -> Bool {
        return cefObject.set_command_id_at(cefObjectPtr, Int32(index), commandID.toCEF()) != 0
    }
    
    /// Returns the label for the specified |command_id| or empty if not found.
    /// CEF name: `GetLabel`
    public func label(for commandID: CommandID) -> String? {
        let cefStrPtr = cefObject.get_label(cefObjectPtr, commandID.toCEF())
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
    }
    
    /// Returns the label at the specified |index| or empty if not found due to
    /// invalid range or the index being a separator.
    /// CEF name: `GetLabelAt`
    public func label(at index: Int) -> String? {
        let cefStrPtr = cefObject.get_label_at(cefObjectPtr, Int32(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
    }
    
    /// Sets the label for the specified |command_id|. Returns true on success.
    /// CEF name: `SetLabel`
    public func setLabel(_ label: String, for commandID: CommandID) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label(cefObjectPtr, commandID.toCEF(), cefStrPtr) != 0
    }
    
    /// Set the label at the specified |index|. Returns true on success.
    /// CEF name: `SetLabelAt`
    public func setLabel(_ label: String, at index: Int) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(label)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_label_at(cefObjectPtr, Int32(index), cefStrPtr) != 0
    }
    
    /// Returns the item type for the specified |command_id|.
    /// CEF name: `GetType`
    public func type(for commandID: CommandID) -> CEFMenuItemType {
        let cefType = cefObject.get_type(cefObjectPtr, commandID.toCEF())
        return CEFMenuItemType.fromCEF(cefType)
    }

    /// Returns the item type at the specified |index|.
    /// CEF name: `GetTypeAt`
    public func type(at index: Int) -> CEFMenuItemType {
        let cefType = cefObject.get_type_at(cefObjectPtr, Int32(index))
        return CEFMenuItemType.fromCEF(cefType)
    }
    
    /// Returns the group id for the specified |command_id| or -1 if invalid.
    /// CEF name: `GetGroupId`
    public func groupID(for commandID: CommandID) -> GroupID {
        return cefObject.get_group_id(cefObjectPtr, commandID.toCEF())
    }
    
    /// Returns the group id at the specified |index| or -1 if invalid.
    /// CEF name: `GetGroupIdAt`
    public func groupID(at index: Int) -> GroupID {
        return cefObject.get_group_id_at(cefObjectPtr, Int32(index))
    }
    
    /// Sets the group id for the specified |command_id|. Returns true on success.
    /// CEF name: `SetGroupId`
    public func setGroupID(_ groupID: GroupID, for commandID: CommandID) -> Bool {
        return cefObject.set_group_id(cefObjectPtr, commandID.toCEF(), groupID) != 0
    }
    
    /// Sets the group id at the specified |index|. Returns true on success.
    /// CEF name: `SetGroupIdAt`
    public func setGroupID(_ groupID: GroupID, at index: Int) -> Bool {
        return cefObject.set_group_id_at(cefObjectPtr, Int32(index), groupID) != 0
    }
    
    /// Returns the submenu for the specified |command_id| or empty if invalid.
    /// CEF name: `GetSubMenu`
    public func submenu(for commandID: CommandID) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu(cefObjectPtr, commandID.toCEF())
        return CEFMenuModel.fromCEF(cefMenu)
    }

    /// Returns the submenu at the specified |index| or empty if invalid.
    /// CEF name: `GetSubMenuAt`
    public func submenu(at index: Int) -> CEFMenuModel? {
        let cefMenu = cefObject.get_sub_menu_at(cefObjectPtr, Int32(index))
        return CEFMenuModel.fromCEF(cefMenu)
    }
    
    /// Returns true if the specified |command_id| is visible.
    /// CEF name: `IsVisible`
    public func isVisible(commandID: CommandID) -> Bool {
        return cefObject.is_visible(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Returns true if the specified |index| is visible.
    /// CEF name: `IsVisibleAt`
    public func isVisible(at index: Int) -> Bool {
        return cefObject.is_visible_at(cefObjectPtr, Int32(index)) != 0
    }

    /// Change the visibility of the specified |command_id|. Returns true on
    /// success.
    /// CEF name: `SetVisible`
    public func setVisible(_ visible: Bool, for commandID: CommandID) -> Bool {
        return cefObject.set_visible(cefObjectPtr, commandID.toCEF(), visible ? 1 : 0) != 0
    }

    /// Change the visibility at the specified |index|. Returns true on success.
    /// CEF name: `SetVisibleAt`
    public func setVisible(_ visible: Bool, at index: Int) -> Bool {
        return cefObject.set_visible_at(cefObjectPtr, Int32(index), visible ? 1 : 0) != 0
    }

    /// Returns true if the specified |command_id| is enabled.
    /// CEF name: `IsEnabled`
    public func isEnabled(commandID: CommandID) -> Bool {
        return cefObject.is_enabled(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    /// Returns true if the specified |index| is enabled.
    /// CEF name: `IsEnabledAt`
    public func isEnabled(at index: Int) -> Bool {
        return cefObject.is_enabled_at(cefObjectPtr, Int32(index)) != 0
    }

    /// Change the enabled status of the specified |command_id|. Returns true on
    /// success.
    /// CEF name: `SetEnabled`
    public func setEnabled(_ enabled: Bool, for commandID: CommandID) -> Bool {
        return cefObject.set_enabled(cefObjectPtr, commandID.toCEF(), enabled ? 1 : 0) != 0
    }

    /// Change the enabled status at the specified |index|. Returns true on
    /// success.
    /// CEF name: `SetEnabledAt`
    public func setEnabled(_ enabled: Bool, at index: Int) -> Bool {
        return cefObject.set_enabled_at(cefObjectPtr, Int32(index), enabled ? 1 : 0) != 0
    }
    
    /// Returns true if the specified |command_id| is checked. Only applies to
    /// check and radio items.
    /// CEF name: `IsChecked`
    public func isChecked(commandID: CommandID) -> Bool {
        return cefObject.is_checked(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    /// Returns true if the specified |index| is checked. Only applies to check
    /// and radio items.
    /// CEF name: `IsCheckedAt`
    public func isChecked(at index: Int) -> Bool {
        return cefObject.is_checked_at(cefObjectPtr, Int32(index)) != 0
    }
    
    /// Check the specified |command_id|. Only applies to check and radio items.
    /// Returns true on success.
    /// CEF name: `SetChecked`
    public func setChecked(_ checked: Bool, for commandID: CommandID) -> Bool {
        return cefObject.set_checked(cefObjectPtr, commandID.toCEF(), checked ? 1 : 0) != 0
    }
    
    /// Check the specified |index|. Only applies to check and radio items. Returns
    /// true on success.
    /// CEF name: `SetCheckedAt`
    public func setChecked(_ checked: Bool, at index: Int) -> Bool {
        return cefObject.set_checked_at(cefObjectPtr, Int32(index), checked ? 1 : 0) != 0
    }
    
    /// Returns true if the specified |command_id| has a keyboard accelerator
    /// assigned.
    /// CEF name: `HasAccelerator`
    public func hasAccelerator(for commandID: CommandID) -> Bool {
        return cefObject.has_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }
    
    /// Returns true if the specified |index| has a keyboard accelerator assigned.
    /// CEF name: `HasAcceleratorAt`
    public func hasAccelerator(at index: Int) -> Bool {
        return cefObject.has_accelerator_at(cefObjectPtr, Int32(index)) != 0
    }
    
    /// Set the keyboard accelerator for the specified |command_id|. |key_code| can
    /// be any virtual key or character value. Returns true on success.
    /// CEF name: `SetAccelerator`
    public func setAccelerator(_ accelerator: CEFMenuItemAccelerator, for commandID: CommandID) -> Bool {
        return cefObject.set_accelerator(cefObjectPtr,
                                         commandID.toCEF(),
                                         accelerator.keyCode,
                                         accelerator.shift ? 1 : 0,
                                         accelerator.control ? 1 : 0,
                                         accelerator.alt ? 1 : 0) != 0
    }

    /// Set the keyboard accelerator at the specified |index|. |key_code| can be
    /// any virtual key or character value. Returns true on success.
    /// CEF name: `SetAcceleratorAt`
    public func setAccelerator(_ accelerator: CEFMenuItemAccelerator, at index: Int) -> Bool {
        return cefObject.set_accelerator_at(cefObjectPtr,
                                            Int32(index),
                                            accelerator.keyCode,
                                            accelerator.shift ? 1 : 0,
                                            accelerator.control ? 1 : 0,
                                            accelerator.alt ? 1 : 0) != 0
    }
    
    /// Remove the keyboard accelerator for the specified |command_id|. Returns
    /// true on success.
    /// CEF name: `RemoveAccelerator`
    public func removeAccelerator(for commandID: CommandID) -> Bool {
        return cefObject.remove_accelerator(cefObjectPtr, commandID.toCEF()) != 0
    }

    /// Remove the keyboard accelerator at the specified |index|. Returns true on
    /// success.
    /// CEF name: `RemoveAcceleratorAt`
    public func removeAccelerator(at index: Int) -> Bool {
        return cefObject.remove_accelerator_at(cefObjectPtr, Int32(index)) != 0
    }
    
    /// Retrieves the keyboard accelerator for the specified |command_id|. Returns
    /// true on success.
    /// CEF name: `GetAccelerator`
    public func accelerator(for commandID: CommandID) -> CEFMenuItemAccelerator? {
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

    /// Retrieves the keyboard accelerator for the specified |index|. Returns true
    /// on success.
    /// CEF name: `GetAcceleratorAt`
    public func accelerator(at index: Int) -> CEFMenuItemAccelerator? {
        var keyCode: Int32 = 0
        var shift: Int32 = 0
        var control: Int32 = 0
        var alt: Int32 = 0
        guard cefObject.get_accelerator_at(cefObjectPtr, Int32(index), &keyCode, &shift, &control, &alt) != 0 else {
            return nil
        }
        
        return CEFMenuItemAccelerator(keyCode: keyCode,
                                      shift: shift != 0,
                                      control: control != 0,
                                      alt: alt != 0)
    }
    
}
