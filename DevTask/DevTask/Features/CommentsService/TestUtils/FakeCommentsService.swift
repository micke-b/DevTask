nonisolated class FakeCommentsService: CommentsService {
    func getComments(for postId: Int) async throws(CommentsServiceError) -> [Comment] {
        [Comment(postId: 1, id: 2, name: "name", email: "email", body: "body")]
    }
}
