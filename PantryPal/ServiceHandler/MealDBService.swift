import Foundation

class MealDBService: ObservableObject {
    @Published var meals: [MealModel] = []

    func fetchMeals(query: String) {
        // Prevent API call if query is empty
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            DispatchQueue.main.async {
                self.meals = []  // Ensure meals is empty
            }
            return
        }

        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(query)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error: No data received")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
                DispatchQueue.main.async {
                    self.meals = decodedData.meals ?? []
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}
