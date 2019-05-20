//
//  cef_message_router_capi.cpp
//  libcef_dll_wrapper_capi
//
//  Created by Tamas Lustyik on 2017. 11. 17..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

#include "cef_message_router_capi.h"
#include "include/wrapper/cef_message_router.h"

#include "include/capi/cef_browser_capi.h"
#include "include/capi/cef_frame_capi.h"
#include "include/capi/cef_v8_capi.h"

#include "libcef_dll/cpptoc/cpptoc_ref_counted.h"

#include "libcef_dll/ctocpp/browser_ctocpp.h"
#include "libcef_dll/ctocpp/frame_ctocpp.h"
#include "libcef_dll/ctocpp/process_message_ctocpp.h"
#include "libcef_dll/ctocpp/v8context_ctocpp.h"

#include "cef_wrapper_types_ext.h"

template <>
CefWrapperType CefCToCppRefCounted<CefBrowserCToCpp, CefBrowser, cef_browser_t>::kWrapperType;

template <>
CefWrapperType CefCToCppRefCounted<CefV8ContextCToCpp, CefV8Context, _cef_v8context_t>::kWrapperType;

template <>
CefWrapperType CefCToCppRefCounted<CefFrameCToCpp, CefFrame, _cef_frame_t>::kWrapperType;

template <>
CefWrapperType CefCToCppRefCounted<CefProcessMessageCToCpp, CefProcessMessage, _cef_process_message_t>::kWrapperType;


class CefMessageRouterRendererSideCppToC:
    public CefCppToCRefCounted<CefMessageRouterRendererSideCppToC,
                               CefMessageRouterRendererSide,
                               cef_message_router_renderer_side_t> {
public:
    CefMessageRouterRendererSideCppToC();
};

namespace {
    
    int message_router_renderer_side_get_pending_count(struct _cef_message_router_renderer_side_t* self,
                                                       struct _cef_browser_t* browser,
                                                       struct _cef_v8context_t* context) {
        if (!self) { return 0; }
        if (!browser) { return 0; }
        if (!context) { return 0; }

        int retval = CefMessageRouterRendererSideCppToC::Get(self)->GetPendingCount(
            CefBrowserCToCpp::Wrap(browser),
            CefV8ContextCToCpp::Wrap(context)
        );
        
        return retval;
    }

    void message_router_renderer_side_on_context_created(struct _cef_message_router_renderer_side_t* self,
                                                         struct _cef_browser_t* browser,
                                                         struct _cef_frame_t* frame,
                                                         struct _cef_v8context_t* context) {
        if (!self) { return; }
        if (!browser) { return; }
        if (!frame) { return; }
        if (!context) { return; }
        
        CefMessageRouterRendererSideCppToC::Get(self)->OnContextCreated(
            CefBrowserCToCpp::Wrap(browser),
            CefFrameCToCpp::Wrap(frame),
            CefV8ContextCToCpp::Wrap(context)
        );
    }
    
    ///
    // Call from CefRenderProcessHandler::OnContextReleased. Any pending queries
    // associated with the released context will be canceled and
    // Handler::OnQueryCanceled will be called in the browser process.
    ///
    void message_router_renderer_side_on_context_released(struct _cef_message_router_renderer_side_t* self,
                                                          struct _cef_browser_t* browser,
                                                          struct _cef_frame_t* frame,
                                                          struct _cef_v8context_t* context) {
        if (!self) { return; }
        if (!browser) { return; }
        if (!frame) { return; }
        if (!context) { return; }
        
        CefMessageRouterRendererSideCppToC::Get(self)->OnContextReleased(
            CefBrowserCToCpp::Wrap(browser),
            CefFrameCToCpp::Wrap(frame),
            CefV8ContextCToCpp::Wrap(context)
        );
    }
    
    ///
    // Call from CefRenderProcessHandler::OnProcessMessageReceived. Returns true
    // if the message is handled by this router or false otherwise.
    ///
    int message_router_renderer_side_on_process_message_received(struct _cef_message_router_renderer_side_t* self,
                                                                 struct _cef_browser_t* browser,
                                                                 cef_process_id_t source_process,
                                                                 struct _cef_process_message_t* message) {
        if (!self) { return 0; }
        if (!browser) { return 0; }
        if (!message) { return 0; }
        
        int retval = CefMessageRouterRendererSideCppToC::Get(self)->OnProcessMessageReceived(
            CefBrowserCToCpp::Wrap(browser),
            source_process,
            CefProcessMessageCToCpp::Wrap(message)
        );
        
        return retval;
    }

}

cef_message_router_renderer_side_t* cef_message_router_renderer_side_create(const struct _cef_message_router_config_t* config) {
    CefMessageRouterConfig cppConfig = CefMessageRouterConfig();
    cppConfig.js_query_function.FromString(config->js_query_function.str, config->js_query_function.length, true);
    cppConfig.js_query_function.FromString(config->js_query_function.str, config->js_query_function.length, true);
    
    CefRefPtr<CefMessageRouterRendererSide> obj = CefMessageRouterRendererSide::Create(cppConfig);
    return CefMessageRouterRendererSideCppToC::Wrap(obj);
}

CefMessageRouterRendererSideCppToC::CefMessageRouterRendererSideCppToC() {
    GetStruct()->get_pending_count = message_router_renderer_side_get_pending_count;
    GetStruct()->on_context_created = message_router_renderer_side_on_context_created;
    GetStruct()->on_context_released = message_router_renderer_side_on_context_released;
    GetStruct()->on_process_message_received = message_router_renderer_side_on_process_message_received;
}

template <>
CefRefPtr<CefMessageRouterRendererSide> CefCppToCRefCounted<
    CefMessageRouterRendererSideCppToC,
    CefMessageRouterRendererSide,
    cef_message_router_renderer_side_t>::UnwrapDerived(CefWrapperType type,
                                                       cef_message_router_renderer_side_t* s) {
    NOTREACHED() << "Unexpected class type: " << type;
    return NULL;
}

template <>
CefWrapperType CefCppToCRefCounted<CefMessageRouterRendererSideCppToC,
                                   CefMessageRouterRendererSide,
                                   cef_message_router_renderer_side_t>::kWrapperType =
    static_cast<CefWrapperType>(WT_EXT_MESSAGE_ROUTER_RENDERER_SIDE);

