//
//  ContentView.swift
//  What to Cook
//
//  Created by Corey Ruhno on 3/15/24.
//

import SwiftUI
import Combine

final class NetworkManager {
    func getRecipes() async throws -> [Recipe] {
        MockData.mockRecipes
    }
}


final class WhatToCookViewModel: ObservableObject {
    @Published private(set) var allRecipes: [Recipe] = []
    @Published private(set) var filteredRecipes: [Recipe] = []
    @Published var searchText: String = ""
    let manager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.75, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterRecipes(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    private func filterRecipes(searchText: String) {
        guard !searchText.isEmpty else {
            filteredRecipes = []
            return
        }
        
        let search = searchText.lowercased()
        filteredRecipes = allRecipes.filter({ recipe in
            let titleContainsSearch = recipe.title.lowercased().contains(search)
            return titleContainsSearch
        })
    }
    
    func loadRecipes() async {
        do {
            allRecipes = try await manager.getRecipes()
        } catch {
            print(error)
        }
    }
}

struct WhatToCookView: View {
    @StateObject private var viewModel = WhatToCookViewModel()
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.allRecipes) { recipe in
                        displayRecipeRow(recipe: recipe)
                    }
                }
                .padding()
            }
            .searchable(text: $viewModel.searchText, placement: .automatic, prompt: Text("Search recipes..."))
            //        .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Recipes")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }
    
    private func displayRecipeRow(recipe: Recipe) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(recipe.title)
                .fontWeight(.bold)
//            ForEach(recipe.ingrients) { ingredient in
//                Text(ingredient.title)
//            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
        .cornerRadius(8)
    }
}

#Preview {
    WhatToCookView()
}
