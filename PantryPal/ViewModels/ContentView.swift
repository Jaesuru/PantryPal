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
                HStack {
                    // Search Bar
                    TextField("Search for a meal...", text: $searchText, onCommit: {
                        mealDBService.fetchMeals(query: searchText)
                    })
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .padding(.leading, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x:0, y: 2)
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding(.horizontal, 20)
                }
                .padding(.top, 40)

                List(mealDBService.meals) { meal in
                    ZStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                                .scaledToFill() // Make sure the image fills the available space
                                .frame(height: 150) // Set a fixed height for the image
                                .clipShape(RoundedRectangle(cornerRadius: 15)) // Rounded corners for the image
                                .clipped() // Ensure the image stays within bounds
                                .overlay(
                                    Color.black.opacity(0.1)
                                        .clipShape(RoundedRectangle(cornerRadius: 15)) //
                                )
                        } placeholder: {
                            ProgressView()
                                .frame(height: 150)
                        }

                        VStack {
                            Spacer() // Push the text down to the bottom of the image
                            Text(meal.strMeal)
                                .font(.custom("Mont-HeavyDEMO", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.white) // White text for contrast
                                .padding() // Padding around the text
                                .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                                .cornerRadius(10) // Optional: rounded corners for the text background
                            
                        }
                    }
                    .frame(height: 150) // Set the height for the entire item
                    .background(NavigationLink("", destination: MealDetailView(meal: meal)).opacity(0))
                }

            }
            .navigationBarItems(
                leading: EmptyView(),
                trailing: EmptyView()
            )
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("PantryPalHome")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .padding(.top, 0)
                        .scaledToFill()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
