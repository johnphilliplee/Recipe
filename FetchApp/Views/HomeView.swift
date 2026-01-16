import SwiftUI

struct HomeView: View {
    @State private var showSearchSheet = false
    @State private var activeQuery: RecipeQuery?

    var body: some View {
        NavigationStack {
            NavigationHeader(
                title: "Recipe",
                subtitle: "Trending",
                onSearchTapped: { showSearchSheet = true }
            )
            .padding(.vertical, 12)
            .padding(.horizontal)

            RecipeListView(query: activeQuery)
                .background(Color(.systemGray6))
        }
        .sheet(isPresented: $showSearchSheet) {
            SearchSheetView(onSubmit: {
                activeQuery = $0
            })
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        .tint(.orange)
    }
}

#Preview {
    HomeView()
}
