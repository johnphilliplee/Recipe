import SwiftUI

struct IngredientsInputView: View {
    let title: String
    var ingredients: [String]
    var onAdd: (String) -> Void
    var onRemove: (String) -> Void

    @State private var newIngredient: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            HStack {
                TextField("Enter ingredient", text: $newIngredient)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .keyboardType(.default)

                Button(action: {
                    let trimmed = newIngredient.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }
                    onAdd(trimmed)
                    newIngredient = ""
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.orange)
                })
            }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient.capitalized)
                            .font(.subheadline)
                        Button(action: {
                            onRemove(ingredient)
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                        })
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Capsule())
                }
            }
        }
    }
}

#Preview {
    IngredientsInputView(
        title: "Ingredients",
        ingredients: ["Chicken", "Corn"],
        onAdd: { _ in},
        onRemove: { _ in }
    )
}
