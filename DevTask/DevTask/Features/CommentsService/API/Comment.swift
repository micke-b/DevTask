import Foundation

nonisolated public struct Comment: Codable, Identifiable, Sendable {
    public let postId: Int
    public let id: Int
    public let name: String
    public let email: String
    public let body: String
}
