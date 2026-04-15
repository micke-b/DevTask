import SwiftUI

struct PostList: View {

    var viewModel: PostListViewModel
    var getCommentsForPost: GetCommentsForPostUseCase
    @State private var path = NavigationPath()

    private var backgroundGradient: some View {
        DesignTokens.backgroundGradient
            .ignoresSafeArea()
    }

    private var postsList: some View {
        ScrollView {
            GlassEffectContainer {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.posts) { post in
                        Button {
                            path.append(post)
                        } label: {
                            PostCell(post)
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding()
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                backgroundGradient
                postsList
            }
            .navigationTitle("Posts")
            .navigationDestination(for: Post.self) { post in
                CommentList(
                    viewModel: CommentListViewModel(
                        getCommentsForPost: getCommentsForPost
                    ),
                    post: post
                )
            }
        }
        .task {
            await viewModel.fetchPosts()
        }
    }
}

#Preview {
    let blogRepository = DefaultBlogRepository(
        postsService: FakePostsService(),
        commentsService: FakeCommentsService()
    )
    PostList(
        viewModel: PostListViewModel(
            getFiftyFirstPosts: GetFiftyFirstPostsUseCase(
                blogRepository: blogRepository
            )
        ),
        getCommentsForPost: GetCommentsForPostUseCase(
            blogRepository: blogRepository
        )
    )
}
