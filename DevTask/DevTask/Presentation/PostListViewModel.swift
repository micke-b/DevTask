import SwiftUI

enum PostListViewModelState {
    case loading
    case loaded
    case failedToGetPosts
}

@Observable
class PostListViewModel {

    var posts: [Post] = []
    var state: PostListViewModelState = .loading
    private var getFiftyFirstPosts: GetFiftyFirstPostsUseCase

    init(getFiftyFirstPosts: GetFiftyFirstPostsUseCase) {
        self.getFiftyFirstPosts = getFiftyFirstPosts
    }

    func fetchPosts() async {
        self.state = .loading
        do {
            posts = try await getFiftyFirstPosts.execute()
            self.state = .loaded
        } catch {
            self.state = .failedToGetPosts
        }
    }

}
