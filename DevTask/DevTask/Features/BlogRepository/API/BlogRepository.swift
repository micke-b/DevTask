nonisolated public enum BlogRepositoryError: Error {
    // Just what the next layer needs, detailed erros are logged / recovered in the services.
    case failedToGetPosts
    case failedToGetComments
}

nonisolated public protocol BlogRepository {
    func getPosts() async throws(BlogRepositoryError) -> [Post]
    func getComments(for postId: Int) async throws(BlogRepositoryError) -> [Comment]
}
