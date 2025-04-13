//
//  PantryPalApp.swift
//  PantryPal
//
//  Created by Jason Jiang on 3/11/25.
//

import SwiftUI
import ParseSwift

@main
struct PantryPalApp: App {
    @StateObject var mealDBService = MealDBService()
    @AppStorage("isDarkMode") private var isDarkMode = false{
        didSet{
            print("dark mode is \(isDarkMode)")}
    }
    init() {
        ParseSwift.initialize(applicationId: "nhJFy7RKNyvOXLY5FpuF0E9kpQJ614SQLkD0IQqq",
                              clientKey: "4zdYq91YAFCvM6ZDz1e49bVHDpSvHrNuqv0jbtG4",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)
        
        UIView.appearance().overrideUserInterfaceStyle = .light
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mealDBService)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
