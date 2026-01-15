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
                Text("Empty")
            case .data(let recipes):
                RecipeListDataView(recipes: recipes)
                    .padding(.horizontal)
            case .error(let error):
                Text("Error: \(error.localizedDescription)")
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
