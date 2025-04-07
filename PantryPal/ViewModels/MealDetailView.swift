//
//  MealDetailView.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/15/25.
//

import SwiftUI

struct MealDetailView: View {
    let meal: MealModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favoriteManager : MealDBService

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 100)
                AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 300)
                }

                VStack(alignment: .leading, spacing: 16) {
                    // Meal Name
                    Text(meal.strMeal)
                        .font(.custom("Mont-HeavyDEMO", size: 36))
                        .fontWeight(.bold)
                        .padding(.horizontal, 0)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .center)
                    VStack(alignment: .leading, spacing: 16) {
                        Divider()
                            .frame(height: 2)
                            .background(Color.gray.opacity(0.2))
                            .padding(.horizontal, 0)
                        
                        HStack {
                            Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                .foregroundColor(.black)
                            // Ingredients List
                            Text("Ingredients")
                                .font(.custom("Mont-HeavyDEMO", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 37/255, green: 95/255, blue: 56/255)) 
                        }
                        .padding(.leading, 12)
                        
                        VStack(alignment: .leading) {
                            ForEach(getIngredients(), id: \.self) { ingredient in
                                Text("• \(ingredient)")
                                    .font(.custom("Mont-ExtraLightDEMO", size: 16))
                                    .padding(.horizontal)
                            }
                        }
                        
                        Spacer()
                        Spacer()
                        Divider()
                            .frame(height: 2)
                            .background(Color.gray.opacity(0.2))
                            .padding(.horizontal, 0)
                        
                        
                        HStack {
                            Image(systemName: "list.bullet.rectangle.fill")
                                .foregroundColor(.black)
                                .padding(.leading, 12)
                            // Instructions
                            Text("Instructions")
                                .font(.custom("Mont-HeavyDEMO", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 37/255, green: 95/255, blue: 56/255))
                        }
                        
                        Text(meal.strInstructions)
                            .font(.custom("Mont-ExtraLightDEMO", size: 16))
                            .padding(.horizontal)
                            .padding(.bottom)
                            .lineSpacing(8)
                    }
                    .background(Color.gray.opacity(0.05))
                }
                .padding(.top, 30)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        // Transparent circle background
                        Circle()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 35, height: 35)
                        
                        // Back button image
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .imageScale(.large)
                    }
                }
            }
            ,trailing:
                                HStack {
                                    Button(action: {
                                        favoriteManager.addFavorite(id : meal.id)
                                        print(favoriteManager.isFavorited(id: meal.id))
                                    }) {
                                        ZStack {
                                            // Transparent circle background
                                            Circle()
                                                .fill(Color.white.opacity(0.8))
                                                .frame(width: 35, height: 35)
                                            
                                            // Back button image
                                            if(favoriteManager.isFavorited(id: meal.id)){
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.black)
                                                    .imageScale(.large)
                                            }
                                            else{
                                                Image(systemName: "star")
                                                    .foregroundColor(.black)
                                                    .imageScale(.large)
                                            }
                                        }
                                    }
                                }
        )
    }

    // Function to extract ingredients dynamically
    func getIngredients() -> [String] {
        let ingredients = [
            (meal.strMeasure1, meal.strIngredient1),
            (meal.strMeasure2, meal.strIngredient2),
            (meal.strMeasure3, meal.strIngredient3),
            (meal.strMeasure4, meal.strIngredient4),
            (meal.strMeasure5, meal.strIngredient5),
            (meal.strMeasure6, meal.strIngredient6),
            (meal.strMeasure7, meal.strIngredient7),
            (meal.strMeasure8, meal.strIngredient8),
            (meal.strMeasure9, meal.strIngredient9),
            (meal.strMeasure10, meal.strIngredient10),
            (meal.strMeasure11, meal.strIngredient11),
            (meal.strMeasure12, meal.strIngredient12),
            (meal.strMeasure13, meal.strIngredient13),
            (meal.strMeasure14, meal.strIngredient14),
            (meal.strMeasure15, meal.strIngredient15),
            (meal.strMeasure16, meal.strIngredient16),
            (meal.strMeasure17, meal.strIngredient17),
            (meal.strMeasure18, meal.strIngredient18),
            (meal.strMeasure19, meal.strIngredient19),
            (meal.strMeasure20, meal.strIngredient20)
        ]
        
        return ingredients.compactMap { measure, ingredient in
            if let measure = measure, let ingredient = ingredient,
               !measure.isEmpty, !ingredient.isEmpty {
                return "\(measure) \(ingredient)"
            }
            return nil
        }
    }
}
