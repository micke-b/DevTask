import Foundation

nonisolated public class FakePostsService: PostsService {

    public func getPosts() async throws(PostsServiceError) -> [Post] {
        return [Post(userId: 1, id: 1, title: "hello", body: "body")]
    }

}
