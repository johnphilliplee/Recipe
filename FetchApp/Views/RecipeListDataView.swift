import SwiftUI

struct RecipeListDataView: View {
    var recipes: [Recipe]

    var body: some View {
        VStack {
            ForEach(recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    RecipeRow(recipe: recipe)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 4)
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    RecipeListDataView(recipes: [
        Recipe(
            id: UUID(),
            title: "Mushroom Risotto",
            description: "Creamy risotto with mushrooms and parmesan cheese.",
            image: "mushroom-risotto",
            servings: 3,
            ingredients: [
                "arborio rice",
                "mushrooms",
                "parmesan",
                "vegetable broth"
            ],
            instructions: [
                "Cook rice slowly with broth, stirring often.",
                "Add sautéed mushrooms.",
                "Finish with parmesan."
            ],
            dietaryAttributes: [.vegetarian]
        ),
        Recipe(
            id: UUID(),
            title: "Mushroom Risotto",
            description: "Creamy risotto with mushrooms and parmesan cheese.",
            image: "mushroom-risotto",
            servings: 3,
            ingredients: [
                "arborio rice",
                "mushrooms",
                "parmesan",
                "vegetable broth"
            ],
            instructions: [
                "Cook rice slowly with broth, stirring often.",
                "Add sautéed mushrooms.",
                "Finish with parmesan."
            ],
            dietaryAttributes: [.vegetarian]
        )
    ])
}
