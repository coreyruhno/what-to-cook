//
//  ContentView.swift
//  What to Cook
//
//  Created by Corey Ruhno on 3/15/24.
//

import SwiftUI

struct ingredient: Identifiable, Hashable {
    let id: String
    let title: String
    let aisle: Aisle
}

struct recipe: Identifiable, Hashable {
    let id: String
    let title: String
    let ingrients: [ingredient]
}

enum Aisle {
    case dairy, spices, baking, produce, meat
}

final class NetworkManager {
    func getRecipes() async throws -> [recipe] {
        [
            recipe(id: "1", title: "Spaghetti", ingrients: [ingredient(id: "1", title: "Pasta", aisle: .baking)])
        ]
    }
}

final class WhatToCookViewModel: ObservableObject {
    
}

struct WhatToCook: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    WhatToCook()
}
