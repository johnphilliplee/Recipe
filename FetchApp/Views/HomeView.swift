import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            NavigationHeader(
                title: "Recipe",
                subtitle: "Trending"
            )
            .padding(.vertical, 12)
            .padding(.horizontal)

            RecipeListView()
                .background(Color(.systemGray6))

            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
