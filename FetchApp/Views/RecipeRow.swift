import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RecipeImageView(imageNameOrURL: recipe.image)
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                Color(.systemGray).opacity(0.5),
                                lineWidth: 1
                            )
                    )

                if recipe.isVegetarian {
                    Image("leaf")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .cornerRadius(12)
                        .padding(6)
                        .scaledToFit()
                }
            }

            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 14)
                    Text("Serves: \(recipe.servings)")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(
                cornerRadius: 12
            )
            .stroke(
                Color(.systemGray).opacity(0.5),
                lineWidth: 1
            )
        )
        .shadow(
            color: Color(.systemGray).opacity(0.2),
            radius: 4,
            x: 0,
            y: 2
        )
    }
}

#Preview {
    RecipeRow(recipe:
        Recipe(
            title: "Mushroom Risotto",
            description: "Creamy risotto with mushrooms and parmesan cheese.",
            image: "mushroom-risotto", servings: 3,
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
            isVegetarian: true
        )
    )
}
