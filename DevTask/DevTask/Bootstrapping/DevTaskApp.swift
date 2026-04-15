import SwiftUI

@main
struct DevTaskApp: App {

    var getFiftyFirstPosts: GetFiftyFirstPostsUseCase
    var getCommentsForPost: GetCommentsForPostUseCase

    init() {
        // Repository dependancies
        let postsService: PostsService = DefaultPostsService()
        let commentsService: CommentsService = DefaultCommentService()
        let blogRepository: BlogRepository = DefaultBlogRepository(
            postsService: postsService,
            commentsService: commentsService
        )
        //App dependancies
        self.getFiftyFirstPosts = GetFiftyFirstPostsUseCase(
            blogRepository: blogRepository
        )
        self.getCommentsForPost = GetCommentsForPostUseCase(
            blogRepository: blogRepository
        )
    }

    var body: some Scene {
        WindowGroup {
            PostList(
                viewModel: PostListViewModel(
                    getFiftyFirstPosts: getFiftyFirstPosts
                ),
                getCommentsForPost: getCommentsForPost
            )
        }
    }
}
