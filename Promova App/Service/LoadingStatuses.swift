//
//  LoadingStatuses.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation

enum LoadingStatus: Equatable {
    case start
    case loading
    case success
    case error(String)
}
