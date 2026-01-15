import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            Image(recipe.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .clipped()

            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Image(systemName: "person")
                    Text("Serves: \(recipe.servings)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                if !recipe.dietaryAttributes.isEmpty {
                    DietaryAttributesView(
                        selectedAttributes: recipe.dietaryAttributes,
                        showNonSelected: false,
                        onToggle: nil,
                        title: nil
                    )
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack {
                            Image(systemName: "fork.knife")
                                .font(.caption)
                                .foregroundStyle(.orange)
                            Text(ingredient)
                        }
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.headline)
                    ForEach(
                        Array(recipe.instructions.enumerated()),
                        id: \.offset
                    ) { index, step in
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .fontWeight(.bold)
                            Text(step)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Recipe")
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(
        title: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with eggs, cheese, pancetta, and pepper.",
        image: "veggie-pasta",
        servings: 4,
        ingredients: ["Spaghetti", "Eggs", "Parmesan", "Pancetta", "Black Pepper"],
        instructions: [
            "Boil pasta until al dente.",
            "Cook pancetta until crispy.",
            "Mix eggs and cheese in a bowl.",
            "Combine pasta, pancetta, and egg mixture.",
            "Season with black pepper and serve."
        ],
        dietaryAttributes: [.glutenFree, .vegetarian]
    ))
}
