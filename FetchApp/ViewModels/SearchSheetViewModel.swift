import Observation

@Observable
class SearchSheetViewModel {
    var query = RecipeQuery()

    func toggleAttribute(_ attribute: DietaryAttribute) {
        if query.dietaryAttributes?.contains(attribute) == true {
            query.dietaryAttributes?.remove(attribute)
        } else {
            query.dietaryAttributes = (query.dietaryAttributes ?? []).union([attribute])
        }
    }

    func addInclude(_ ingredient: String) {
        if !query.include.contains(ingredient) {
            query.include.append(ingredient)
        }
    }

    func removeInclude(_ ingredient: String) {
        query.include.removeAll { $0 == ingredient }
    }

    func addExclude(_ ingredient: String) {
        if !query.exclude.contains(ingredient) {
            query.exclude.append(ingredient)
        }
    }

    func removeExclude(_ ingredient: String) {
        query.exclude.removeAll { $0 == ingredient }
    }
}
