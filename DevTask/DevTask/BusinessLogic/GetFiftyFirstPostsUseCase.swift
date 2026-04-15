nonisolated enum FetchPostWithIdUnderFiftyError: Error {
    case failedToGetPosts
}

nonisolated class GetFiftyFirstPostsUseCase {

    private let blogRepository: BlogRepository

    init(blogRepository: BlogRepository) {
        self.blogRepository = blogRepository
    }

    // Single unit of business logic, testable and reusable
    public func execute() async throws(FetchPostWithIdUnderFiftyError) -> [Post] {
        do {
            let posts = try await blogRepository.getPosts()
            return posts.filter { $0.id < 50 }
        } catch {
            throw .failedToGetPosts
        }
    }
}
