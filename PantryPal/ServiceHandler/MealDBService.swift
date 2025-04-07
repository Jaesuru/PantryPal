import Foundation

class MealDBService: ObservableObject {
    @Published var meals: [MealModel] = []
    @Published var todaysRandomMeals: [MealModel] = []
    @Published var favorites : [MealModel] = []
    
    init() {
        getRandomMeals()
    }
    
    func addFavorite(meal : MealModel){
        print("Adding \(meal.id) favorite")
        if(!favorites.contains(where : {$0.id == meal.id})){
        favorites.append(meal)
        }else{
            print("Already in favorites!")
        }
    }
    
    func isFavorited(meal: MealModel) -> Bool{
        return favorites.contains(where : {$0.id == meal.id})
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
                    self.meals = decodedData.meals?.shuffled() ?? []
                }
            } catch {
                print("Error decoding: \(error)")
            }
        }.resume()
    }

    func getRandomMeals() {
        DispatchQueue.main.async {
            self.todaysRandomMeals.removeAll() // Clear old meals before fetching
        }
        
        let dispatchGroup = DispatchGroup()
        var newMeals: [MealModel] = []
        
        for _ in 0..<20 { // change for amount
            dispatchGroup.enter()
            
            guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php") else {
                dispatchGroup.leave()
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("Error: No data received")
                    dispatchGroup.leave()
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
                    if let randomMeal = decodedData.meals?.first {
                        newMeals.append(randomMeal)
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
                dispatchGroup.leave()
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.todaysRandomMeals = newMeals // Ensure UI updates
        }
    }

}
