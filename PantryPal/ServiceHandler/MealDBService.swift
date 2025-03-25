import Foundation

class MealDBService: ObservableObject {
    @Published var meals: [MealModel] = []
    
    init() {
        getThreeRandomMeals()
    }

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

    /**
     * getThreeRandomMeals -> Returns a list of meals randomly grabbed from TheMealDB API.
     */
    func getThreeRandomMeals() {

        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php") else {return}
        
        // Simple for loop that iterates 3 times. Could be abstracted to use a constant we define above, but for now this works.
        for _ in 0..<3 {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data else {
                    print("Error: No data received")
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
                    DispatchQueue.main.async {
                        // TheMealDB returns lists by default and we're requesting 1 item, hence why we grab .first
                        if let randomMeal = decodedData.meals?.first {
                            self.meals.append(randomMeal)
                        }
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
                
            }.resume()
        }
        
    }
}
