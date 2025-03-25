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
                
                ScrollView {
                    HStack {
                        Text("Today's curated meals")
                            .font(.custom("Mont-HeavyDEMO", size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .cornerRadius(10)
                    }.frame(width: .infinity, height: 150)
                        .padding(.top, -60)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(mealDBService.todaysRandomMeals, id: \.self) { meal in
                                NavigationLink(destination: MealDetailView(meal: meal)) {
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
                                    .padding(20)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x:0, y: 2)
                                    .foregroundColor(.black)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                    .padding(.horizontal, 8)
                                    .frame(height: 150)
                                    .background(NavigationLink("", destination: MealDetailView(meal: meal)).opacity(0))
                                }
                            }
                        }
                    }.frame(width: .infinity, height: 200)
                        .padding(.top, -60)
                        .padding(.bottom, 50)
                    
                    LazyVStack {
                        ForEach(mealDBService.meals, id: \.self) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal)) {
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
                                .frame(width: 350, height: 150)
                                .background(NavigationLink("", destination: MealDetailView(meal: meal)).opacity(0))
                                .padding(.bottom, 20)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
