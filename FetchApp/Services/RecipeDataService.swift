protocol RecipeDataService {
    func fetchRecipes(query: RecipeQuery?) async throws -> [Recipe]
}
