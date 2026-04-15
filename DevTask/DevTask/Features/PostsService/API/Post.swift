import Foundation

nonisolated public struct Post: Codable, Identifiable, Hashable, Sendable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
}
