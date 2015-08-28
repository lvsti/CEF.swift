//
//  CEFSchemeHandlerFactory+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_scheme.h.
//

import Foundation

extension cef_scheme_handler_factory_t: CEFObject {}

typealias CEFSchemeHandlerFactoryMarshaller = CEFMarshaller<CEFSchemeHandlerFactory, cef_scheme_handler_factory_t>

extension CEFSchemeHandlerFactory {
    func toCEF() -> UnsafeMutablePointer<cef_scheme_handler_factory_t> {
        return CEFSchemeHandlerFactoryMarshaller.pass(self)
    }
}

extension cef_scheme_handler_factory_t: CEFCallbackMarshalling {
    mutating func marshalCallbacks() {
        create = CEFSchemeHandlerFactory_create
    }
}
