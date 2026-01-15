struct RecipeFilter {
    func apply(_ query: RecipeQuery?, to recipes: [Recipe]) -> [Recipe] {
        guard let query else { return recipes }

        return recipes.filter { recipe in
            matchesText(query.text, in: recipe) &&
            matchesDietaryAttributes(query.dietaryAttributes, recipe) &&
            matchesServings(query.servings, recipe) &&
            includesIngredients(query.include, recipe) &&
            excludesIngredients(query.exclude, recipe)
        }
    }

    // MARK: - Helpers

    private func matchesText(_ text: String?, in recipe: Recipe) -> Bool {
        guard let text else { return true }

        return recipe.title.localizedCaseInsensitiveContains(text)
        || recipe.description.localizedCaseInsensitiveContains(text)
        || recipe.instructions.contains { $0.localizedCaseInsensitiveContains(text) }
    }

    private func matchesDietaryAttributes(_ requiredAttributes: Set<DietaryAttribute>?, _ recipe: Recipe) -> Bool {
        guard let requiredAttributes else { return true }

        // OR logic: true if there's at least one overlap
        return !recipe.dietaryAttributes.isDisjoint(with: requiredAttributes)
    }

    private func matchesServings(_ servings: Int?, _ recipe: Recipe) -> Bool {
        guard let servings else { return true }

        return recipe.servings == servings
    }

    private func includesIngredients(_ include: [String]?, _ recipe: Recipe) -> Bool {
        guard let include else { return true }

        return include.allSatisfy { ingredient in
            recipe.ingredients.contains { $0.localizedCaseInsensitiveContains(ingredient) }
        }
    }

    private func excludesIngredients(_ exclude: [String]?, _ recipe: Recipe) -> Bool {
        guard let exclude else { return true }

        return !exclude.contains { ingredient in
            recipe.ingredients.contains { $0.localizedCaseInsensitiveContains(ingredient) }
        }
    }
}
