//
//  AnimalFactsFeature.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalFactsFeature {
    @ObservableState
    struct State: Equatable {
        let categoryTitle: String
        let facts: [AnimalFactDescription]
        
        var index: Int = 0
        
        var canGoPrev: Bool { index > 0 }
        var canGoNext: Bool { index + 1 < facts.count }
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case nextTapped
        case prevTapped
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .nextTapped:
                if state.canGoNext { state.index += 1 }
                return .none
                
            case .prevTapped:
                if state.canGoPrev { state.index -= 1 }
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}
