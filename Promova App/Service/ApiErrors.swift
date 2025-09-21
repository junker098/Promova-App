//
//  ApiErrors.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation

enum ApiError: Error, Equatable {
    case requestError(String)
    case invalidUrl(String)
}
