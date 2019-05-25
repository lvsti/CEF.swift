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

#include <unordered_map>
#include <mutex>

template <>
CefWrapperType CefCToCppRefCounted<CefBrowserCToCpp, CefBrowser, cef_browser_t>::kWrapperType;

template <>
CefWrapperType CefCToCppRefCounted<CefV8ContextCToCpp, CefV8Context, _cef_v8context_t>::kWrapperType;

template <>
CefWrapperType CefCToCppRefCounted<CefFrameCToCpp, CefFrame, _cef_frame_t>::kWrapperType;

template <>
CefWrapperType CefCToCppRefCounted<CefProcessMessageCToCpp, CefProcessMessage, _cef_process_message_t>::kWrapperType;

// MARK: - CefMessageRouterBrowserSideCallbackCppToC

class CefMessageRouterBrowserSideCallbackCppToC:
    public CefCppToCRefCounted<CefMessageRouterBrowserSideCallbackCppToC,
                               CefMessageRouterBrowserSide::Callback,
                               cef_message_router_browser_side_callback_t> {
public:
    CefMessageRouterBrowserSideCallbackCppToC();
};

namespace {

    void message_router_browser_side_callback_success(struct _cef_message_router_browser_side_callback_t* self,
                                                      const cef_string_t* response) {
        if (!self) { return; }
        if (!response) { return; }

        CefMessageRouterBrowserSideCallbackCppToC::Get(self)->Success(CefString(response));
    }
    
    void message_router_browser_side_callback_failure(struct _cef_message_router_browser_side_callback_t* self,
                                                      int error_code,
                                                      const cef_string_t* error_message) {
        if (!self) { return; }
        if (!error_message) { return; }

        CefMessageRouterBrowserSideCallbackCppToC::Get(self)->Failure(error_code, CefString(error_message));
    }
    
}

CefMessageRouterBrowserSideCallbackCppToC::CefMessageRouterBrowserSideCallbackCppToC() {
    GetStruct()->success = message_router_browser_side_callback_success;
    GetStruct()->failure = message_router_browser_side_callback_failure;
}

template <>
CefRefPtr<CefMessageRouterBrowserSide::Callback> CefCppToCRefCounted<
    CefMessageRouterBrowserSideCallbackCppToC,
    CefMessageRouterBrowserSide::Callback,
    cef_message_router_browser_side_callback_t>::UnwrapDerived(CefWrapperType type,
                                                               cef_message_router_browser_side_callback_t* s) {
    NOTREACHED() << "Unexpected class type: " << type;
    return NULL;
}

template <>
CefWrapperType CefCppToCRefCounted<CefMessageRouterBrowserSideCallbackCppToC,
                                   CefMessageRouterBrowserSide::Callback,
                                   cef_message_router_browser_side_callback_t>::kWrapperType =
    static_cast<CefWrapperType>(WT_EXT_MESSAGE_ROUTER_BROWSER_SIDE_CALLBACK);

// MARK: - CefMessageRouterBrowserSideCppToC

class ForwardingHandler;

class CefMessageRouterBrowserSideCppToC:
    public CefCppToCRefCounted<CefMessageRouterBrowserSideCppToC,
                               CefMessageRouterBrowserSide,
                               cef_message_router_browser_side_t> {
public:
    CefMessageRouterBrowserSideCppToC();
};

static std::unordered_map<cef_message_router_browser_side_handler_t*, ForwardingHandler*> g_browserSideHandlers;
static std::mutex g_browserSideHandlersMutex;

class ForwardingHandler: public CefMessageRouterBrowserSide::Handler {
public:
    ForwardingHandler(cef_message_router_browser_side_handler_t* target): _target(target) {
    }
    
    virtual bool OnQuery(CefRefPtr<CefBrowser> browser,
                         CefRefPtr<CefFrame> frame,
                         int64 query_id,
                         const CefString& request,
                         bool persistent,
                         CefRefPtr<Callback> callback) override {
        return _target->on_query(_target,
                                 CefBrowserCToCpp::Unwrap(browser),
                                 CefFrameCToCpp::Unwrap(frame),
                                 query_id,
                                 request.GetStruct(),
                                 persistent,
                                 CefMessageRouterBrowserSideCallbackCppToC::Wrap(callback));
    }
    
    virtual void OnQueryCanceled(CefRefPtr<CefBrowser> browser,
                                 CefRefPtr<CefFrame> frame,
                                 int64 query_id) override {
        _target->on_query_canceled(_target,
                                   CefBrowserCToCpp::Unwrap(browser),
                                   CefFrameCToCpp::Unwrap(frame),
                                   query_id);
    }
    
private:
    cef_message_router_browser_side_handler_t* _target;
};

namespace {
    
    int message_router_browser_side_add_handler(struct _cef_message_router_browser_side_t* self,
                                                struct _cef_message_router_browser_side_handler_t* handler,
                                                int first) {
        if (!self) { return 0; }
        if (!handler) { return 0; }
        
        std::lock_guard<std::mutex> guard(g_browserSideHandlersMutex);
        
        auto it = g_browserSideHandlers.find(handler);
        if (it != g_browserSideHandlers.end()) {
            return 0;
        }
        
        auto cppHandler = new ForwardingHandler(handler);
        int retval = CefMessageRouterBrowserSideCppToC::Get(self)->AddHandler(cppHandler, first);
        if (retval) {
            g_browserSideHandlers.insert(std::make_pair(handler, cppHandler));
        }
        
        return retval;
    }

    int message_router_browser_side_remove_handler(struct _cef_message_router_browser_side_t* self,
                                                    struct _cef_message_router_browser_side_handler_t* handler) {
        if (!self) { return 0; }
        if (!handler) { return 0; }

        std::lock_guard<std::mutex> guard(g_browserSideHandlersMutex);

        auto it = g_browserSideHandlers.find(handler);
        if (it == g_browserSideHandlers.end()) {
            return 0;
        }

        auto cppHandler = it->second;
        int retval = CefMessageRouterBrowserSideCppToC::Get(self)->RemoveHandler(cppHandler);
        if (retval) {
            g_browserSideHandlers.erase(it);
        }
        
        return retval;
    }
    
    void message_router_browser_side_cancel_pending(struct _cef_message_router_browser_side_t* self,
                                                    struct _cef_browser_t* browser,
                                                    struct _cef_message_router_browser_side_handler_t* handler) {
        if (!self) { return; }
        if (!browser) { return; }
        if (!handler) { return; }

        std::lock_guard<std::mutex> guard(g_browserSideHandlersMutex);

        auto it = g_browserSideHandlers.find(handler);
        if (it == g_browserSideHandlers.end()) {
            return;
        }

        auto cppHandler = it->second;

        CefMessageRouterBrowserSideCppToC::Get(self)->CancelPending(
            CefBrowserCToCpp::Wrap(browser),
            cppHandler
        );
    }
    
    int message_router_browser_side_get_pending_count(struct _cef_message_router_browser_side_t* self,
                                                      struct _cef_browser_t* browser,
                                                      struct _cef_message_router_browser_side_handler_t* handler) {
        if (!self) { return 0; }

        std::lock_guard<std::mutex> guard(g_browserSideHandlersMutex);

        CefMessageRouterBrowserSide::Handler* cppHandler = nullptr;
        if (handler) {
            auto it = g_browserSideHandlers.find(handler);
            if (it == g_browserSideHandlers.end()) {
                return 0;
            }
            
            cppHandler = it->second;
        }

        int retval = CefMessageRouterBrowserSideCppToC::Get(self)->GetPendingCount(
            CefBrowserCToCpp::Wrap(browser),
            cppHandler
        );
        
        return retval;
    }
    
    void message_router_browser_side_on_before_close(struct _cef_message_router_browser_side_t* self,
                                                     struct _cef_browser_t* browser) {
        if (!self) { return; }
        if (!browser) { return; }
        
        CefMessageRouterBrowserSideCppToC::Get(self)->OnBeforeClose(CefBrowserCToCpp::Wrap(browser));
    }

    void message_router_browser_side_on_render_process_terminated(struct _cef_message_router_browser_side_t* self,
                                                                  struct _cef_browser_t* browser) {
        if (!self) { return; }
        if (!browser) { return; }
        
        CefMessageRouterBrowserSideCppToC::Get(self)->OnRenderProcessTerminated(CefBrowserCToCpp::Wrap(browser));
    }
    
    void message_router_browser_side_on_before_browse(struct _cef_message_router_browser_side_t* self,
                                                      struct _cef_browser_t* browser,
                                                      struct _cef_frame_t* frame) {
        if (!self) { return; }
        if (!browser) { return; }
        if (!frame) { return; }
        
        CefMessageRouterBrowserSideCppToC::Get(self)->OnBeforeBrowse(
            CefBrowserCToCpp::Wrap(browser),
            CefFrameCToCpp::Wrap(frame)
        );
    }
    
    int message_router_browser_side_on_process_message_received(struct _cef_message_router_browser_side_t* self,
                                                                struct _cef_browser_t* browser,
                                                                cef_process_id_t source_process,
                                                                struct _cef_process_message_t* message) {
        if (!self) { return 0; }
        if (!browser) { return 0; }
        if (!message) { return 0; }
        
        int retval = CefMessageRouterBrowserSideCppToC::Get(self)->OnProcessMessageReceived(
            CefBrowserCToCpp::Wrap(browser),
            source_process,
            CefProcessMessageCToCpp::Wrap(message)
        );
        
        return retval;
    }

}

cef_message_router_browser_side_t* cef_message_router_browser_side_create(const struct _cef_message_router_config_t* config) {
    CefMessageRouterConfig cppConfig = CefMessageRouterConfig();
    cppConfig.js_query_function.FromString(config->js_query_function.str, config->js_query_function.length, true);
    cppConfig.js_query_function.FromString(config->js_query_function.str, config->js_query_function.length, true);
    
    CefRefPtr<CefMessageRouterBrowserSide> obj = CefMessageRouterBrowserSide::Create(cppConfig);
    return CefMessageRouterBrowserSideCppToC::Wrap(obj);
}

CefMessageRouterBrowserSideCppToC::CefMessageRouterBrowserSideCppToC() {
    GetStruct()->add_handler = message_router_browser_side_add_handler;
    GetStruct()->remove_handler = message_router_browser_side_remove_handler;
    GetStruct()->cancel_pending = message_router_browser_side_cancel_pending;
    GetStruct()->get_pending_count = message_router_browser_side_get_pending_count;
    GetStruct()->on_before_close = message_router_browser_side_on_before_close;
    GetStruct()->on_render_process_terminated = message_router_browser_side_on_render_process_terminated;
    GetStruct()->on_before_browse = message_router_browser_side_on_before_browse;
    GetStruct()->on_process_message_received = message_router_browser_side_on_process_message_received;
}

template <>
CefRefPtr<CefMessageRouterBrowserSide> CefCppToCRefCounted<
    CefMessageRouterBrowserSideCppToC,
    CefMessageRouterBrowserSide,
    cef_message_router_browser_side_t>::UnwrapDerived(CefWrapperType type,
                                                      cef_message_router_browser_side_t* s) {
    NOTREACHED() << "Unexpected class type: " << type;
    return NULL;
}

template <>
CefWrapperType CefCppToCRefCounted<CefMessageRouterBrowserSideCppToC,
                                   CefMessageRouterBrowserSide,
                                   cef_message_router_browser_side_t>::kWrapperType =
    static_cast<CefWrapperType>(WT_EXT_MESSAGE_ROUTER_BROWSER_SIDE);


// MARK: - CefMessageRouterRendererSideCppToC

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

