import Testing
@testable import DevTask

struct GetFiftyFirstPostsUseCaseTests {

    private func makeSUT(
        postsResult: Result<[Post], BlogRepositoryError> = .success([])
    ) -> (GetFiftyFirstPostsUseCase, FakeBlogRepository) {
        let repository = FakeBlogRepository()
        repository.postsResult = postsResult
        let sut = GetFiftyFirstPostsUseCase(blogRepository: repository)
        return (sut, repository)
    }

    @Test func filtersPostsWithIdUnderFifty() async throws {
        let posts = [
            Post(userId: 1, id: 1, title: "First", body: "body"),
            Post(userId: 1, id: 49, title: "Under fifty", body: "body"),
            Post(userId: 1, id: 50, title: "Fifty", body: "body"),
            Post(userId: 1, id: 99, title: "Over fifty", body: "body"),
        ]
        let (sut, _) = makeSUT(postsResult: .success(posts))

        let result = try await sut.execute()

        #expect(result.count == 2)
        #expect(result[0].id == 1)
        #expect(result[1].id == 49)
    }

    @Test func returnsEmptyWhenNoPostsMatchFilter() async throws {
        let posts = [
            Post(userId: 1, id: 50, title: "Fifty", body: "body"),
            Post(userId: 1, id: 100, title: "Hundred", body: "body"),
        ]
        let (sut, _) = makeSUT(postsResult: .success(posts))

        let result = try await sut.execute()

        #expect(result.isEmpty)
    }

    @Test func returnsAllPostsWhenAllUnderFifty() async throws {
        let posts = [
            Post(userId: 1, id: 1, title: "One", body: "body"),
            Post(userId: 1, id: 25, title: "Twenty five", body: "body"),
            Post(userId: 1, id: 49, title: "Forty nine", body: "body"),
        ]
        let (sut, _) = makeSUT(postsResult: .success(posts))

        let result = try await sut.execute()

        #expect(result.count == 3)
    }

    @Test func returnsEmptyWhenRepositoryReturnsEmpty() async throws {
        let (sut, _) = makeSUT(postsResult: .success([]))

        let result = try await sut.execute()

        #expect(result.isEmpty)
    }

    @Test func throwsFailedToGetPostsWhenRepositoryFails() async {
        let (sut, _) = makeSUT(postsResult: .failure(.failedToGetPosts))

        await #expect(throws: FetchPostWithIdUnderFiftyError.failedToGetPosts) {
            try await sut.execute()
        }
    }
}
