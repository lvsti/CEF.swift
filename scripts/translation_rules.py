#!/usr/bin/python

abbreviations = [
    'cef', 'http', 'https', 'ssl', 'url', 'uri', 'json', 'html', 'xhtml', 'v8', 'dom',
    'cdata', 'utf8', 'utf16le', 'utf16be', 'ascii', 'io', 'ui', 'db', '5xx', 'xhr',
    'cmy', 'cmyk', 'kcmy', 'rgb', 'rgba', 'bgra', 'rgb16', 'hp', 'rfc', 'id', 'js', 'xml', 'pdf',
    'ev', 'ct', 'sha1', 'csp', 'cdm', 'com'
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
    'cef_sslstatus_t': 'CEFSSLStatus',
    'cef_x509cert_principal_t': 'CEFX509CertPrincipal',
    'cef_x509certificate_t': 'CEFX509Certificate',

    # handlers
    'cef_urlrequest_client_t': 'CEFURLRequestClient',
    'cef_v8accessor_t': 'CEFV8Accessor',
    'cef_v8handler_t': 'CEFV8Handler',
    'cef_domvisitor_t': 'CEFDOMVisitor',
    'cef_jsdialog_handler_t': 'CEFJSDialogHandler',
    'cef_v8interceptor_t': 'CEFV8Interceptor',
    'cef_v8array_buffer_release_callback_t': 'CEFV8ArrayBufferReleaseCallback'
}

entryname_overrides = {
    'RT_SUB_FRAME': 'subframe',
    'RT_STYLESHEET': 'styleSheet',
    'RT_SUB_RESOURCE': 'subresource',
    'COLOR_MODEL_CMY_K': 'cmyPlusK',
    'COLOR_MODEL_COLORMODE_COLOR': 'colorModeColor',
    'COLOR_MODEL_COLORMODE_MONOCHROME': 'colorModeMonochrome',
    'COLOR_MODEL_PRINTOUTMODE_NORMAL': 'printoutModeNormal',
    'COLOR_MODEL_PRINTOUTMODE_NORMAL_GRAY': 'printoutModeNormalGray',
    'COLOR_MODEL_PROCESSCOLORMODEL_CMYK': 'processColorModelCMYK',
    'COLOR_MODEL_PROCESSCOLORMODEL_GREYSCALE': 'processColorModelGrayscale',
    'COLOR_MODEL_PROCESSCOLORMODEL_RGB': 'processColorModelRGB',
    'CT_IBEAM': 'iBeam',
    'CT_EASTRESIZE': 'eastResize',
    'CT_NORTHRESIZE': 'northResize',
    'CT_NORTHEASTRESIZE': 'neResize',
    'CT_NORTHWESTRESIZE': 'nwResize',
    'CT_SOUTHRESIZE': 'southResize',
    'CT_SOUTHEASTRESIZE': 'seResize',
    'CT_SOUTHWESTRESIZE': 'swResize',
    'CT_WESTRESIZE': 'westResize',
    'CT_NORTHSOUTHRESIZE': 'nsResize',
    'CT_EASTWESTRESIZE': 'ewResize',
    'CT_NORTHEASTSOUTHWESTRESIZE': 'neswResize',
    'CT_NORTHWESTSOUTHEASTRESIZE': 'nwseResize',
    'CT_COLUMNRESIZE': 'columnResize',
    'CT_ROWRESIZE': 'rowResize',
    'CT_MIDDLEPANNING': 'middlePanning',
    'CT_EASTPANNING': 'eastPanning',
    'CT_NORTHPANNING': 'northPanning',
    'CT_NORTHEASTPANNING': 'nePanning',
    'CT_NORTHWESTPANNING': 'nwPanning',
    'CT_SOUTHPANNING': 'southPanning',
    'CT_SOUTHEASTPANNING': 'sePanning',
    'CT_SOUTHWESTPANNING': 'swPanning',
    'CT_WESTPANNING': 'westPanning',
    'CT_VERTICALTEXT': 'verticalText',
    'CT_CONTEXTMENU': 'contextMenu',
    'CT_NODROP': 'noDrop',
    'CT_NOTALLOWED': 'notAllowed',
    'CT_ZOOMIN': 'zoomIn',
    'CT_ZOOMOUT': 'zoomOut',
    'V8_PROPERTY_ATTRIBUTE_READONLY': 'readOnly',
    'V8_PROPERTY_ATTRIBUTE_DONTENUM': 'dontEnumerate',
    'V8_PROPERTY_ATTRIBUTE_DONTDELETE': 'dontDelete',
    'MENU_ID_RELOAD_NOCACHE': 'reloadNoCache',
    'MENU_ID_STOPLOAD': 'stopLoad',
    'KEYEVENT_RAWKEYDOWN': 'rawKeyDown',
    'KEYEVENT_KEYDOWN': 'keyDown',
    'KEYEVENT_KEYUP': 'keyUp',
    'DOM_EVENT_CATEGORY_XMLHTTPREQUEST_PROGRESS': 'xmlHTTPRequestProgress',
    'ST_LOCALSTORAGE': 'localStorage',
    'ST_SESSIONSTORAGE': 'sessionStorage',
    'SCALE_FACTOR_100P': 'scale100Percent',
    'SCALE_FACTOR_125P': 'scale125Percent',
    'SCALE_FACTOR_133P': 'scale133Percent',
    'SCALE_FACTOR_140P': 'scale140Percent',
    'SCALE_FACTOR_150P': 'scale150Percent',
    'SCALE_FACTOR_180P': 'scale180Percent',
    'SCALE_FACTOR_200P': 'scale200Percent',
    'SCALE_FACTOR_250P': 'scale250Percent',
    'SCALE_FACTOR_300P': 'scale300Percent',
    'CERT_STATUS_IS_EV': 'isEV',
    'CERT_STATUS_REV_CHECKING_ENABLED': 'revocationCheckingEnabled',
    'CEF_MENU_ANCHOR_TOPLEFT': 'topLeft',
    'CEF_MENU_ANCHOR_TOPRIGHT': 'topRight',
    'CEF_MENU_ANCHOR_BOTTOMCENTER': 'bottomCenter',
    'DRAG_OPERATION_EVERY': 'any',
    'RV_CONTINUE': 'continueNow',
}

entrytype_tocef_cast_overrides = {
    'cef_errorcode_t': 'Int32',
    'cef_duplex_mode_t': 'Int32'
}

entryvalue_overrides = {
    'UINT_MAX' : 'UInt32.max',
}

cef_enums = [
    # branch 2357
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
    'cef_scale_factor_t',
    'cef_plugin_policy_t',
    
    # branch 2526
    'cef_referrer_policy_t',
    'cef_response_filter_status_t',
    
    # branch 2704
    'cef_color_type_t',
    'cef_alpha_type_t',
    'cef_text_style_t',
    'cef_main_axis_alignment_t',
    'cef_cross_axis_alignment_t',
    'cef_button_state_t',
    'cef_horizontal_alignment_t',
    'cef_menu_anchor_position_t',
    
    # branch 2840
    'cef_cdm_registration_error_t',
    'cef_ssl_version_t',
    
    # branch 2883
    'cef_thread_priority_t',
    'cef_message_loop_type_t',
    'cef_com_init_mode_t',
    
    # branch 2987
    'cef_menu_color_type_t'
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
    'cef_json_writer_options_t',
    
    # branch 2526
    'cef_cert_status_t',
    
    # branch 2840
    'cef_ssl_content_status_t'
]

cef_const_collections = {
    'cef_menu_id_t': 'Int32',
    'cef_errorcode_t': 'Int32'
}

cef_hybrid_enums = [
    'cef_transition_type_t',
    'cef_file_dialog_mode_t',

    # branch 2454
    'cef_pdf_print_margin_type_t'
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

swift_keywords = [
    'default',
    'private',
    'public'
]
