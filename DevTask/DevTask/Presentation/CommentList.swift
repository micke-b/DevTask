import SwiftUI

struct CommentList: View {

    var viewModel: CommentListViewModel
    let post: Post

    private var backgroundGradient: some View {
        DesignTokens.backgroundGradient
            .ignoresSafeArea()
    }

    private var commentsList: some View {
        ScrollView {
            Text(post.title)
                .font(.title2)
                .foregroundStyle(DesignTokens.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            GlassEffectContainer {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment).padding(.vertical, 8)
                    }
                }
            }
            .padding()
        }
    }

    var body: some View {
        ZStack {
            backgroundGradient
            commentsList
        }
        .navigationTitle("Comments")
        .toolbarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchComments(for: post.id)
        }
    }
}

#Preview {
    NavigationStack {
        CommentList(
            viewModel: CommentListViewModel(
                getCommentsForPost: GetCommentsForPostUseCase(
                    blogRepository: DefaultBlogRepository(
                        postsService: FakePostsService(),
                        commentsService: FakeCommentsService()
                    )
                )
            ),
            post: Post(userId: 1, id: 1, title: "Post Title", body: "Post body")
        )
    }
}
