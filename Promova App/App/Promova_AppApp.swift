//
//  Promova_AppApp.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct Promova_AppApp: App {
    
    static let animalsStore = Store(initialState: AnimalsCategoryListFeature.State()) {
        AnimalsCategoryListFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AnimalsCategoryView(store: Promova_AppApp.animalsStore)
        }
    }
}
