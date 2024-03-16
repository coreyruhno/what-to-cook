//
//  SearchableBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Nick Sarno on 5/20/23.
//

import SwiftUI
import Combine

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

enum CuisineOption: String {
    case american, italian, japanese
}

final class RestaurantManager {
    
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
            Restaurant(id: "4", title: "Local Market", cuisine: .american),
        ]
    }
}

@MainActor
final class SearchableViewModel: ObservableObject {
    
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    
    let manager = RestaurantManager()
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurants()
        } catch {
            print(error)
        }
    }
}

struct SearchableBootcamp: View {
    
    @StateObject private var viewModel = SearchableViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.allRestaurants) { restaurant in
                
                        restaurantRow(restaurant: restaurant)
                }
            }
            .padding()
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: Text("Search restaurants..."))
//        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Restauran4ts")
        .task {
            await viewModel.loadRestaurants()
        }
    }
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.title)
                .font(.headline)
                .foregroundColor(.red)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
        .tint(.primary)
    }
}

struct SearchChildView: View {
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        Text("Child View is searching: \(isSearching.description)")
    }
}

struct SearchableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchableBootcamp()
        }
    }
}
