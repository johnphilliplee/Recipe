import SwiftUI

struct SearchSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = SearchSheetViewModel()

    var onSubmit: (RecipeQuery) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SheetHeaderView(
                    title: "Search Recipes",
                    onClose: { dismiss()
                    })

                Divider()

                DietaryAttributesView(
                    selectedAttributes: viewModel.query.dietaryAttributes ?? [],
                    showNonSelected: true,
                    onToggle: { viewModel.toggleAttribute($0) },
                    title: "Dietary preferences"
                )

                Divider()

                ServingsInputView(servings: $viewModel.query.servings)

                Divider()

                IngredientsInputView(
                    title: "Include Ingredients",
                    ingredients: viewModel.query.include,
                    onAdd: { viewModel.addInclude($0) },
                    onRemove: { viewModel.removeInclude($0) }
                )

                Divider()

                IngredientsInputView(
                    title: "Exclude Ingredients",
                    ingredients: viewModel.query.exclude,
                    onAdd: { viewModel.addExclude($0) },
                    onRemove: { viewModel.removeExclude($0) }
                )

                InstructionsSearchView(
                    searchText: $viewModel.query.text
                )

                Divider()

                Button {
                    onSubmit(viewModel.query)
                    dismiss()
                } label: {
                    Text("Show Results")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .padding(.top, 20)
    }
}

#Preview {
    SearchSheetView(onSubmit: { _ in })
}
