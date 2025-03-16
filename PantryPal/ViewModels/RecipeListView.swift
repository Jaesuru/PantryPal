//
//  RecipeListView.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/15/25.
//

import SwiftUI

struct RecipeListView: View {
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a Recipe!", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
    }}

#Preview {
    RecipeListView()
}
