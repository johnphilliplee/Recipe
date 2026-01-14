import Foundation

enum DataServiceError: Error {
    case fileLoadingError
}

final class LocalRecipeDataService: RecipeDataService {
    private let filter = RecipeFilter()
    private let fileName: String
    private let ext: String
    private let bundle: Bundle

    init(
        fileName: String = "recipe",
        ext: String = "json",
        bundle: Bundle = Bundle.main
    ) {
        self.fileName = fileName
        self.ext = ext
        self.bundle = bundle
    }

    func fetchRecipes(query: RecipeQuery?) async throws -> [Recipe] {
        guard let url = bundle.url(forResource: fileName, withExtension: ext) else {
            throw DataServiceError.fileLoadingError
        }

        let data = try Data(contentsOf: url)

        let recipes = try JSONDecoder().decode([Recipe].self, from: data)
        return filter.apply(query, to: recipes)
    }
}
