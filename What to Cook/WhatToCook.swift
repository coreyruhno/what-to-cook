//
//  ContentView.swift
//  What to Cook
//
//  Created by Corey Ruhno on 3/15/24.
//

import SwiftUI

final class NetworkManager {
    func getRecipes() async throws -> [Recipe] {
        MockData.mockRecipes
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
