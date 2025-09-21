//
//  AnimalFactsView.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import SwiftUI
import ComposableArchitecture

struct AnimalFactsView: View {
    
    @ComposableArchitecture.Bindable var store: StoreOf<AnimalFactsFeature>
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 16, height: 16)
                            .tint(.black)
                    }
                    Spacer()
                    Text(store.categoryTitle)
                        .font(.headline)
                    Spacer()
                }
                .padding()
                VStack {
                    TabView(selection: $store.index) {
                        ForEach(Array(store.facts.enumerated()), id: \.offset) { idx, fact in
                            FactCardView(fact: fact)
                                .tag(idx)
                                .padding(.horizontal, 20)
                                .padding(.top, 14)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    //Bottom buttons
                    HStack {
                        ArrowButton(direction: .left, isEnabled: store.canGoPrev) {
                            store.send(.prevTapped)
                        }
                        Spacer()
                        ArrowButton(direction: .right, isEnabled: store.canGoNext) {
                            store.send(.nextTapped)
                        }
                    }
                    .padding(.horizontal, 32)
                }
                Spacer()
                
            }
            .background(
                LinearGradient.appBackground.ignoresSafeArea()
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}


private struct ArrowButton: View {
    
    enum ArrowDirection {
        case left, right
        var image: String {
            switch self {
            case .left: "chevron.left"
            case .right: "chevron.right"
            }
        }
    }
    
    let direction: ArrowDirection
    let isEnabled: Bool
    let action: () -> Void
    var size: CGFloat = 44
    var tint: Color = .black
    
    var body: some View {
        Button(action: action) {
            Image(systemName: direction.image)
        }
        .frame(width: size, height: size)
        .overlay(Circle().strokeBorder())
        .tint(tint)
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.4)
    }
}
