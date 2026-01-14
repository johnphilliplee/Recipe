import Foundation
import Testing
@testable import FetchApp

@Suite("Recipe Filter Tests")
struct RecipeFilterTests {
    let recipes: [Recipe] = [
        Recipe(
            id: UUID(),
            title: "Veggie Pasta",
            description: "Delicious vegetarian pasta with tomato sauce",
            image: "veggie-pasta",
            servings: 2,
            ingredients: ["pasta", "tomato", "cheese"],
            instructions: [
                "Boil pasta until al dente",
                "Prepare tomato sauce",
                "Mix together and top with cheese"
            ],
            isVegetarian: true
        ),
        Recipe(
            id: UUID(),
            title: "Chicken Curry",
            description: "Spicy chicken curry with rice",
            image: "chicked-curry",
            servings: 4,
            ingredients: ["chicken", "curry", "rice"],
            instructions: [
                "Cook chicken until browned",
                "Add curry paste",
                "Simmer and serve with rice"
            ],
            isVegetarian: false
        ),
        Recipe(
            id: UUID(),
            title: "Salad",
            description: "Fresh garden salad",
            image: "salad",
            servings: 1,
            ingredients: ["lettuce", "tomato", "cucumber"],
            instructions: [
                "Wash and chop vegetables",
                "Toss together in a bowl",
                "Serve chilled"
            ],
            isVegetarian: true
        )
    ]

    @Test
    func filterByTextInTitle() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(text: "Pasta")

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 1)
        #expect(result.first?.title == "Veggie Pasta")
    }

    @Test
    func filterByTextInDescription() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(text: "Spicy")

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 1)
        #expect(result.first?.title == "Chicken Curry")
    }

    @Test
    func filterByVegetarian() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(isVegetarian: true)

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 2)
    }

    @Test
    func filterByServings() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(servings: 4)

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 1)
        #expect(result.first?.title == "Chicken Curry")
    }

    @Test
    func filterByIncludeIngredient() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(include: ["tomato"])

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 2) // Pasta + Salad
    }

    @Test
    func filterByExcludeIngredient() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(exclude: ["chicken"])

        // Act
        let result = filter.apply(query, to: recipes)

        #expect(result.count == 2) // Pasta + Salad
    }

    @Test
    func filterCombined() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(isVegetarian: true, servings: 2, include: ["tomato"])

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 1)
        #expect(result.first?.title == "Veggie Pasta")
    }

    @Test
    func noFilter() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query: RecipeQuery? = nil

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 3)
    }

}
