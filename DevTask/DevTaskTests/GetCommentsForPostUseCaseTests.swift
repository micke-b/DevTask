import Testing
@testable import DevTask

private typealias Comment = DevTask.Comment

struct GetCommentsForPostUseCaseTests {

    private func makeSUT(
        commentsResult: Result<[Comment], BlogRepositoryError> = .success([])
    ) -> (GetCommentsForPostUseCase, FakeBlogRepository) {
        let repository = FakeBlogRepository()
        repository.commentsResult = commentsResult
        let sut = GetCommentsForPostUseCase(blogRepository: repository)
        return (sut, repository)
    }

    @Test func returnsCommentsForPost() async throws {
        let comments: [Comment] = [
            Comment(postId: 1, id: 1, name: "Alice", email: "alice@test.com", body: "Nice post"),
            Comment(postId: 1, id: 2, name: "Bob", email: "bob@test.com", body: "Great read"),
        ]
        let (sut, _) = makeSUT(commentsResult: .success(comments))

        let result = try await sut.execute(for: 1)

        #expect(result.count == 2)
        #expect(result[0].name == "Alice")
        #expect(result[1].name == "Bob")
    }

    @Test func returnsEmptyWhenNoComments() async throws {
        let (sut, _) = makeSUT(commentsResult: .success([]))

        let result = try await sut.execute(for: 1)

        #expect(result.isEmpty)
    }

    @Test func throwsFailedToGetCommentsWhenRepositoryFails() async {
        let (sut, _) = makeSUT(commentsResult: .failure(.failedToGetComments))

        await #expect(throws: GetCommentsForPostError.failedToGetComments) {
            try await sut.execute(for: 1)
        }
    }
}
