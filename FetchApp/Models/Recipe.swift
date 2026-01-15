import Foundation

struct Recipe: Identifiable {
    var id: UUID = UUID()
    let title: String
    let description: String
    let image: String
    let servings: Int
    let ingredients: [String]
    let instructions: [String]
    let dietaryAttributes: Set<DietaryAttribute>

    enum CodingKeys: String, CodingKey {
        case title, description, image, servings, ingredients, instructions, dietaryAttributes
    }
}

extension Recipe: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decode(String.self, forKey: .image)
        servings = try container.decode(Int.self, forKey: .servings)
        ingredients = try container.decode([String].self, forKey: .ingredients)
        instructions = try container.decode([String].self, forKey: .instructions)

        if let attributes = try? container.decode(Set<DietaryAttribute>.self, forKey: .dietaryAttributes) {
            dietaryAttributes = attributes
        } else {
            dietaryAttributes = []
        }
    }
}
