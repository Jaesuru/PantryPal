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
    @AppStorage("isDarkMode") private var isDarkMode = false
    init() {
        ParseSwift.initialize(applicationId: "nhJFy7RKNyvOXLY5FpuF0E9kpQJ614SQLkD0IQqq",
                              clientKey: "4zdYq91YAFCvM6ZDz1e49bVHDpSvHrNuqv0jbtG4",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)
        
        UIView.appearance().overrideUserInterfaceStyle = .light
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light) 
        }
    }
}
