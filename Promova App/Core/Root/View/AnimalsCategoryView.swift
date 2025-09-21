//
//  AnimalsCategoryView.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct AnimalsCategoryView: View {
    
    @ComposableArchitecture.Bindable var store: StoreOf<AnimalsCategoryListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack {
                ZStack {
                    LinearGradient.appBackground.ignoresSafeArea()
                    content
                    if store.isShowingAdLoader {
                        Color.black.opacity(0.2).ignoresSafeArea()
                        ProgressView("Loading…")
                            .padding(16)
                    }
                }
                .navigationDestination(item: $store.selectedCategory) { animal in
                    AnimalFactsView(
                        store: StoreOf<AnimalFactsFeature>(
                            initialState: AnimalFactsFeature.State(
                                categoryTitle: animal.title,
                                facts: animal.content ?? []
                            ),
                            reducer: { AnimalFactsFeature() }
                        )
                    )
                }
                .navigationTitle("Categories")
            }
            .onAppear { store.send(.onAppear) }
            .alert($store.scope(state: \.alert, action: \.alert))
        }
        
    }
    
    @ViewBuilder
    private var content: some View {
        switch store.loadingStatus {
        case .start, .loading:
            ProgressView().controlSize(.large)
        case .error(let message):
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                Text(message)
                Button("Retry") { store.send(.loadAnimalsList) }
            }
            .padding()
        case .success:
            List(store.animals) { animal in
                CategoryRowView(animal: animal) {
                    store.send(.tappedCategory(animal))
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
        }
    }
}
