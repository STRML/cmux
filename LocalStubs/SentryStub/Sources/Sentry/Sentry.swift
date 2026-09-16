// No-op stub of the sentry-cocoa API surface used by cmux.
// Only the members referenced by the app/CLI are declared; every one is inert.
import Foundation

public enum SentryLevel: Int, Sendable {
    case none = 0, debug, info, warning, error, fatal
}

public struct SentryId: Sendable {
    public var sentryIdString: String
    public init() { self.sentryIdString = UUID().uuidString }
}

public final class SentryMessage: @unchecked Sendable {
    public var formatted: String
    public var message: String?
    public var params: [String]?
    public init(formatted: String) { self.formatted = formatted }
}

public final class Breadcrumb: @unchecked Sendable {
    public var level: SentryLevel
    public var category: String
    public var message: String?
    public var data: [String: Any]?
    public init(level: SentryLevel = .info, category: String = "") {
        self.level = level
        self.category = category
    }
}

public final class Frame: @unchecked Sendable {
    public var fileName: String?
    public var package: String?
    public var contextLine: String?
    public var preContext: [String]?
    public var postContext: [String]?
    public var vars: [String: Any]?
    public init() {}
}

public final class SentryStacktrace: @unchecked Sendable {
    public var frames: [Frame]?
    public init() {}
}

public final class SentryNSError: @unchecked Sendable {
    public var domain: String
    public var code: Int
    public init(domain: String, code: Int) {
        self.domain = domain
        self.code = code
    }
}

public final class MechanismContext: @unchecked Sendable {
    public var error: SentryNSError?
    public init() {}
}

public final class Mechanism: @unchecked Sendable {
    public var type: String
    public var desc: String?
    public var helpLink: String?
    public var data: [String: Any]?
    public var meta: MechanismContext?
    public init(type: String = "") { self.type = type }
}

public final class Exception: @unchecked Sendable {
    public var value: String?
    public var type: String?
    public var stacktrace: SentryStacktrace?
    public var mechanism: Mechanism?
    public init() {}
    public init(value: String, type: String) {
        self.value = value
        self.type = type
    }
}

public final class SentryThread: @unchecked Sendable {
    public var name: String?
    public var stacktrace: SentryStacktrace?
    public init() {}
}

public final class DebugMeta: @unchecked Sendable {
    public var codeFile: String?
    public init() {}
}

public final class SentryRequest: @unchecked Sendable {
    public var url: String?
    public var queryString: String?
    public var fragment: String?
    public var cookies: String?
    public var headers: [String: String]?
    public init() {}
}

public final class Geo: @unchecked Sendable {
    public init() {}
}

public final class User: @unchecked Sendable {
    public var userId: String?
    public var email: String?
    public var username: String?
    public var name: String?
    public var ipAddress: String?
    public var geo: Geo?
    public var data: [String: Any]?
    public init() {}
}

public final class Event: @unchecked Sendable {
    public var eventId = SentryId()
    public var level: SentryLevel?
    public var message: SentryMessage?
    public var serverName: String?
    public var transaction: String?
    public var logger: String?
    public var environment: String?
    public var releaseName: String?
    public var exceptions: [Exception]?
    public var threads: [SentryThread]?
    public var stacktrace: SentryStacktrace?
    public var debugMeta: [DebugMeta]?
    public var request: SentryRequest?
    public var user: User?
    public var tags: [String: String]?
    public var extra: [String: Any]?
    public var context: [String: [String: Any]]?
    public var breadcrumbs: [Breadcrumb]?
    public init() {}
    public init(error: Error) {}
}

public protocol Span: AnyObject {
    var spanDescription: String? { get set }
    var data: [String: Any] { get }
    var tags: [String: String] { get }
    func setData(value: Any, key: String)
    func setTag(value: String, key: String)
}

public final class Scope: @unchecked Sendable {
    public init() {}
    public func setLevel(_ level: SentryLevel) {}
    public func setTag(value: String, key: String) {}
    public func setContext(value: [String: Any], key: String) {}
}

public final class Options: @unchecked Sendable {
    public var dsn: String?
    public var environment: String = "production"
    public var releaseName: String?
    public var debug: Bool = false
    public var sendDefaultPii: Bool = false
    public var tracesSampleRate: NSNumber?
    public var appHangTimeoutInterval: TimeInterval = 2
    public var attachStacktrace: Bool = false
    public var enableCaptureFailedRequests: Bool = true
    public var enableAppHangTracking: Bool = true
    public var enableWatchdogTerminationTracking: Bool = true
    public var enableAutoSessionTracking: Bool = true
    public var enableMetricKit: Bool = false
    public var beforeSend: ((Event) -> Event?)?
    public var beforeBreadcrumb: ((Breadcrumb) -> Breadcrumb?)?
    public var beforeSendSpan: ((any Span) -> (any Span)?)?
    public init() {}
}

public final class SentryEnvelopeItem: @unchecked Sendable {
    public init(event: Event) {}
}

public final class SentryEnvelope: @unchecked Sendable {
    public init(id: SentryId, singleItem: SentryEnvelopeItem) {}
}

public enum PrivateSentrySDKOnly {
    public static func store(_ envelope: SentryEnvelope) {}
}

public enum SentrySDK {
    public static func start(_ configureOptions: (Options) -> Void) {
        configureOptions(Options())
    }
    public static func crash() {}
    public static func flush(timeout: TimeInterval) {}
    @discardableResult
    public static func capture(message: String, block: (Scope) -> Void) -> SentryId {
        block(Scope())
        return SentryId()
    }
    public static func addBreadcrumb(_ crumb: Breadcrumb) {}
    public static func configureScope(_ callback: (Scope) -> Void) {
        callback(Scope())
    }
}
