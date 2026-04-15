nonisolated public class FakeBlogRepository: BlogRepository {

    public var postsResult: Result<[Post], BlogRepositoryError> = .success([])
    public var commentsResult: Result<[Comment], BlogRepositoryError> = .success([])

    public func getPosts() async throws(BlogRepositoryError) -> [Post] {
        switch postsResult {
        case .success(let posts):
            return posts
        case .failure(let error):
            throw error
        }
    }

    public func getComments(for postId: Int) async throws(BlogRepositoryError) -> [Comment] {
        switch commentsResult {
        case .success(let comments):
            return comments
        case .failure(let error):
            throw error
        }
    }
}
