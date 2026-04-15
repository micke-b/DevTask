nonisolated enum GetCommentsForPostError: Error {
    case failedToGetComments
}

nonisolated class GetCommentsForPostUseCase {

    private let blogRepository: BlogRepository

    init(blogRepository: BlogRepository) {
        self.blogRepository = blogRepository
    }

    // Single unit of business logic, testable and reusable
    public func execute(for postId: Int) async throws(GetCommentsForPostError) -> [Comment] {
        do {
            return try await blogRepository.getComments(for: postId)
        } catch {
            throw .failedToGetComments
        }
    }
}
