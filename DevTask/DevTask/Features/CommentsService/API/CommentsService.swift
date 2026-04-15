nonisolated public enum CommentsServiceError: Error {
    case invalidURL
    case networkError(Error)
    case unexpectedStatusCode(Int)
    case decodingError(Error)
}

nonisolated public protocol CommentsService {
    func getComments(for postId: Int) async throws(CommentsServiceError) -> [Comment]
}
