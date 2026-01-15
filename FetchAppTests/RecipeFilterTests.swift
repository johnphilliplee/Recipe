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
            dietaryAttributes: [.vegetarian]
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
            dietaryAttributes: []
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
            dietaryAttributes: [.vegetarian]
        ),
        Recipe(
            id: UUID(),
            title: "Vegan Buddha Bowl",
            description: "A nourishing bowl with quinoa, roasted chickpeas, and fresh vegetables.",
            image: "vegan-buddha-bowl",
            servings: 2,
            ingredients: [
                "quinoa",
                "chickpeas",
                "spinach",
                "carrot",
                "cucumber",
                "avocado",
                "olive oil",
                "lemon juice"
            ],
            instructions: [
                "Cook quinoa according to package instructions.",
                "Roast chickpeas with olive oil until crispy.",
                "Prepare fresh vegetables by chopping carrot, cucumber, and avocado.",
                "Assemble bowl with quinoa, chickpeas, and vegetables.",
                "Drizzle with lemon juice and serve."
            ],
            dietaryAttributes: [.vegan, .glutenFree]
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
        let query = RecipeQuery(dietaryAttributes: [.vegetarian])

        // Act
        let result = filter.apply(query, to: recipes)

        // Assert
        #expect(result.count == 2)
    }

    @Test
    func filterByVegan() async throws {
        let filter = RecipeFilter()
        let query = RecipeQuery(dietaryAttributes: [.vegan])

        let result = filter.apply(query, to: recipes)

        #expect(result.count == 1)
    }

    @Test
    func filterByGlutenFree() async throws {
        let filter = RecipeFilter()
        let query = RecipeQuery(dietaryAttributes: [.glutenFree])

        let result = filter.apply(query, to: recipes)

        #expect(result.count == 1)
    }

    @Test
    func filterByVeganAndGlutenFree() async throws {
        let filter = RecipeFilter()
        let query = RecipeQuery(dietaryAttributes: [.vegan, .glutenFree])

        let result = filter.apply(query, to: recipes)

        #expect(result.count == 1)
    }

    @Test
    func filterByNoAttributesShouldReturnAll() async throws {
        let filter = RecipeFilter()
        let query = RecipeQuery(dietaryAttributes: nil)

        let result = filter.apply(query, to: recipes)

        #expect(result.count == recipes.count)
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
        #expect(result.count == 2)
    }

    @Test
    func filterByExcludeIngredient() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(exclude: ["chicken"])

        // Act
        let result = filter.apply(query, to: recipes)

        #expect(result.count == 3)
    }

    @Test
    func filterCombined() async throws {
        // Arrange
        let filter = RecipeFilter()
        let query = RecipeQuery(dietaryAttributes: [.vegetarian], servings: 2, include: ["tomato"])

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
        #expect(result.count == 4)
    }

}
