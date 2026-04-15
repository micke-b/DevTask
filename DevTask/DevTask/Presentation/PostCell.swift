import SwiftUI

struct PostCell: View {

    let post: Post

    init(_ post: Post) {
        self.post = post
    }

    var header: some View {
        HStack {
            Text("id: #\(post.id)")
                .font(.caption.monospacedDigit())
                .foregroundStyle(DesignTokens.onSurfaceVariant)
            Text("user: #\(post.userId)")
                .font(.caption.monospacedDigit())
                .foregroundStyle(DesignTokens.onSurfaceVariant)
            Spacer()
        }
    }

    var bodySection: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.title3)
                    .foregroundStyle(DesignTokens.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(post.body)
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    var body: some View {
        HStack {
            VStack {
                header
                Divider()
                bodySection
            }
            VStack {
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(DesignTokens.onSurfaceVariant.opacity(0.5))
                    .accessibilityHidden(true)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 16))
    }
}

#Preview {
    PostCell(Post(userId: 1, id: 1, title: "title", body: "body"))
        .frame(maxWidth: .infinity)
        .frame(height: 100)
}
