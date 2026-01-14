import Observation

@Observable
class ListContentViewModel {
    enum State {
        case initial
        case loading
        case empty
        case data([Recipe])
        case error(Error)
    }

    var state: State = .initial

    private let service: RecipeDataService

    init(service: RecipeDataService) {
        self.service = service
    }

    func loadRecipes() async {
        do {
            state = .loading
            let recipes = try await service.fetchRecipes(query: nil)
            state = .data(recipes)
        } catch {
            state = .error(error)
        }
    }
}
