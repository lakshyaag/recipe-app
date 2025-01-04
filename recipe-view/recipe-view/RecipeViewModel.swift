import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var url: String = ""
    @Published var recipe: Recipe?
    @Published var isLoading: Bool = false
    
    func fetchRecipe() {
        guard let requestUrl = URL(string: "http://localhost:8000/process") else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["url": url]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        isLoading = true

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let recipeData = jsonResponse?["recipe"] as? [String: Any] {
                            let recipeJSON = try JSONSerialization.data(withJSONObject: recipeData, options: [])
                            let decoded = try JSONDecoder().decode(Recipe.self, from: recipeJSON)
                            self.recipe = decoded
                        } else {
                            print("Recipe key not found in response")
                        }
                    } catch {
                        print("Error decoding recipe: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching recipe: \(error)")
                }
            }
        }.resume()
    }

    func resetForm() {
        withAnimation {
            url = ""
            recipe = nil
            isLoading = false
        }
    }
}
