import Foundation

struct Recipe: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let description: String
    let image: String
    let servings: Int
    let ingredients: [String]
    let instructions: [String]
    let isVegetarian: Bool

    enum CodingKeys: String, CodingKey {
        case title, description, image, servings, ingredients, instructions, isVegetarian
    }
}
