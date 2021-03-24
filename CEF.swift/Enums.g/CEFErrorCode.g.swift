//
//  CEFErrorCode.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported error code values.
/// CEF name: `cef_errorcode_t`.
public struct CEFErrorCode: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }


    /// An asynchronous IO operation is not yet complete.  This usually does not
    /// indicate a fatal error.  Typically this error will be generated as a
    /// notification to wait for some external notification that the IO operation
    /// finally completed.
    /// CEF name: `ERR_IO_PENDING`.
    public static let ioPending = CEFErrorCode(rawValue: -1)

    /// A generic failure occurred.
    /// CEF name: `ERR_FAILED`.
    public static let failed = CEFErrorCode(rawValue: -2)

    /// An operation was aborted (due to user action).
    /// CEF name: `ERR_ABORTED`.
    public static let aborted = CEFErrorCode(rawValue: -3)

    /// An argument to the function is incorrect.
    /// CEF name: `ERR_INVALID_ARGUMENT`.
    public static let invalidArgument = CEFErrorCode(rawValue: -4)

    /// The handle or file descriptor is invalid.
    /// CEF name: `ERR_INVALID_HANDLE`.
    public static let invalidHandle = CEFErrorCode(rawValue: -5)

    /// The file or directory cannot be found.
    /// CEF name: `ERR_FILE_NOT_FOUND`.
    public static let fileNotFound = CEFErrorCode(rawValue: -6)

    /// An operation timed out.
    /// CEF name: `ERR_TIMED_OUT`.
    public static let timedOut = CEFErrorCode(rawValue: -7)

    /// The file is too large.
    /// CEF name: `ERR_FILE_TOO_BIG`.
    public static let fileTooBig = CEFErrorCode(rawValue: -8)

    /// An unexpected error.  This may be caused by a programming mistake or an
    /// invalid assumption.
    /// CEF name: `ERR_UNEXPECTED`.
    public static let unexpected = CEFErrorCode(rawValue: -9)

    /// Permission to access a resource, other than the network, was denied.
    /// CEF name: `ERR_ACCESS_DENIED`.
    public static let accessDenied = CEFErrorCode(rawValue: -10)

    /// The operation failed because of unimplemented functionality.
    /// CEF name: `ERR_NOT_IMPLEMENTED`.
    public static let notImplemented = CEFErrorCode(rawValue: -11)

    /// There were not enough resources to complete the operation.
    /// CEF name: `ERR_INSUFFICIENT_RESOURCES`.
    public static let insufficientResources = CEFErrorCode(rawValue: -12)

    /// Memory allocation failed.
    /// CEF name: `ERR_OUT_OF_MEMORY`.
    public static let outOfMemory = CEFErrorCode(rawValue: -13)

    /// The file upload failed because the file's modification time was different
    /// from the expectation.
    /// CEF name: `ERR_UPLOAD_FILE_CHANGED`.
    public static let uploadFileChanged = CEFErrorCode(rawValue: -14)

    /// The socket is not connected.
    /// CEF name: `ERR_SOCKET_NOT_CONNECTED`.
    public static let socketNotConnected = CEFErrorCode(rawValue: -15)

    /// The file already exists.
    /// CEF name: `ERR_FILE_EXISTS`.
    public static let fileExists = CEFErrorCode(rawValue: -16)

    /// The path or file name is too long.
    /// CEF name: `ERR_FILE_PATH_TOO_LONG`.
    public static let filePathTooLong = CEFErrorCode(rawValue: -17)

    /// Not enough room left on the disk.
    /// CEF name: `ERR_FILE_NO_SPACE`.
    public static let fileNoSpace = CEFErrorCode(rawValue: -18)

    /// The file has a virus.
    /// CEF name: `ERR_FILE_VIRUS_INFECTED`.
    public static let fileVirusInfected = CEFErrorCode(rawValue: -19)

    /// The client chose to block the request.
    /// CEF name: `ERR_BLOCKED_BY_CLIENT`.
    public static let blockedByClient = CEFErrorCode(rawValue: -20)

    /// The network changed.
    /// CEF name: `ERR_NETWORK_CHANGED`.
    public static let networkChanged = CEFErrorCode(rawValue: -21)

    /// The request was blocked by the URL block list configured by the domain
    /// administrator.
    /// CEF name: `ERR_BLOCKED_BY_ADMINISTRATOR`.
    public static let blockedByAdministrator = CEFErrorCode(rawValue: -22)

    /// The socket is already connected.
    /// CEF name: `ERR_SOCKET_IS_CONNECTED`.
    public static let socketIsConnected = CEFErrorCode(rawValue: -23)

    /// The request was blocked because the forced reenrollment check is still
    /// pending. This error can only occur on ChromeOS.
    /// The error can be emitted by code in chrome/browser/policy/policy_helpers.cc.
    /// CEF name: `ERR_BLOCKED_ENROLLMENT_CHECK_PENDING`.
    public static let blockedEnrollmentCheckPending = CEFErrorCode(rawValue: -24)

    /// The upload failed because the upload stream needed to be re-read, due to a
    /// retry or a redirect, but the upload stream doesn't support that operation.
    /// CEF name: `ERR_UPLOAD_STREAM_REWIND_NOT_SUPPORTED`.
    public static let uploadStreamRewindNotSupported = CEFErrorCode(rawValue: -25)

    /// The request failed because the URLRequestContext is shutting down, or has
    /// been shut down.
    /// CEF name: `ERR_CONTEXT_SHUT_DOWN`.
    public static let contextShutDown = CEFErrorCode(rawValue: -26)

    /// The request failed because the response was delivered along with requirements
    /// which are not met ('X-Frame-Options' and 'Content-Security-Policy' ancestor
    /// checks and 'Cross-Origin-Resource-Policy', for instance).
    /// CEF name: `ERR_BLOCKED_BY_RESPONSE`.
    public static let blockedByResponse = CEFErrorCode(rawValue: -27)

    /// The request was blocked by system policy disallowing some or all cleartext
    /// requests. Used for NetworkSecurityPolicy on Android.
    /// CEF name: `ERR_CLEARTEXT_NOT_PERMITTED`.
    public static let cleartextNotPermitted = CEFErrorCode(rawValue: -29)

    /// The request was blocked by a Content Security Policy
    /// CEF name: `ERR_BLOCKED_BY_CSP`.
    public static let blockedByCSP = CEFErrorCode(rawValue: -30)

    /// The request was blocked because of no H/2 or QUIC session.
    /// CEF name: `ERR_H2_OR_QUIC_REQUIRED`.
    public static let h2OrQuicRequired = CEFErrorCode(rawValue: -31)

    /// A connection was closed (corresponding to a TCP FIN).
    /// CEF name: `ERR_CONNECTION_CLOSED`.
    public static let connectionClosed = CEFErrorCode(rawValue: -100)

    /// A connection was reset (corresponding to a TCP RST).
    /// CEF name: `ERR_CONNECTION_RESET`.
    public static let connectionReset = CEFErrorCode(rawValue: -101)

    /// A connection attempt was refused.
    /// CEF name: `ERR_CONNECTION_REFUSED`.
    public static let connectionRefused = CEFErrorCode(rawValue: -102)

    /// A connection timed out as a result of not receiving an ACK for data sent.
    /// This can include a FIN packet that did not get ACK'd.
    /// CEF name: `ERR_CONNECTION_ABORTED`.
    public static let connectionAborted = CEFErrorCode(rawValue: -103)

    /// A connection attempt failed.
    /// CEF name: `ERR_CONNECTION_FAILED`.
    public static let connectionFailed = CEFErrorCode(rawValue: -104)

    /// The host name could not be resolved.
    /// CEF name: `ERR_NAME_NOT_RESOLVED`.
    public static let nameNotResolved = CEFErrorCode(rawValue: -105)

    /// The Internet connection has been lost.
    /// CEF name: `ERR_INTERNET_DISCONNECTED`.
    public static let internetDisconnected = CEFErrorCode(rawValue: -106)

    /// An SSL protocol error occurred.
    /// CEF name: `ERR_SSL_PROTOCOL_ERROR`.
    public static let sslProtocolError = CEFErrorCode(rawValue: -107)

    /// The IP address or port number is invalid (e.g., cannot connect to the IP
    /// address 0 or the port 0).
    /// CEF name: `ERR_ADDRESS_INVALID`.
    public static let addressInvalid = CEFErrorCode(rawValue: -108)

    /// The IP address is unreachable.  This usually means that there is no route to
    /// the specified host or network.
    /// CEF name: `ERR_ADDRESS_UNREACHABLE`.
    public static let addressUnreachable = CEFErrorCode(rawValue: -109)

    /// The server requested a client certificate for SSL client authentication.
    /// CEF name: `ERR_SSL_CLIENT_AUTH_CERT_NEEDED`.
    public static let sslClientAuthCertNeeded = CEFErrorCode(rawValue: -110)

    /// A tunnel connection through the proxy could not be established.
    /// CEF name: `ERR_TUNNEL_CONNECTION_FAILED`.
    public static let tunnelConnectionFailed = CEFErrorCode(rawValue: -111)

    /// No SSL protocol versions are enabled.
    /// CEF name: `ERR_NO_SSL_VERSIONS_ENABLED`.
    public static let noSSLVersionsEnabled = CEFErrorCode(rawValue: -112)

    /// The client and server don't support a common SSL protocol version or
    /// cipher suite.
    /// CEF name: `ERR_SSL_VERSION_OR_CIPHER_MISMATCH`.
    public static let sslVersionOrCipherMismatch = CEFErrorCode(rawValue: -113)

    /// The server requested a renegotiation (rehandshake).
    /// CEF name: `ERR_SSL_RENEGOTIATION_REQUESTED`.
    public static let sslRenegotiationRequested = CEFErrorCode(rawValue: -114)

    /// The proxy requested authentication (for tunnel establishment) with an
    /// unsupported method.
    /// CEF name: `ERR_PROXY_AUTH_UNSUPPORTED`.
    public static let proxyAuthUnsupported = CEFErrorCode(rawValue: -115)

    /// Note: this error is not in the -2xx range so that it won't be handled as a
    /// certificate error.
    /// CEF name: `ERR_CERT_ERROR_IN_SSL_RENEGOTIATION`.
    public static let certErrorInSSLRenegotiation = CEFErrorCode(rawValue: -116)

    /// The SSL handshake failed because of a bad or missing client certificate.
    /// CEF name: `ERR_BAD_SSL_CLIENT_AUTH_CERT`.
    public static let badSSLClientAuthCert = CEFErrorCode(rawValue: -117)

    /// A connection attempt timed out.
    /// CEF name: `ERR_CONNECTION_TIMED_OUT`.
    public static let connectionTimedOut = CEFErrorCode(rawValue: -118)

    /// There are too many pending DNS resolves, so a request in the queue was
    /// aborted.
    /// CEF name: `ERR_HOST_RESOLVER_QUEUE_TOO_LARGE`.
    public static let hostResolverQueueTooLarge = CEFErrorCode(rawValue: -119)

    /// Failed establishing a connection to the SOCKS proxy server for a target host.
    /// CEF name: `ERR_SOCKS_CONNECTION_FAILED`.
    public static let socksConnectionFailed = CEFErrorCode(rawValue: -120)

    /// The SOCKS proxy server failed establishing connection to the target host
    /// because that host is unreachable.
    /// CEF name: `ERR_SOCKS_CONNECTION_HOST_UNREACHABLE`.
    public static let socksConnectionHostUnreachable = CEFErrorCode(rawValue: -121)

    /// The request to negotiate an alternate protocol failed.
    /// CEF name: `ERR_ALPN_NEGOTIATION_FAILED`.
    public static let alpnNegotiationFailed = CEFErrorCode(rawValue: -122)

    /// The peer sent an SSL no_renegotiation alert message.
    /// CEF name: `ERR_SSL_NO_RENEGOTIATION`.
    public static let sslNoRenegotiation = CEFErrorCode(rawValue: -123)

    /// Winsock sometimes reports more data written than passed.  This is probably
    /// due to a broken LSP.
    /// CEF name: `ERR_WINSOCK_UNEXPECTED_WRITTEN_BYTES`.
    public static let winsockUnexpectedWrittenBytes = CEFErrorCode(rawValue: -124)

    /// An SSL peer sent us a fatal decompression_failure alert. This typically
    /// occurs when a peer selects DEFLATE compression in the mistaken belief that
    /// it supports it.
    /// CEF name: `ERR_SSL_DECOMPRESSION_FAILURE_ALERT`.
    public static let sslDecompressionFailureAlert = CEFErrorCode(rawValue: -125)

    /// An SSL peer sent us a fatal bad_record_mac alert. This has been observed
    /// from servers with buggy DEFLATE support.
    /// CEF name: `ERR_SSL_BAD_RECORD_MAC_ALERT`.
    public static let sslBadRecordMacAlert = CEFErrorCode(rawValue: -126)

    /// The proxy requested authentication (for tunnel establishment).
    /// CEF name: `ERR_PROXY_AUTH_REQUESTED`.
    public static let proxyAuthRequested = CEFErrorCode(rawValue: -127)

    /// Could not create a connection to the proxy server. An error occurred
    /// either in resolving its name, or in connecting a socket to it.
    /// Note that this does NOT include failures during the actual "CONNECT" method
    /// of an HTTP proxy.
    /// CEF name: `ERR_PROXY_CONNECTION_FAILED`.
    public static let proxyConnectionFailed = CEFErrorCode(rawValue: -130)

    /// A mandatory proxy configuration could not be used. Currently this means
    /// that a mandatory PAC script could not be fetched, parsed or executed.
    /// CEF name: `ERR_MANDATORY_PROXY_CONFIGURATION_FAILED`.
    public static let mandatoryProxyConfigurationFailed = CEFErrorCode(rawValue: -131)

    /// We've hit the max socket limit for the socket pool while preconnecting.  We
    /// don't bother trying to preconnect more sockets.
    /// CEF name: `ERR_PRECONNECT_MAX_SOCKET_LIMIT`.
    public static let preconnectMaxSocketLimit = CEFErrorCode(rawValue: -133)

    /// The permission to use the SSL client certificate's private key was denied.
    /// CEF name: `ERR_SSL_CLIENT_AUTH_PRIVATE_KEY_ACCESS_DENIED`.
    public static let sslClientAuthPrivateKeyAccessDenied = CEFErrorCode(rawValue: -134)

    /// The SSL client certificate has no private key.
    /// CEF name: `ERR_SSL_CLIENT_AUTH_CERT_NO_PRIVATE_KEY`.
    public static let sslClientAuthCertNoPrivateKey = CEFErrorCode(rawValue: -135)

    /// The certificate presented by the HTTPS Proxy was invalid.
    /// CEF name: `ERR_PROXY_CERTIFICATE_INVALID`.
    public static let proxyCertificateInvalid = CEFErrorCode(rawValue: -136)

    /// An error occurred when trying to do a name resolution (DNS).
    /// CEF name: `ERR_NAME_RESOLUTION_FAILED`.
    public static let nameResolutionFailed = CEFErrorCode(rawValue: -137)

    /// Permission to access the network was denied. This is used to distinguish
    /// errors that were most likely caused by a firewall from other access denied
    /// errors. See also ERR_ACCESS_DENIED.
    /// CEF name: `ERR_NETWORK_ACCESS_DENIED`.
    public static let networkAccessDenied = CEFErrorCode(rawValue: -138)

    /// The request throttler module cancelled this request to avoid DDOS.
    /// CEF name: `ERR_TEMPORARILY_THROTTLED`.
    public static let temporarilyThrottled = CEFErrorCode(rawValue: -139)

    /// TODO(https://crbug.com/928551): This is deprecated and should not be used by
    /// new code.
    /// CEF name: `ERR_HTTPS_PROXY_TUNNEL_RESPONSE_REDIRECT`.
    public static let httpsProxyTunnelResponseRedirect = CEFErrorCode(rawValue: -140)

    /// Possible causes for this include the user implicitly or explicitly
    /// denying access to the private key, the private key may not be valid for
    /// signing, the key may be relying on a cached handle which is no longer
    /// valid, or the CSP won't allow arbitrary data to be signed.
    /// CEF name: `ERR_SSL_CLIENT_AUTH_SIGNATURE_FAILED`.
    public static let sslClientAuthSignatureFailed = CEFErrorCode(rawValue: -141)

    /// The message was too large for the transport.  (for example a UDP message
    /// which exceeds size threshold).
    /// CEF name: `ERR_MSG_TOO_BIG`.
    public static let msgTooBig = CEFErrorCode(rawValue: -142)

    /// Websocket protocol error. Indicates that we are terminating the connection
    /// due to a malformed frame or other protocol violation.
    /// CEF name: `ERR_WS_PROTOCOL_ERROR`.
    public static let wsProtocolError = CEFErrorCode(rawValue: -145)

    /// Returned when attempting to bind an address that is already in use.
    /// CEF name: `ERR_ADDRESS_IN_USE`.
    public static let addressInUse = CEFErrorCode(rawValue: -147)

    /// An operation failed because the SSL handshake has not completed.
    /// CEF name: `ERR_SSL_HANDSHAKE_NOT_COMPLETED`.
    public static let sslHandshakeNotCompleted = CEFErrorCode(rawValue: -148)

    /// SSL peer's public key is invalid.
    /// CEF name: `ERR_SSL_BAD_PEER_PUBLIC_KEY`.
    public static let sslBadPeerPublicKey = CEFErrorCode(rawValue: -149)

    /// The certificate didn't match the built-in public key pins for the host name.
    /// The pins are set in net/http/transport_security_state.cc and require that
    /// one of a set of public keys exist on the path from the leaf to the root.
    /// CEF name: `ERR_SSL_PINNED_KEY_NOT_IN_CERT_CHAIN`.
    public static let sslPinnedKeyNotInCertChain = CEFErrorCode(rawValue: -150)

    /// Server request for client certificate did not contain any types we support.
    /// CEF name: `ERR_CLIENT_AUTH_CERT_TYPE_UNSUPPORTED`.
    public static let clientAuthCertTypeUnsupported = CEFErrorCode(rawValue: -151)

    /// An SSL peer sent us a fatal decrypt_error alert. This typically occurs when
    /// a peer could not correctly verify a signature (in CertificateVerify or
    /// ServerKeyExchange) or validate a Finished message.
    /// CEF name: `ERR_SSL_DECRYPT_ERROR_ALERT`.
    public static let sslDecryptErrorAlert = CEFErrorCode(rawValue: -153)

    /// There are too many pending WebSocketJob instances, so the new job was not
    /// pushed to the queue.
    /// CEF name: `ERR_WS_THROTTLE_QUEUE_TOO_LARGE`.
    public static let wsThrottleQueueTooLarge = CEFErrorCode(rawValue: -154)

    /// The SSL server certificate changed in a renegotiation.
    /// CEF name: `ERR_SSL_SERVER_CERT_CHANGED`.
    public static let sslServerCertChanged = CEFErrorCode(rawValue: -156)

    /// The SSL server sent us a fatal unrecognized_name alert.
    /// CEF name: `ERR_SSL_UNRECOGNIZED_NAME_ALERT`.
    public static let sslUnrecognizedNameAlert = CEFErrorCode(rawValue: -159)

    /// Failed to set the socket's receive buffer size as requested.
    /// CEF name: `ERR_SOCKET_SET_RECEIVE_BUFFER_SIZE_ERROR`.
    public static let socketSetReceiveBufferSizeError = CEFErrorCode(rawValue: -160)

    /// Failed to set the socket's send buffer size as requested.
    /// CEF name: `ERR_SOCKET_SET_SEND_BUFFER_SIZE_ERROR`.
    public static let socketSetSendBufferSizeError = CEFErrorCode(rawValue: -161)

    /// Failed to set the socket's receive buffer size as requested, despite success
    /// return code from setsockopt.
    /// CEF name: `ERR_SOCKET_RECEIVE_BUFFER_SIZE_UNCHANGEABLE`.
    public static let socketReceiveBufferSizeUnchangeable = CEFErrorCode(rawValue: -162)

    /// Failed to set the socket's send buffer size as requested, despite success
    /// return code from setsockopt.
    /// CEF name: `ERR_SOCKET_SEND_BUFFER_SIZE_UNCHANGEABLE`.
    public static let socketSendBufferSizeUnchangeable = CEFErrorCode(rawValue: -163)

    /// Failed to import a client certificate from the platform store into the SSL
    /// library.
    /// CEF name: `ERR_SSL_CLIENT_AUTH_CERT_BAD_FORMAT`.
    public static let sslClientAuthCertBadFormat = CEFErrorCode(rawValue: -164)

    /// Resolving a hostname to an IP address list included the IPv4 address
    /// "127.0.53.53". This is a special IP address which ICANN has recommended to
    /// indicate there was a name collision, and alert admins to a potential
    /// problem.
    /// CEF name: `ERR_ICANN_NAME_COLLISION`.
    public static let icannNameCollision = CEFErrorCode(rawValue: -166)

    /// The SSL server presented a certificate which could not be decoded. This is
    /// not a certificate error code as no X509Certificate object is available. This
    /// error is fatal.
    /// CEF name: `ERR_SSL_SERVER_CERT_BAD_FORMAT`.
    public static let sslServerCertBadFormat = CEFErrorCode(rawValue: -167)

    /// Certificate Transparency: Received a signed tree head that failed to parse.
    /// CEF name: `ERR_CT_STH_PARSING_FAILED`.
    public static let ctSthParsingFailed = CEFErrorCode(rawValue: -168)

    /// Certificate Transparency: Received a signed tree head whose JSON parsing was
    /// OK but was missing some of the fields.
    /// CEF name: `ERR_CT_STH_INCOMPLETE`.
    public static let ctSthIncomplete = CEFErrorCode(rawValue: -169)

    /// The attempt to reuse a connection to send proxy auth credentials failed
    /// before the AuthController was used to generate credentials. The caller should
    /// reuse the controller with a new connection. This error is only used
    /// internally by the network stack.
    /// CEF name: `ERR_UNABLE_TO_REUSE_CONNECTION_FOR_PROXY_AUTH`.
    public static let unableToReuseConnectionForProxyAuth = CEFErrorCode(rawValue: -170)

    /// Certificate Transparency: Failed to parse the received consistency proof.
    /// CEF name: `ERR_CT_CONSISTENCY_PROOF_PARSING_FAILED`.
    public static let ctConsistencyProofParsingFailed = CEFErrorCode(rawValue: -171)

    /// The SSL server required an unsupported cipher suite that has since been
    /// removed. This error will temporarily be signaled on a fallback for one or two
    /// releases immediately following a cipher suite's removal, after which the
    /// fallback will be removed.
    /// CEF name: `ERR_SSL_OBSOLETE_CIPHER`.
    public static let sslObsoleteCipher = CEFErrorCode(rawValue: -172)

    /// When a WebSocket handshake is done successfully and the connection has been
    /// upgraded, the URLRequest is cancelled with this error code.
    /// CEF name: `ERR_WS_UPGRADE`.
    public static let wsUpgrade = CEFErrorCode(rawValue: -173)

    /// Socket ReadIfReady support is not implemented. This error should not be user
    /// visible, because the normal Read() method is used as a fallback.
    /// CEF name: `ERR_READ_IF_READY_NOT_IMPLEMENTED`.
    public static let readIfReadyNotImplemented = CEFErrorCode(rawValue: -174)

    /// No socket buffer space is available.
    /// CEF name: `ERR_NO_BUFFER_SPACE`.
    public static let noBufferSpace = CEFErrorCode(rawValue: -176)

    /// There were no common signature algorithms between our client certificate
    /// private key and the server's preferences.
    /// CEF name: `ERR_SSL_CLIENT_AUTH_NO_COMMON_ALGORITHMS`.
    public static let sslClientAuthNoCommonAlgorithms = CEFErrorCode(rawValue: -177)

    /// TLS 1.3 early data was rejected by the server. This will be received before
    /// any data is returned from the socket. The request should be retried with
    /// early data disabled.
    /// CEF name: `ERR_EARLY_DATA_REJECTED`.
    public static let earlyDataRejected = CEFErrorCode(rawValue: -178)

    /// See https://tools.ietf.org/html/rfc8446#appendix-D.3 for details.
    /// CEF name: `ERR_WRONG_VERSION_ON_EARLY_DATA`.
    public static let wrongVersionOnEarlyData = CEFErrorCode(rawValue: -179)

    /// TLS 1.3 was enabled, but a lower version was negotiated and the server
    /// returned a value indicating it supported TLS 1.3. This is part of a security
    /// check in TLS 1.3, but it may also indicate the user is behind a buggy
    /// TLS-terminating proxy which implemented TLS 1.2 incorrectly. (See
    /// https://crbug.com/boringssl/226.)
    /// CEF name: `ERR_TLS13_DOWNGRADE_DETECTED`.
    public static let tls13DowngradeDetected = CEFErrorCode(rawValue: -180)

    /// The server's certificate has a keyUsage extension incompatible with the
    /// negotiated TLS key exchange method.
    /// CEF name: `ERR_SSL_KEY_USAGE_INCOMPATIBLE`.
    public static let sslKeyUsageIncompatible = CEFErrorCode(rawValue: -181)

    /// The certificate has no mechanism for determining if it is revoked.  In
    /// effect, this certificate cannot be revoked.
    /// CEF name: `ERR_CERT_NO_REVOCATION_MECHANISM`.
    public static let certNoRevocationMechanism = CEFErrorCode(rawValue: -204)

    /// The server responded with a certificate has been revoked.
    /// We have the capability to ignore this error, but it is probably not the
    /// thing to do.
    /// CEF name: `ERR_CERT_REVOKED`.
    public static let certRevoked = CEFErrorCode(rawValue: -206)

    /// The server responded with a certificate that is signed using a weak
    /// signature algorithm.
    /// CEF name: `ERR_CERT_WEAK_SIGNATURE_ALGORITHM`.
    public static let certWeakSignatureAlgorithm = CEFErrorCode(rawValue: -208)

    /// The host name specified in the certificate is not unique.
    /// CEF name: `ERR_CERT_NON_UNIQUE_NAME`.
    public static let certNonUniqueName = CEFErrorCode(rawValue: -210)

    /// The server responded with a certificate that contains a weak key (e.g.
    /// a too-small RSA key).
    /// CEF name: `ERR_CERT_WEAK_KEY`.
    public static let certWeakKey = CEFErrorCode(rawValue: -211)

    /// The certificate claimed DNS names that are in violation of name constraints.
    /// CEF name: `ERR_CERT_NAME_CONSTRAINT_VIOLATION`.
    public static let certNameConstraintViolation = CEFErrorCode(rawValue: -212)

    /// The certificate's validity period is too long.
    /// CEF name: `ERR_CERT_VALIDITY_TOO_LONG`.
    public static let certValidityTooLong = CEFErrorCode(rawValue: -213)

    /// Certificate Transparency was required for this connection, but the server
    /// did not provide CT information that complied with the policy.
    /// CEF name: `ERR_CERTIFICATE_TRANSPARENCY_REQUIRED`.
    public static let certificateTransparencyRequired = CEFErrorCode(rawValue: -214)

    /// The certificate chained to a legacy Symantec root that is no longer trusted.
    /// https://g.co/chrome/symantecpkicerts
    /// CEF name: `ERR_CERT_SYMANTEC_LEGACY`.
    public static let certSymantecLegacy = CEFErrorCode(rawValue: -215)

    /// The certificate is known to be used for interception by an entity other
    /// the device owner.
    /// CEF name: `ERR_CERT_KNOWN_INTERCEPTION_BLOCKED`.
    public static let certKnownInterceptionBlocked = CEFErrorCode(rawValue: -217)

    /// The connection uses an obsolete version of SSL/TLS.
    /// CEF name: `ERR_SSL_OBSOLETE_VERSION`.
    public static let sslObsoleteVersion = CEFErrorCode(rawValue: -218)

    /// The value immediately past the last certificate error code.
    /// CEF name: `ERR_CERT_END`.
    public static let certEnd = CEFErrorCode(rawValue: -219)

    /// The URL is invalid.
    /// CEF name: `ERR_INVALID_URL`.
    public static let invalidURL = CEFErrorCode(rawValue: -300)

    /// The scheme of the URL is disallowed.
    /// CEF name: `ERR_DISALLOWED_URL_SCHEME`.
    public static let disallowedURLScheme = CEFErrorCode(rawValue: -301)

    /// The scheme of the URL is unknown.
    /// CEF name: `ERR_UNKNOWN_URL_SCHEME`.
    public static let unknownURLScheme = CEFErrorCode(rawValue: -302)

    /// Attempting to load an URL resulted in a redirect to an invalid URL.
    /// CEF name: `ERR_INVALID_REDIRECT`.
    public static let invalidRedirect = CEFErrorCode(rawValue: -303)

    /// Attempting to load an URL resulted in too many redirects.
    /// CEF name: `ERR_TOO_MANY_REDIRECTS`.
    public static let tooManyRedirects = CEFErrorCode(rawValue: -310)

    /// Attempting to load an URL resulted in an unsafe redirect (e.g., a redirect
    /// to file:// is considered unsafe).
    /// CEF name: `ERR_UNSAFE_REDIRECT`.
    public static let unsafeRedirect = CEFErrorCode(rawValue: -311)

    /// Attempting to load an URL with an unsafe port number.  These are port
    /// numbers that correspond to services, which are not robust to spurious input
    /// that may be constructed as a result of an allowed web construct (e.g., HTTP
    /// looks a lot like SMTP, so form submission to port 25 is denied).
    /// CEF name: `ERR_UNSAFE_PORT`.
    public static let unsafePort = CEFErrorCode(rawValue: -312)

    /// The server's response was invalid.
    /// CEF name: `ERR_INVALID_RESPONSE`.
    public static let invalidResponse = CEFErrorCode(rawValue: -320)

    /// Error in chunked transfer encoding.
    /// CEF name: `ERR_INVALID_CHUNKED_ENCODING`.
    public static let invalidChunkedEncoding = CEFErrorCode(rawValue: -321)

    /// The server did not support the request method.
    /// CEF name: `ERR_METHOD_NOT_SUPPORTED`.
    public static let methodNotSupported = CEFErrorCode(rawValue: -322)

    /// The response was 407 (Proxy Authentication Required), yet we did not send
    /// the request to a proxy.
    /// CEF name: `ERR_UNEXPECTED_PROXY_AUTH`.
    public static let unexpectedProxyAuth = CEFErrorCode(rawValue: -323)

    /// The server closed the connection without sending any data.
    /// CEF name: `ERR_EMPTY_RESPONSE`.
    public static let emptyResponse = CEFErrorCode(rawValue: -324)

    /// The headers section of the response is too large.
    /// CEF name: `ERR_RESPONSE_HEADERS_TOO_BIG`.
    public static let responseHeadersTooBig = CEFErrorCode(rawValue: -325)

    /// The evaluation of the PAC script failed.
    /// CEF name: `ERR_PAC_SCRIPT_FAILED`.
    public static let pacScriptFailed = CEFErrorCode(rawValue: -327)

    /// The response was 416 (Requested range not satisfiable) and the server cannot
    /// satisfy the range requested.
    /// CEF name: `ERR_REQUEST_RANGE_NOT_SATISFIABLE`.
    public static let requestRangeNotSatisfiable = CEFErrorCode(rawValue: -328)

    /// The identity used for authentication is invalid.
    /// CEF name: `ERR_MALFORMED_IDENTITY`.
    public static let malformedIdentity = CEFErrorCode(rawValue: -329)

    /// Content decoding of the response body failed.
    /// CEF name: `ERR_CONTENT_DECODING_FAILED`.
    public static let contentDecodingFailed = CEFErrorCode(rawValue: -330)

    /// An operation could not be completed because all network IO
    /// is suspended.
    /// CEF name: `ERR_NETWORK_IO_SUSPENDED`.
    public static let networkIOSuspended = CEFErrorCode(rawValue: -331)

    /// FLIP data received without receiving a SYN_REPLY on the stream.
    /// CEF name: `ERR_SYN_REPLY_NOT_RECEIVED`.
    public static let synReplyNotReceived = CEFErrorCode(rawValue: -332)

    /// Converting the response to target encoding failed.
    /// CEF name: `ERR_ENCODING_CONVERSION_FAILED`.
    public static let encodingConversionFailed = CEFErrorCode(rawValue: -333)

    /// The server sent an FTP directory listing in a format we do not understand.
    /// CEF name: `ERR_UNRECOGNIZED_FTP_DIRECTORY_LISTING_FORMAT`.
    public static let unrecognizedFtpDirectoryListingFormat = CEFErrorCode(rawValue: -334)

    /// There are no supported proxies in the provided list.
    /// CEF name: `ERR_NO_SUPPORTED_PROXIES`.
    public static let noSupportedProxies = CEFErrorCode(rawValue: -336)

    /// There is an HTTP/2 protocol error.
    /// CEF name: `ERR_HTTP2_PROTOCOL_ERROR`.
    public static let http2ProtocolError = CEFErrorCode(rawValue: -337)

    /// Credentials could not be established during HTTP Authentication.
    /// CEF name: `ERR_INVALID_AUTH_CREDENTIALS`.
    public static let invalidAuthCredentials = CEFErrorCode(rawValue: -338)

    /// An HTTP Authentication scheme was tried which is not supported on this
    /// machine.
    /// CEF name: `ERR_UNSUPPORTED_AUTH_SCHEME`.
    public static let unsupportedAuthScheme = CEFErrorCode(rawValue: -339)

    /// Detecting the encoding of the response failed.
    /// CEF name: `ERR_ENCODING_DETECTION_FAILED`.
    public static let encodingDetectionFailed = CEFErrorCode(rawValue: -340)

    /// (GSSAPI) No Kerberos credentials were available during HTTP Authentication.
    /// CEF name: `ERR_MISSING_AUTH_CREDENTIALS`.
    public static let missingAuthCredentials = CEFErrorCode(rawValue: -341)

    /// An unexpected, but documented, SSPI or GSSAPI status code was returned.
    /// CEF name: `ERR_UNEXPECTED_SECURITY_LIBRARY_STATUS`.
    public static let unexpectedSecurityLibraryStatus = CEFErrorCode(rawValue: -342)

    /// The environment was not set up correctly for authentication (for
    /// example, no KDC could be found or the principal is unknown.
    /// CEF name: `ERR_MISCONFIGURED_AUTH_ENVIRONMENT`.
    public static let misconfiguredAuthEnvironment = CEFErrorCode(rawValue: -343)

    /// An undocumented SSPI or GSSAPI status code was returned.
    /// CEF name: `ERR_UNDOCUMENTED_SECURITY_LIBRARY_STATUS`.
    public static let undocumentedSecurityLibraryStatus = CEFErrorCode(rawValue: -344)

    /// The HTTP response was too big to drain.
    /// CEF name: `ERR_RESPONSE_BODY_TOO_BIG_TO_DRAIN`.
    public static let responseBodyTooBigToDrain = CEFErrorCode(rawValue: -345)

    /// The HTTP response contained multiple distinct Content-Length headers.
    /// CEF name: `ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_LENGTH`.
    public static let responseHeadersMultipleContentLength = CEFErrorCode(rawValue: -346)

    /// HTTP/2 headers have been received, but not all of them - status or version
    /// headers are missing, so we're expecting additional frames to complete them.
    /// CEF name: `ERR_INCOMPLETE_HTTP2_HEADERS`.
    public static let incompleteHTTP2Headers = CEFErrorCode(rawValue: -347)

    /// No PAC URL configuration could be retrieved from DHCP. This can indicate
    /// either a failure to retrieve the DHCP configuration, or that there was no
    /// PAC URL configured in DHCP.
    /// CEF name: `ERR_PAC_NOT_IN_DHCP`.
    public static let pacNotInDhcp = CEFErrorCode(rawValue: -348)

    /// The HTTP response contained multiple Content-Disposition headers.
    /// CEF name: `ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_DISPOSITION`.
    public static let responseHeadersMultipleContentDisposition = CEFErrorCode(rawValue: -349)

    /// The HTTP response contained multiple Location headers.
    /// CEF name: `ERR_RESPONSE_HEADERS_MULTIPLE_LOCATION`.
    public static let responseHeadersMultipleLocation = CEFErrorCode(rawValue: -350)

    /// HTTP/2 server refused the request without processing, and sent either a
    /// GOAWAY frame with error code NO_ERROR and Last-Stream-ID lower than the
    /// stream id corresponding to the request indicating that this request has not
    /// been processed yet, or a RST_STREAM frame with error code REFUSED_STREAM.
    /// Client MAY retry (on a different connection).  See RFC7540 Section 8.1.4.
    /// CEF name: `ERR_HTTP2_SERVER_REFUSED_STREAM`.
    public static let http2ServerRefusedStream = CEFErrorCode(rawValue: -351)

    /// HTTP/2 server didn't respond to the PING message.
    /// CEF name: `ERR_HTTP2_PING_FAILED`.
    public static let http2PingFailed = CEFErrorCode(rawValue: -352)

    /// The HTTP response body transferred fewer bytes than were advertised by the
    /// Content-Length header when the connection is closed.
    /// CEF name: `ERR_CONTENT_LENGTH_MISMATCH`.
    public static let contentLengthMismatch = CEFErrorCode(rawValue: -354)

    /// The HTTP response body is transferred with Chunked-Encoding, but the
    /// terminating zero-length chunk was never sent when the connection is closed.
    /// CEF name: `ERR_INCOMPLETE_CHUNKED_ENCODING`.
    public static let incompleteChunkedEncoding = CEFErrorCode(rawValue: -355)

    /// There is a QUIC protocol error.
    /// CEF name: `ERR_QUIC_PROTOCOL_ERROR`.
    public static let quicProtocolError = CEFErrorCode(rawValue: -356)

    /// The HTTP headers were truncated by an EOF.
    /// CEF name: `ERR_RESPONSE_HEADERS_TRUNCATED`.
    public static let responseHeadersTruncated = CEFErrorCode(rawValue: -357)

    /// The QUIC crytpo handshake failed.  This means that the server was unable
    /// to read any requests sent, so they may be resent.
    /// CEF name: `ERR_QUIC_HANDSHAKE_FAILED`.
    public static let quicHandshakeFailed = CEFErrorCode(rawValue: -358)

    /// Transport security is inadequate for the HTTP/2 version.
    /// CEF name: `ERR_HTTP2_INADEQUATE_TRANSPORT_SECURITY`.
    public static let http2InadequateTransportSecurity = CEFErrorCode(rawValue: -360)

    /// The peer violated HTTP/2 flow control.
    /// CEF name: `ERR_HTTP2_FLOW_CONTROL_ERROR`.
    public static let http2FlowControlError = CEFErrorCode(rawValue: -361)

    /// The peer sent an improperly sized HTTP/2 frame.
    /// CEF name: `ERR_HTTP2_FRAME_SIZE_ERROR`.
    public static let http2FrameSizeError = CEFErrorCode(rawValue: -362)

    /// Decoding or encoding of compressed HTTP/2 headers failed.
    /// CEF name: `ERR_HTTP2_COMPRESSION_ERROR`.
    public static let http2CompressionError = CEFErrorCode(rawValue: -363)

    /// Proxy Auth Requested without a valid Client Socket Handle.
    /// CEF name: `ERR_PROXY_AUTH_REQUESTED_WITH_NO_CONNECTION`.
    public static let proxyAuthRequestedWithNoConnection = CEFErrorCode(rawValue: -364)

    /// HTTP_1_1_REQUIRED error code received on HTTP/2 session.
    /// CEF name: `ERR_HTTP_1_1_REQUIRED`.
    public static let http11Required = CEFErrorCode(rawValue: -365)

    /// HTTP_1_1_REQUIRED error code received on HTTP/2 session to proxy.
    /// CEF name: `ERR_PROXY_HTTP_1_1_REQUIRED`.
    public static let proxyHTTP11Required = CEFErrorCode(rawValue: -366)

    /// The PAC script terminated fatally and must be reloaded.
    /// CEF name: `ERR_PAC_SCRIPT_TERMINATED`.
    public static let pacScriptTerminated = CEFErrorCode(rawValue: -367)

    /// The server was expected to return an HTTP/1.x response, but did not. Rather
    /// than treat it as HTTP/0.9, this error is returned.
    /// CEF name: `ERR_INVALID_HTTP_RESPONSE`.
    public static let invalidHTTPResponse = CEFErrorCode(rawValue: -370)

    /// Initializing content decoding failed.
    /// CEF name: `ERR_CONTENT_DECODING_INIT_FAILED`.
    public static let contentDecodingInitFailed = CEFErrorCode(rawValue: -371)

    /// Received HTTP/2 RST_STREAM frame with NO_ERROR error code.  This error should
    /// be handled internally by HTTP/2 code, and should not make it above the
    /// SpdyStream layer.
    /// CEF name: `ERR_HTTP2_RST_STREAM_NO_ERROR_RECEIVED`.
    public static let http2RstStreamNoErrorReceived = CEFErrorCode(rawValue: -372)

    /// The pushed stream claimed by the request is no longer available.
    /// CEF name: `ERR_HTTP2_PUSHED_STREAM_NOT_AVAILABLE`.
    public static let http2PushedStreamNotAvailable = CEFErrorCode(rawValue: -373)

    /// A pushed stream was claimed and later reset by the server. When this happens,
    /// the request should be retried.
    /// CEF name: `ERR_HTTP2_CLAIMED_PUSHED_STREAM_RESET_BY_SERVER`.
    public static let http2ClaimedPushedStreamResetByServer = CEFErrorCode(rawValue: -374)

    /// An HTTP transaction was retried too many times due for authentication or
    /// invalid certificates. This may be due to a bug in the net stack that would
    /// otherwise infinite loop, or if the server or proxy continually requests fresh
    /// credentials or presents a fresh invalid certificate.
    /// CEF name: `ERR_TOO_MANY_RETRIES`.
    public static let tooManyRetries = CEFErrorCode(rawValue: -375)

    /// Received an HTTP/2 frame on a closed stream.
    /// CEF name: `ERR_HTTP2_STREAM_CLOSED`.
    public static let http2StreamClosed = CEFErrorCode(rawValue: -376)

    /// Client is refusing an HTTP/2 stream.
    /// CEF name: `ERR_HTTP2_CLIENT_REFUSED_STREAM`.
    public static let http2ClientRefusedStream = CEFErrorCode(rawValue: -377)

    /// A pushed HTTP/2 stream was claimed by a request based on matching URL and
    /// request headers, but the pushed response headers do not match the request.
    /// CEF name: `ERR_HTTP2_PUSHED_RESPONSE_DOES_NOT_MATCH`.
    public static let http2PushedResponseDoesNotMatch = CEFErrorCode(rawValue: -378)

    /// Not that this error is only used by certain APIs that interpret the HTTP
    /// response itself. URLRequest for instance just passes most non-2xx
    /// response back as success.
    /// CEF name: `ERR_HTTP_RESPONSE_CODE_FAILURE`.
    public static let httpResponseCodeFailure = CEFErrorCode(rawValue: -379)

    /// The certificate presented on a QUIC connection does not chain to a known root
    /// and the origin connected to is not on a list of domains where unknown roots
    /// are allowed.
    /// CEF name: `ERR_QUIC_CERT_ROOT_NOT_KNOWN`.
    public static let quicCertRootNotKnown = CEFErrorCode(rawValue: -380)

    /// A GOAWAY frame has been received indicating that the request has not been
    /// processed and is therefore safe to retry on a different connection.
    /// CEF name: `ERR_QUIC_GOAWAY_REQUEST_CAN_BE_RETRIED`.
    public static let quicGoawayRequestCanBeRetried = CEFErrorCode(rawValue: -381)

    /// The cache does not have the requested entry.
    /// CEF name: `ERR_CACHE_MISS`.
    public static let cacheMiss = CEFErrorCode(rawValue: -400)

    /// Unable to read from the disk cache.
    /// CEF name: `ERR_CACHE_READ_FAILURE`.
    public static let cacheReadFailure = CEFErrorCode(rawValue: -401)

    /// Unable to write to the disk cache.
    /// CEF name: `ERR_CACHE_WRITE_FAILURE`.
    public static let cacheWriteFailure = CEFErrorCode(rawValue: -402)

    /// The operation is not supported for this entry.
    /// CEF name: `ERR_CACHE_OPERATION_NOT_SUPPORTED`.
    public static let cacheOperationNotSupported = CEFErrorCode(rawValue: -403)

    /// The disk cache is unable to open this entry.
    /// CEF name: `ERR_CACHE_OPEN_FAILURE`.
    public static let cacheOpenFailure = CEFErrorCode(rawValue: -404)

    /// The disk cache is unable to create this entry.
    /// CEF name: `ERR_CACHE_CREATE_FAILURE`.
    public static let cacheCreateFailure = CEFErrorCode(rawValue: -405)

    /// Multiple transactions are racing to create disk cache entries. This is an
    /// internal error returned from the HttpCache to the HttpCacheTransaction that
    /// tells the transaction to restart the entry-creation logic because the state
    /// of the cache has changed.
    /// CEF name: `ERR_CACHE_RACE`.
    public static let cacheRace = CEFErrorCode(rawValue: -406)

    /// The cache was unable to read a checksum record on an entry. This can be
    /// returned from attempts to read from the cache. It is an internal error,
    /// returned by the SimpleCache backend, but not by any URLRequest methods
    /// or members.
    /// CEF name: `ERR_CACHE_CHECKSUM_READ_FAILURE`.
    public static let cacheChecksumReadFailure = CEFErrorCode(rawValue: -407)

    /// The cache found an entry with an invalid checksum. This can be returned from
    /// attempts to read from the cache. It is an internal error, returned by the
    /// SimpleCache backend, but not by any URLRequest methods or members.
    /// CEF name: `ERR_CACHE_CHECKSUM_MISMATCH`.
    public static let cacheChecksumMismatch = CEFErrorCode(rawValue: -408)

    /// Internal error code for the HTTP cache. The cache lock timeout has fired.
    /// CEF name: `ERR_CACHE_LOCK_TIMEOUT`.
    public static let cacheLockTimeout = CEFErrorCode(rawValue: -409)

    /// Received a challenge after the transaction has read some data, and the
    /// credentials aren't available.  There isn't a way to get them at that point.
    /// CEF name: `ERR_CACHE_AUTH_FAILURE_AFTER_READ`.
    public static let cacheAuthFailureAfterRead = CEFErrorCode(rawValue: -410)

    /// Internal not-quite error code for the HTTP cache. In-memory hints suggest
    /// that the cache entry would not have been useable with the transaction's
    /// current configuration (e.g. load flags, mode, etc.)
    /// CEF name: `ERR_CACHE_ENTRY_NOT_SUITABLE`.
    public static let cacheEntryNotSuitable = CEFErrorCode(rawValue: -411)

    /// The disk cache is unable to doom this entry.
    /// CEF name: `ERR_CACHE_DOOM_FAILURE`.
    public static let cacheDoomFailure = CEFErrorCode(rawValue: -412)

    /// The disk cache is unable to open or create this entry.
    /// CEF name: `ERR_CACHE_OPEN_OR_CREATE_FAILURE`.
    public static let cacheOpenOrCreateFailure = CEFErrorCode(rawValue: -413)

    /// The server's response was insecure (e.g. there was a cert error).
    /// CEF name: `ERR_INSECURE_RESPONSE`.
    public static let insecureResponse = CEFErrorCode(rawValue: -501)

    /// An attempt to import a client certificate failed, as the user's key
    /// database lacked a corresponding private key.
    /// CEF name: `ERR_NO_PRIVATE_KEY_FOR_CERT`.
    public static let noPrivateKeyForCert = CEFErrorCode(rawValue: -502)

    /// An error adding a certificate to the OS certificate database.
    /// CEF name: `ERR_ADD_USER_CERT_FAILED`.
    public static let addUserCertFailed = CEFErrorCode(rawValue: -503)

    /// An error occurred while handling a signed exchange.
    /// CEF name: `ERR_INVALID_SIGNED_EXCHANGE`.
    public static let invalidSignedExchange = CEFErrorCode(rawValue: -504)

    /// An error occurred while handling a Web Bundle source.
    /// CEF name: `ERR_INVALID_WEB_BUNDLE`.
    public static let invalidWebBundle = CEFErrorCode(rawValue: -505)

    /// A Trust Tokens protocol operation-executing request failed for one of a
    /// number of reasons (precondition failure, internal error, bad response).
    /// CEF name: `ERR_TRUST_TOKEN_OPERATION_FAILED`.
    public static let trustTokenOperationFailed = CEFErrorCode(rawValue: -506)

    /// When handling a Trust Tokens protocol operation-executing request, the system
    /// was able to execute the request's Trust Tokens operation without sending the
    /// request to its destination: for instance, the results could have been present
    /// in a local cache (for redemption) or the operation could have been diverted
    /// to a local provider (for "platform-provided" issuance).
    /// CEF name: `ERR_TRUST_TOKEN_OPERATION_SUCCESS_WITHOUT_SENDING_REQUEST`.
    public static let trustTokenOperationSuccessWithoutSendingRequest = CEFErrorCode(rawValue: -507)

    /// A generic error for failed FTP control connection command.
    /// If possible, please use or add a more specific error code.
    /// CEF name: `ERR_FTP_FAILED`.
    public static let ftpFailed = CEFErrorCode(rawValue: -601)

    /// The server cannot fulfill the request at this point. This is a temporary
    /// error.
    /// FTP response code 421.
    /// CEF name: `ERR_FTP_SERVICE_UNAVAILABLE`.
    public static let ftpServiceUnavailable = CEFErrorCode(rawValue: -602)

    /// The server has aborted the transfer.
    /// FTP response code 426.
    /// CEF name: `ERR_FTP_TRANSFER_ABORTED`.
    public static let ftpTransferAborted = CEFErrorCode(rawValue: -603)

    /// The file is busy, or some other temporary error condition on opening
    /// the file.
    /// FTP response code 450.
    /// CEF name: `ERR_FTP_FILE_BUSY`.
    public static let ftpFileBusy = CEFErrorCode(rawValue: -604)

    /// Server rejected our command because of syntax errors.
    /// FTP response codes 500, 501.
    /// CEF name: `ERR_FTP_SYNTAX_ERROR`.
    public static let ftpSyntaxError = CEFErrorCode(rawValue: -605)

    /// Server does not support the command we issued.
    /// FTP response codes 502, 504.
    /// CEF name: `ERR_FTP_COMMAND_NOT_SUPPORTED`.
    public static let ftpCommandNotSupported = CEFErrorCode(rawValue: -606)

    /// Server rejected our command because we didn't issue the commands in right
    /// order.
    /// FTP response code 503.
    /// CEF name: `ERR_FTP_BAD_COMMAND_SEQUENCE`.
    public static let ftpBadCommandSequence = CEFErrorCode(rawValue: -607)

    /// PKCS #12 import failed due to incorrect password.
    /// CEF name: `ERR_PKCS12_IMPORT_BAD_PASSWORD`.
    public static let pkcs12ImportBadPassword = CEFErrorCode(rawValue: -701)

    /// PKCS #12 import failed due to other error.
    /// CEF name: `ERR_PKCS12_IMPORT_FAILED`.
    public static let pkcs12ImportFailed = CEFErrorCode(rawValue: -702)

    /// CA import failed - not a CA cert.
    /// CEF name: `ERR_IMPORT_CA_CERT_NOT_CA`.
    public static let importCaCertNotCa = CEFErrorCode(rawValue: -703)

    /// Import failed - certificate already exists in database.
    /// Note it's a little weird this is an error but reimporting a PKCS12 is ok
    /// (no-op).  That's how Mozilla does it, though.
    /// CEF name: `ERR_IMPORT_CERT_ALREADY_EXISTS`.
    public static let importCertAlreadyExists = CEFErrorCode(rawValue: -704)

    /// CA import failed due to some other error.
    /// CEF name: `ERR_IMPORT_CA_CERT_FAILED`.
    public static let importCaCertFailed = CEFErrorCode(rawValue: -705)

    /// Server certificate import failed due to some internal error.
    /// CEF name: `ERR_IMPORT_SERVER_CERT_FAILED`.
    public static let importServerCertFailed = CEFErrorCode(rawValue: -706)

    /// PKCS #12 import failed due to invalid MAC.
    /// CEF name: `ERR_PKCS12_IMPORT_INVALID_MAC`.
    public static let pkcs12ImportInvalidMac = CEFErrorCode(rawValue: -707)

    /// PKCS #12 import failed due to invalid/corrupt file.
    /// CEF name: `ERR_PKCS12_IMPORT_INVALID_FILE`.
    public static let pkcs12ImportInvalidFile = CEFErrorCode(rawValue: -708)

    /// PKCS #12 import failed due to unsupported features.
    /// CEF name: `ERR_PKCS12_IMPORT_UNSUPPORTED`.
    public static let pkcs12ImportUnsupported = CEFErrorCode(rawValue: -709)

    /// Key generation failed.
    /// CEF name: `ERR_KEY_GENERATION_FAILED`.
    public static let keyGenerationFailed = CEFErrorCode(rawValue: -710)

    /// Failure to export private key.
    /// CEF name: `ERR_PRIVATE_KEY_EXPORT_FAILED`.
    public static let privateKeyExportFailed = CEFErrorCode(rawValue: -712)

    /// Self-signed certificate generation failed.
    /// CEF name: `ERR_SELF_SIGNED_CERT_GENERATION_FAILED`.
    public static let selfSignedCertGenerationFailed = CEFErrorCode(rawValue: -713)

    /// The certificate database changed in some way.
    /// CEF name: `ERR_CERT_DATABASE_CHANGED`.
    public static let certDatabaseChanged = CEFErrorCode(rawValue: -714)

    /// DNS resolver received a malformed response.
    /// CEF name: `ERR_DNS_MALFORMED_RESPONSE`.
    public static let dnsMalformedResponse = CEFErrorCode(rawValue: -800)

    /// DNS server requires TCP
    /// CEF name: `ERR_DNS_SERVER_REQUIRES_TCP`.
    public static let dnsServerRequiresTcp = CEFErrorCode(rawValue: -801)

    /// DNS server failed.  This error is returned for all of the following
    /// error conditions:
    /// 1 - Format error - The name server was unable to interpret the query.
    /// 2 - Server failure - The name server was unable to process this query
    /// due to a problem with the name server.
    /// 4 - Not Implemented - The name server does not support the requested
    /// kind of query.
    /// 5 - Refused - The name server refuses to perform the specified
    /// operation for policy reasons.
    /// CEF name: `ERR_DNS_SERVER_FAILED`.
    public static let dnsServerFailed = CEFErrorCode(rawValue: -802)

    /// DNS transaction timed out.
    /// CEF name: `ERR_DNS_TIMED_OUT`.
    public static let dnsTimedOut = CEFErrorCode(rawValue: -803)

    /// The entry was not found in cache or other local sources, for lookups where
    /// only local sources were queried.
    /// TODO(ericorth): Consider renaming to DNS_LOCAL_MISS or something like that as
    /// the cache is not necessarily queried either.
    /// CEF name: `ERR_DNS_CACHE_MISS`.
    public static let dnsCacheMiss = CEFErrorCode(rawValue: -804)

    /// Suffix search list rules prevent resolution of the given host name.
    /// CEF name: `ERR_DNS_SEARCH_EMPTY`.
    public static let dnsSearchEmpty = CEFErrorCode(rawValue: -805)

    /// Failed to sort addresses according to RFC3484.
    /// CEF name: `ERR_DNS_SORT_ERROR`.
    public static let dnsSortError = CEFErrorCode(rawValue: -806)

    /// Failed to resolve the hostname of a DNS-over-HTTPS server.
    /// CEF name: `ERR_DNS_SECURE_RESOLVER_HOSTNAME_RESOLUTION_FAILED`.
    public static let dnsSecureResolverHostnameResolutionFailed = CEFErrorCode(rawValue: -808)
}

extension CEFErrorCode {
    static func fromCEF(_ value: Int32) -> CEFErrorCode {
        return CEFErrorCode(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}

