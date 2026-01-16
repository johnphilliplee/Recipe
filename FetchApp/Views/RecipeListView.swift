import SwiftUI

struct RecipeListView: View {
    @State private var viewModel = ListContentViewModel(service: LocalRecipeDataService())
    var query: RecipeQuery?

    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .initial:
                Text("Initial")
            case .loading:
                Text("Loading")
            case .empty:
                StateMessageView(
                    type: .empty,
                    title: "No recipes found",
                    message: "Try adjusting your search to get more results",
                    systemImage: "fork.knife"
                )
            case .data(let recipes):
                RecipeListDataView(recipes: recipes)
                    .padding(.horizontal)
            case .error:
                StateMessageView(
                    type: .error,
                    title: "Oops!",
                    message: "An unexpected error occurred",
                    systemImage: "exclamationmark.triangle",
                    onRetry: {
                        Task { await loadRecipes(query: query) }
                    }
                )
            }
        }
        .refreshable { await loadRecipes(query: query) }
        .onChange(of: query, initial: true) { _, newQuery in
            Task {
                await viewModel.loadRecipes(query: newQuery)
            }
        }
    }

    private func loadRecipes(query: RecipeQuery? = nil) async {
        await viewModel.loadRecipes(query: query)
    }
}

#Preview {
    RecipeListView()
        .background(.gray.opacity(0.3))
}
