import SwiftUI

struct NavigationHeader: View {
    let title: String
    let subtitle: String
    let onSearchTapped: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.orange)
            }

            Spacer()

            Button(action: onSearchTapped) {
                Image(systemName: "magnifyingglass") .foregroundColor(.white)
                    .padding(8)
            }
            .background(Color.orange)
            .clipShape(Circle())
        }
    }
}
