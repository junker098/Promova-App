//
//  AnimalsCategoryListFeature.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalsCategoryListFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var animals: [AnimalsCategory] = []
        var loadingStatus: LoadingStatus = .start
        var isShowingAdLoader: Bool = false
        var selectedCategory: AnimalsCategory?
        
        @Presents var alert: AlertState<AlertAction>?
    }
    
    enum Action: Equatable, BindableAction {
        case onAppear
        case loadAnimalsList
        case loadAnimalsResponse(Result<[AnimalsCategory], ApiError>)
        case binding(BindingAction<State>)
        case tappedCategory(AnimalsCategory)
        
        case alert(PresentationAction<AlertAction>)
        case startAdFlow(AnimalsCategory)
        case adFinished(AnimalsCategory)
    }
    
    @Dependency(\.networkService) var networkService
    @Dependency(\.continuousClock) var clock
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear, .loadAnimalsList:
                return .run { send in
                    let result = try await networkService.getAllAnimalsList()
                    await send(.loadAnimalsResponse(result))
                }
                
            case let .loadAnimalsResponse(.success(items)):
                state.loadingStatus = .success
                state.animals = items.sorted { $0.order < $1.order }
                return .none
                
            case let .loadAnimalsResponse(.failure(error)):
                state.loadingStatus = .error(error.localizedDescription)
                state.alert = .error(error.localizedDescription)
                return .none
                
            case let .tappedCategory(animal):
                switch animal.effectiveStatus {
                case .free:
                    state.selectedCategory = animal
                case .paid:
                    state.alert = .premium(for: animal)
                case .comingSoon:
                    state.alert = .comingSoon()
                }
                return .none
                
            case .alert(.presented(.okTapped)),
                    .alert(.presented(.cancelTapped)):
                return .none
                
            case let .alert(.presented(.showAdTapped(animal))):
                return .send(.startAdFlow(animal))
                
            case let .startAdFlow(animal):
                state.isShowingAdLoader = true
                return .run { send in
                    try await clock.sleep(for: .seconds(2))
                    await send(.adFinished(animal))
                }
                
            case let .adFinished(animal):
                state.isShowingAdLoader = false
                state.selectedCategory = animal
                return .none
                
            case .alert(.dismiss):
                return .none
                
            case .binding:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert) {}
    }
}
