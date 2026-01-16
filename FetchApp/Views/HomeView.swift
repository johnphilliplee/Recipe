import SwiftUI

struct HomeView: View {
    @State private var showSearchSheet = false
    @State private var activeQuery: RecipeQuery?

    var body: some View {
        NavigationStack {
            NavigationHeader(
                title: "Recipe",
                subtitle: "Find your next meal idea",
                onSearchTapped: { showSearchSheet = true }
            )
            .padding(.vertical, 12)
            .padding(.horizontal)

            RecipeListView(query: activeQuery)
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
