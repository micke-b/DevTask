nonisolated class DefaultBlogRepository: BlogRepository {

    private let postsService: PostsService
    private let commentsService: CommentsService

    init(
        postsService: PostsService,
        commentsService: CommentsService
    ) {
        self.postsService = postsService
        self.commentsService = commentsService
    }

    func getPosts() async throws(BlogRepositoryError) -> [Post] {
        do {
            return try await postsService.getPosts()
        } catch {
            // catch all
            throw .failedToGetPosts
        }
    }

    func getComments(for postId: Int) async throws(BlogRepositoryError) -> [Comment] {
        do {
            return try await commentsService.getComments(for: postId)
        } catch {
            // catch all
            throw .failedToGetComments
        }
    }
}
