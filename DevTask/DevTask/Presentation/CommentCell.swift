import SwiftUI

struct CommentCell: View {

    let comment: Comment

    init(_ comment: Comment) {
        self.comment = comment
    }

    var header: some View {
        VStack(alignment: .leading) {
            Text(comment.email)
                .font(.caption.monospacedDigit())
                .foregroundStyle(DesignTokens.onSurfaceVariant)
                .lineLimit(1)
            Spacer()
            Text(comment.name)
                .font(.caption)
                .foregroundStyle(DesignTokens.onSurfaceVariant)
                .lineLimit(1)

        }
    }

    var bodySection: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading) {
                Text(comment.body)
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            header
            Divider()
            bodySection
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .glassEffect(.regular, in: .rect(cornerRadius: 16))
    }
}

#Preview {
    CommentCell(Comment(postId: 1, id: 1, name: "John Doe", email: "john@example.com", body: "This is a comment body"))
        .frame(maxWidth: .infinity)
        .frame(height: 100)
}
