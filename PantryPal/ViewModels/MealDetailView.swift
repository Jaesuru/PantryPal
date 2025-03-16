//
//  MealDetailView.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/15/25.
//

import SwiftUI

struct MealDetailView: View {
    let meal: MealModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(meal.strMeal)
                .font(.largeTitle)
                .padding()

            Spacer()
        }
        .navigationTitle(meal.strMeal)
    }
}

#Preview {
    MealDetailView(meal: MealModel(
        idMeal: "52772",
        strMeal: "Spaghetti Carbonara",
        strMealThumb: "https://www.themealdb.com/images/media/meals/llcbn01574260722.jpg",
        strInstructions: "Cook spaghetti. Fry pancetta. Mix eggs and cheese. Combine everything."
    ))
}
