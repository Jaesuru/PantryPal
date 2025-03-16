//
//  ContentView.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mealDBService = MealDBService()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search for a meal...", text: $searchText, onCommit: {
                    mealDBService.fetchMeals(query: searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                // Meal List
                List(mealDBService.meals) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        HStack {
                            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            Text(meal.strMeal)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("PantryPal")
        }
    }
}


#Preview {
    ContentView()
}
