nonisolated public enum PostsServiceError: Error {
    case invalidURL
    case networkError(Error)
    case unexpectedStatusCode(Int)
    case decodingError(Error)
}

nonisolated public protocol PostsService {
    func getPosts() async throws(PostsServiceError) -> [Post]
}
