//
//  MealDBService.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/15/25.
//

import Foundation

class MealDBService: ObservableObject {
    @Published var meals: [MealModel] = []

    func fetchMeals(query: String) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(query)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.meals = decodedData.meals ?? []
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }.resume()
    }
}
