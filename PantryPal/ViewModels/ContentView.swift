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
                Image("PantryPalHome")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(.top, -150)

                HStack {
                    TextField("Search for a meal...", text: $searchText, onCommit: {
                        mealDBService.fetchMeals(query: searchText)
                    })
                    .padding(10)
                    .padding(.leading, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x:0, y: 2)
                    .foregroundColor(.black)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding(.horizontal, 30)
                }
                .padding(.top, -90)

                List(mealDBService.meals) { meal in
                    ZStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                                .overlay(
                                    Color.black.opacity(0.1)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                )
                        } placeholder: {
                            ProgressView()
                                .frame(height: 150)
                        }

                        VStack {
                            Spacer()
                            Text(meal.strMeal)
                                .font(.custom("Mont-HeavyDEMO", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .cornerRadius(10)
                        }
                    }
                    .frame(height: 150)
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
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
