import Foundation

public enum HealthError: Error {
    case invalidParameter(message: String)
    case unexpected(message: String)
    case notFound(message: String)
}
