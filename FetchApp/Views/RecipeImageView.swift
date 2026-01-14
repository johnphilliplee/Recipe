import SwiftUI

struct RecipeImageView: View {
    let imageNameOrURL: String?

    var body: some View {
        if let imageNameOrURL {
            if let url = URL(string: imageNameOrURL), url.scheme != nil {
                // Remote asset
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure:
                        fallback
                    @unknown default:
                        fallback
                    }
                }
            } else {
                Image(imageNameOrURL)
                    .resizable()
                    .scaledToFit()
            }
        } else {
            fallback
        }
    }

    private var fallback: some View {
        Color.gray.opacity(0.3)
    }
}

#Preview {
    RecipeImageView(imageNameOrURL: "veggie-pasta")
}
