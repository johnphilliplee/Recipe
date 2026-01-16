enum DietaryAttribute: String, Codable, CaseIterable {
    case vegetarian
    case vegan
    case glutenFree
    case dairyFree
    case keto
    case paleo
    case nutFree
    case halal
    case kosher
}

extension DietaryAttribute {
    var displayName: String {
        switch self {
        case .vegetarian:
            "Vegetarian"
        case .vegan:
            "Vegan"
        case .glutenFree:
            "Gluten-free"
        case .dairyFree:
            "Dairy-free"
        case .keto:
            "Keto"
        case .paleo:
            "Paleo"
        case .nutFree:
            "Nut-free"
        case .halal:
            "Halal"
        case .kosher:
            "Kosher"
        }
    }
}
