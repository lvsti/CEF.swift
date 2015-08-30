#!/usr/bin/python

abbreviations = [
    'cef', 'http', 'https', 'ssl', 'url', 'uri', 'json', 'html', 'xhtml', 'v8', 'dom',
    'cdata', 'utf8', 'utf16le', 'utf16be', 'ascii', 'io', 'ui', 'db', '5xx', 'xhr',
    'cmy', 'cmyk', 'kcmy', 'rgb', 'rgba', 'rgb16', 'hp', 'rfc', 'id', 'js', 'xml'
]

typename_overrides = {
    # enums
    'cef_v8_accesscontrol_t': 'CEFV8AccessControl',
    'cef_v8_propertyattribute_t': 'CEFV8PropertyAttribute',
    'cef_postdataelement_type_t': 'CEFPOSTDataElementType',
    'cef_urlrequest_flags_t': 'CEFURLRequestFlags',
    'cef_urlrequest_status_t': 'CEFURLRequestStatus',
    'cef_jsdialog_type_t': 'CEFJSDialogType',
    'cef_errorcode_t': 'CEFErrorCode',
    
    # proxies
    'cef_urlrequest_t': 'CEFURLRequest',
    'cef_v8value_t': 'CEFV8Value',
    'cef_v8stack_trace_t': 'CEFV8StackTrace',
    'cef_v8stack_frame_t': 'CEFV8StackFrame',
    'cef_v8exception_t': 'CEFV8Exception',
    'cef_v8context_t': 'CEFV8Context',
    'cef_sslinfo_t': 'CEFSSLInfo',
    'cef_sslcert_principal_t': 'CEFSSLCertPrincipal',
    'cef_jsdialog_callback_t': 'CEFJSDialogCallback',
    'cef_domnode_t': 'CEFDOMNode',
    'cef_domdocument_t': 'CEFDOMDocument',
    'cef_post_data_element_t': 'CEFPOSTDataElement',
    'cef_post_data_t': 'CEFPOSTData',

    # handlers
    'cef_urlrequest_client_t': 'CEFURLRequestClient',
    'cef_v8accessor_t': 'CEFV8Accessor',
    'cef_v8handler_t': 'CEFV8Handler',
    'cef_domvisitor_t': 'CEFDOMVisitor',
    'cef_jsdialog_handler_t': 'CEFJSDialogHandler'
}

entryname_overrides = {
    'RT_SUB_FRAME': 'Subframe',
    'RT_STYLESHEET': 'StyleSheet',
    'RT_SUB_RESOURCE': 'Subresource',
    'COLOR_MODEL_CMY_K': 'CMYPlusK',
    'COLOR_MODEL_COLORMODE_COLOR': 'ColorModeColor',
    'COLOR_MODEL_COLORMODE_MONOCHROME': 'ColorModeMonochrome',
    'COLOR_MODEL_PRINTOUTMODE_NORMAL': 'PrintoutModeNormal',
    'COLOR_MODEL_PRINTOUTMODE_NORMAL_GRAY': 'PrintoutModeNormalGray',
    'COLOR_MODEL_PROCESSCOLORMODEL_CMYK': 'ProcessColorModelCMYK',
    'COLOR_MODEL_PROCESSCOLORMODEL_GREYSCALE': 'ProcessColorModelGrayscale',
    'COLOR_MODEL_PROCESSCOLORMODEL_RGB': 'ProcessColorModelRGB',
    'CT_IBEAM': 'IBeam',
    'CT_EASTRESIZE': 'EastResize',
    'CT_NORTHRESIZE': 'NorthResize',
    'CT_NORTHEASTRESIZE': 'NEResize',
    'CT_NORTHWESTRESIZE': 'NWResize',
    'CT_SOUTHRESIZE': 'SouthResize',
    'CT_SOUTHEASTRESIZE': 'SEResize',
    'CT_SOUTHWESTRESIZE': 'SWResize',
    'CT_WESTRESIZE': 'WestResize',
    'CT_NORTHSOUTHRESIZE': 'NSResize',
    'CT_EASTWESTRESIZE': 'EWResize',
    'CT_NORTHEASTSOUTHWESTRESIZE': 'NESWResize',
    'CT_NORTHWESTSOUTHEASTRESIZE': 'NWSEResize',
    'CT_COLUMNRESIZE': 'ColumnResize',
    'CT_ROWRESIZE': 'RowResize',
    'CT_MIDDLEPANNING': 'MiddlePanning',
    'CT_EASTPANNING': 'EastPanning',
    'CT_NORTHPANNING': 'NorthPanning',
    'CT_NORTHEASTPANNING': 'NEPanning',
    'CT_NORTHWESTPANNING': 'NWPanning',
    'CT_SOUTHPANNING': 'SouthPanning',
    'CT_SOUTHEASTPANNING': 'SEPanning',
    'CT_SOUTHWESTPANNING': 'SWPanning',
    'CT_WESTPANNING': 'WestPanning',
    'CT_VERTICALTEXT': 'VerticalText',
    'CT_CONTEXTMENU': 'ContextMenu',
    'CT_NODROP': 'NoDrop',
    'CT_NOTALLOWED': 'NotAllowed',
    'CT_ZOOMIN': 'ZoomIn',
    'CT_ZOOMOUT': 'ZoomOut',
    'V8_PROPERTY_ATTRIBUTE_READONLY': 'ReadOnly',
    'V8_PROPERTY_ATTRIBUTE_DONTENUM': 'DontEnumerate',
    'V8_PROPERTY_ATTRIBUTE_DONTDELETE': 'DontDelete',
    'MENU_ID_RELOAD_NOCACHE': 'ReloadNoCache',
    'MENU_ID_STOPLOAD': 'StopLoad',
    'KEYEVENT_RAWKEYDOWN': 'RawKeyDown',
    'KEYEVENT_KEYDOWN': 'KeyDown',
    'KEYEVENT_KEYUP': 'KeyUp',
    'DOM_EVENT_CATEGORY_XMLHTTPREQUEST_PROGRESS': 'XMLHTTPRequestProgress',
    'ST_LOCALSTORAGE': 'LocalStorage',
    'ST_SESSIONSTORAGE': 'SessionStorage'
}

entrytype_tocef_cast_overrides = {
    'cef_errorcode_t': 'Int32',
    'cef_duplex_mode_t': 'Int32'
}

entryvalue_overrides = {
    'UINT_MAX' : 'UInt32.max',
}

cef_enums = [
    'cef_log_severity_t',
    'cef_state_t',
    'cef_return_value_t',
    'cef_termination_status_t',
    'cef_path_key_t',
    'cef_storage_type_t',
    'cef_window_open_disposition_t',
    'cef_postdataelement_type_t',
    'cef_resource_type_t',
    'cef_urlrequest_status_t',
    'cef_process_id_t',
    'cef_thread_id_t',
    'cef_value_type_t',
    'cef_jsdialog_type_t',
    'cef_mouse_button_type_t',
    'cef_paint_element_type_t',
    'cef_menu_item_type_t',
    'cef_context_menu_media_type_t',
    'cef_key_event_type_t',
    'cef_focus_source_t',
    'cef_navigation_type_t',
    'cef_xml_encoding_type_t',
    'cef_xml_node_type_t',
    'cef_dom_document_type_t',
    'cef_dom_event_phase_t',
    'cef_dom_node_type_t',
    'cef_geoposition_error_code_t',
    'cef_color_model_t',
    'cef_duplex_mode_t',
    'cef_cursor_type_t',
    'cef_json_parser_error_t',
]

cef_option_sets = [
    'cef_drag_operations_mask_t',
    'cef_v8_accesscontrol_t',
    'cef_v8_propertyattribute_t',
    'cef_urlrequest_flags_t',
    'cef_event_flags_t',
    'cef_context_menu_type_flags_t',
    'cef_context_menu_media_state_flags_t',
    'cef_context_menu_edit_state_flags_t',
    'cef_dom_event_category_t',
    'cef_uri_unescape_rule_t',
    'cef_json_parser_options_t',
    'cef_json_writer_options_t'
]

cef_const_collections = {
    'cef_menu_id_t': 'Int32',
    'cef_errorcode_t': 'Int32'
}

cef_hybrid_enums = [
    'cef_transition_type_t',
    'cef_file_dialog_mode_t',
]

pod_type_map = {
    'bool': 'Bool',
    'int16': 'Int16',
    'uint16': 'UInt16',
    'int': 'Int32',
    'unsigned int': 'UInt32',
    'int64': 'Int64',
    'uint64': 'UInt64'
}