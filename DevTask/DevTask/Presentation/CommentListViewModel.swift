import SwiftUI

enum CommentListViewModelState {
    case loading
    case loaded
    case failedToGetComments
}

@Observable
class CommentListViewModel {

    var comments: [Comment] = []
    var state: CommentListViewModelState = .loading
    private var getCommentsForPost: GetCommentsForPostUseCase

    init(getCommentsForPost: GetCommentsForPostUseCase) {
        self.getCommentsForPost = getCommentsForPost
    }

    func fetchComments(for postId: Int) async {
        self.state = .loading
        do {
            comments = try await getCommentsForPost.execute(for: postId)
            self.state = .loaded
        } catch {
            self.state = .failedToGetComments
        }
    }

}
