//
//  NetworkService.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation
import ComposableArchitecture

struct NetworkService {
    var getAllAnimalsList: () async throws -> Result<[AnimalsCategory], ApiError>
}

extension NetworkService: DependencyKey {
    
    static var liveValue = NetworkService {
        guard let url = URL(string: PathList.baseUrl) else {
            return .failure(.invalidUrl("Invalid URL"))
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let animalsList = try JSONDecoder().decode([AnimalsCategory].self, from: data)
            return .success(animalsList)
        } catch {
            return .failure(.requestError(error.localizedDescription))
        }
    }
}

extension DependencyValues {
    var networkService: NetworkService{
        get { self[NetworkService.self] }
        set { self[NetworkService.self] = newValue }
    }
}
