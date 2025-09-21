//
//  AnimalsCategory.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation

struct AnimalsCategory: Codable, Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let image: URL?
    let order: Int
    let status: CategoryStatus
    let content: [AnimalFactDescription]?
    
    var effectiveStatus: CategoryStatus {
        if content == nil || content?.isEmpty == true {
            return .comingSoon
        } else {
            return status
        }
    }

    private enum CodingKeys: String, CodingKey {
        case title, description, image, order, status, content
    }
}

enum CategoryStatus: String, Codable, Equatable {
    case free
    case paid
    case comingSoon = "coming_soon"
}

struct AnimalFactDescription: Equatable, Codable, Identifiable {
    var id = UUID()
    let fact: String
    let image: URL?
    
    private enum CodingKeys: String, CodingKey {
        case fact, image
    }
}
