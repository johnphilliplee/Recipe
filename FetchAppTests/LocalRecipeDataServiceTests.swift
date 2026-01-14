import Foundation
import Testing
@testable import FetchApp

@Suite("Local Recipe Data Service Tests")
class LocalRecipeDataServiceTests {
    @Test
    func fetchRecipeLoadsFromBundle() async throws {
        // Arrange
        let bundle = Bundle(for: LocalRecipeDataServiceTests.self)
        let localRecipeDataService = LocalRecipeDataService(
            fileName: "test-recipes",
            ext: "json",
            bundle: bundle
        )
        let expectedTitles = ["Mushroom Risotto", "Beef Stir-Fry", "Fruit Smoothie"]

        // Act
        let recipes = try await localRecipeDataService.fetchRecipes(query: nil)

        // Assert
        #expect(!recipes.isEmpty)
        #expect(recipes.count == 3)
        for (index, recipe) in recipes.enumerated() {
            #expect(recipe.title == expectedTitles[index])
        }
    }

    @Test
    func fetchFromNonExistingFileThrowsError() async throws {
        // Arrange
        let bundle = Bundle(for: LocalRecipeDataServiceTests.self)
        let localRecipeDataService = LocalRecipeDataService(
            fileName: "non-existing",
            ext: "json",
            bundle: bundle
        )

        // Act + Assert
        await #expect(throws: DataServiceError.fileLoadingError) {
            _ = try await localRecipeDataService.fetchRecipes(query: nil)
        }
    }

    @Test
    func fetchFromInvalidDataThrowsError() async throws {
        // Arrange
        let bundle = Bundle(for: LocalRecipeDataServiceTests.self)
        let localRecipeDataService = LocalRecipeDataService(
            fileName: "test-recipes-with-invalid-data",
            ext: "json",
            bundle: bundle
        )

        // Act + Assert
        await #expect(throws: (any Error).self) {
            _ = try await localRecipeDataService.fetchRecipes(query: nil)
        }
    }

    @Test
    func fetchFromInvalidJSONFormatThrowsError() async throws {
        // Arrange
        let bundle = Bundle(for: LocalRecipeDataServiceTests.self)
        let localRecipeDataService = LocalRecipeDataService(
            fileName: "test-recipes-invalid-json-format",
            ext: "json",
            bundle: bundle
        )

        // Act + Assert
        await #expect(throws: (any Error).self) {
            _ = try await localRecipeDataService.fetchRecipes(query: nil)
        }
    }
}
