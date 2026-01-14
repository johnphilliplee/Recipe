struct RecipeFilter {
    func apply(_ query: RecipeQuery?, to recipes: [Recipe]) -> [Recipe] {
        guard let query else { return recipes }

        return recipes.filter { recipe in
            if let text = query.text {
                let matchesText =
                recipe.title.localizedCaseInsensitiveContains(text) ||
                recipe.description.localizedCaseInsensitiveContains(text) ||
                recipe.instructions.contains {
                    $0.localizedCaseInsensitiveContains(text)
                }

                if !matchesText {
                    return false
                }
            }

            // Vegetarian filter
            if let isVegetarian = query.isVegetarian, recipe.isVegetarian != isVegetarian {
                return false
            }

            // Servings filter
            if let servings = query.servings, recipe.servings != servings {
                return false
            }

            // Include ingredients
            if let include = query.include, !include.allSatisfy({ ingredient in
                recipe.ingredients.contains {
                    $0.localizedCaseInsensitiveContains(ingredient)
                }
            }) {
                return false
            }

            // Exclude ingredients
            if let exclude = query.exclude,
               exclude.contains(where: { ingredient in
                   recipe.ingredients.contains {
                       $0.localizedCaseInsensitiveContains(ingredient)
                   }}) {
                return false
            }

            return true
        }
    }
}
