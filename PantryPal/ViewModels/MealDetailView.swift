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
