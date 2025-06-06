//
//  ContentView.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mealDBService : MealDBService
    @State private var searchText = ""
    @State private var searchPerformed = false
    @State private var lastSearchQuery = ""
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Image("PantryPalHome")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding(.top, -150)
                    
                    HStack {
                        ZStack(alignment: .trailing) {
                            TextField("Search for a meal...", text: $searchText, onCommit: {
                                // Only perform search if searchText is not empty
                                if !searchText.isEmpty {
                                    mealDBService.fetchMeals(query: searchText)
                                    lastSearchQuery = searchText
                                    searchPerformed = true
                                }
                            })
                            .padding(10)
                            .padding(.leading, 10)
                            .padding(.trailing, 40) // Make space for the clear button
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x:0, y: 2)
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                            
                            // Clear button with fixed positioning
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 15)
                                .onTapGesture {
                                    // Clear search text and reset search results
                                    searchText = ""
                                }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, -90)
                    
                    
                    ScrollView {
                        VStack {
                            Divider()
                                .frame(height: 1)
                                .background(Color(red: 31/255, green: 125/255, blue: 83/255))
                                .padding(.horizontal, 20)
                            HStack {
                                Text("Fresh Finds")
                                    .font(.custom("Mont-ExtraLightDEMO", size: 36))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 37/255, green: 95/255, blue: 56/255))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(10)
                                    .padding(.leading, 10)
                            }
                            .frame(width: .infinity, height: 150)
                            .padding(.top, -40)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(mealDBService.todaysRandomMeals, id: \.self) { meal in
                                        NavigationLink(destination: MealDetailView(meal: meal)) {
                                            ZStack {
                                                AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                                    image.resizable()
                                                    
                                                        .scaledToFill()
                                                        .frame(width: 280, height: 200)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        .clipped()
                                                        .overlay(
                                                            Color.black.opacity(0.1)
                                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        )
                                                    
                                                        .shadow(color: Color.black.opacity(0.4), radius: 1, x: 6, y: 2)
                                                    
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
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(0.1), radius: 4, x:0, y: 2)
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .regular, design: .rounded))
                                            .padding(.horizontal, 8)
                                            .frame(width: 320, height: 150)
                                        }
                                    }
                                }
                            }
                            .frame(width: .infinity, height: 200)
                            .padding(.top, -60)
                            .padding(.bottom, 50)
                        }
                        
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color(red: 31/255, green: 125/255, blue: 83/255))                        .padding(.horizontal, 20)
                            .padding(.top, -30)
                        
                        if searchPerformed {
                            HStack {
                                Text("Results for \"\(lastSearchQuery)\"")
                                    .font(.custom("Mont-ExtraLightDEMO", size: 32))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 37/255, green: 95/255, blue: 56/255))                                .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 14)
                                
                                
                                Button(action: {
                                    // Clear search results
                                    searchPerformed = false
                                    lastSearchQuery = ""
                                    mealDBService.meals = [] // Assuming MealDBService has a meals property
                                }) {
                                    Text("Clear Results")
                                        .font(.system(size: 8, weight: .medium))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.black)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(10)
                        } else {
                            Image("PantryPalLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        
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
                                                .shadow(color: Color.black.opacity(0.4), radius: 1, x: 6, y: 2)
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
                .refreshable {
                    mealDBService.todaysRandomMeals.removeAll() // Clear old meals
                    mealDBService.getRandomMeals() // Fetch new ones
                    mealDBService.meals.removeAll()
                    mealDBService.fetchMeals(query: lastSearchQuery)
                }
            }
            .tabItem {
                      Label("Home", systemImage: "house")
                     }
            NavigationView {
                favoritesView().environmentObject(mealDBService)
                       }
            .tabItem{
                Label("Favorites", systemImage: "star")
            }
            NavigationView {
                           SettingsView(isDarkMode: $isDarkMode)
                       }
            .tabItem {
                Label("Settings", systemImage: "gear")
                    }
            
        }
        
    }
    
   
}

struct favoritesView: View {
    @EnvironmentObject var favoriteManager: MealDBService
    
    var body: some View {
        VStack {
            Text("Favorites")
                .font(.custom("Mont-ExtraLightDEMO", size: 32))
                .fontWeight(.bold)
                .padding(.top)
            
            if favoriteManager.favorites.isEmpty {
                Spacer()
                Text("No favorites yet")
                    .font(.title2)
                    .foregroundColor(.gray)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(favoriteManager.favorites, id: \.id) { meal in
                            NavigationLink(destination: MealDetailView(meal: meal)) {
                                // Container ZStack with fixed size
                                ZStack(alignment: .bottom) {
                                    // Image container with clipping
                                    AsyncImage(
                                        url: URL(string: meal.strMealThumb),
                                        transaction: Transaction(animation: .spring())
                                    ) { phase in
                                        switch phase {
                                        case .empty:
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .overlay(ProgressView())
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                                                .clipped() // This is crucial - clips the image to its frame
                                        case .failure:
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .overlay(
                                                    Image(systemName: "exclamationmark.triangle")
                                                        .foregroundColor(.gray)
                                                )
                                        @unknown default:
                                            Rectangle().fill(Color.gray.opacity(0.3))
                                        }
                                    }
                                    
                                    Text(meal.strMeal)
                                        .font(.custom("Mont-HeavyDEMO", size: 24))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

struct SettingsView: View {
    @Binding var isDarkMode: Bool

    var body: some View {
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.custom("Mont-ExtraLightDEMO", size: 32))
                    .fontWeight(.bold)

                Toggle(isOn: $isDarkMode) {
                    Text(isDarkMode ? "Dark Mode" : "Light Mode")
                        .font(.headline)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                Spacer()
            }
            .padding()
        }
}

#Preview {
    ContentView()
        .environmentObject(MealDBService())
}
