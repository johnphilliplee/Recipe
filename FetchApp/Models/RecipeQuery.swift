struct RecipeQuery {
    var text: String?
    var dietaryAttributes: Set<DietaryAttribute>?
    var servings: Int?
    var include: [String] = []
    var exclude: [String] = []
}

extension RecipeQuery: Equatable {}
