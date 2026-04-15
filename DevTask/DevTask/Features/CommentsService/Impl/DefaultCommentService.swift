import Foundation

nonisolated class DefaultCommentService: CommentsService {

    private let session: URLSession
    private let decoder: JSONDecoder

    // Inject session for testability
    // With more services I would build and inject a "HTTP/REST/BFF" client
    public init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getComments(for postId: Int) async throws(CommentsServiceError) -> [Comment] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com//comments?postId=\(postId)") else {
            throw .invalidURL
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(from: url)
        } catch {
            print("Network error: \(error)")
            throw .networkError(error)
        }

        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? -1
            print("Unexpected status code: \(code)")
            throw .unexpectedStatusCode(code)
        }

        do {
            return try decoder.decode([Comment].self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw .decodingError(error)
        }
    }
}
