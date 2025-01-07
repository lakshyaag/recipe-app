import SwiftUI

enum RecipeError: LocalizedError, Equatable {
    case invalidURL
    case networkError(Error)
    case serverError(Int)
    case decodingError
    case emptyResponse
    case invalidRecipeURL

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL appears to be invalid. Please check and try again."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server error (HTTP \(code)). Please try again later."
        case .decodingError:
            return "Unable to process the recipe data. Please try a different recipe."
        case .emptyResponse:
            return "No recipe data found. Please try a different URL."
        case .invalidRecipeURL:
            return "Please enter a valid recipe URL."
        }
    }

    static func == (lhs: RecipeError, rhs: RecipeError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.decodingError, .decodingError),
            (.emptyResponse, .emptyResponse),
            (.invalidRecipeURL, .invalidRecipeURL):
            return true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}

class RecipeViewModel: ObservableObject {
    @Published var url: String = "https://www.skinnytaste.com/tofu-stir-fry-with-vegetables-in-a-soy-sesame-sauce/"
	@Published var recipe: Recipe?
    @Published var isLoading: Bool = false
    @Published var error: RecipeError?
    @Published var showError: Bool = false

    private func validateURL() -> Bool {
        guard !url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            error = .invalidRecipeURL
            showError = true
            return false
        }

        guard URL(string: url) != nil else {
            error = .invalidURL
            showError = true
            return false
        }

        return true
    }

    func fetchRecipe() {
        guard validateURL() else { return }
        guard let requestUrl = URL(string: "http://localhost:8000/process") else {
            error = .invalidURL
            showError = true
            return
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["url": url]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            self.error = .networkError(error)
            self.showError = true
            return
        }

        isLoading = true
        error = nil
        showError = false

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error {
                    self?.error = .networkError(error)
                    self?.showError = true
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self?.error = .networkError(
                        NSError(
                            domain: "", code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
                    self?.showError = true
                    return
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    self?.error = .serverError(httpResponse.statusCode)
                    self?.showError = true
                    return
                }

                guard let data = data else {
                    self?.error = .emptyResponse
                    self?.showError = true
                    return
                }

                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let recipeData = jsonResponse["recipe"] as? [String: Any] {
                        let recipeJSON = try JSONSerialization.data(withJSONObject: recipeData)
						let decoded = try JSONDecoder().decode(Recipe.self, from: recipeJSON)
                        self?.recipe = decoded
						print(decoded)
                    } else {
                        self?.error = .decodingError
                        self?.showError = true
                    }
                } catch {
                    self?.error = .decodingError
                    self?.showError = true
                }
            }
        }.resume()
    }

    func resetForm() {
        withAnimation {
            url = ""
            recipe = nil
            isLoading = false
            error = nil
            showError = false
        }
    }
}
