import SwiftUI

struct RecipeListView: View {
    @State private var viewModel = ListContentViewModel(service: LocalRecipeDataService())

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
        .refreshable { await loadRecipes() }
        .task { await loadRecipes() }
    }

    private func loadRecipes() async {
        await viewModel.loadRecipes()
    }
}

#Preview {
    RecipeListView()
        .background(.gray.opacity(0.3))
}
