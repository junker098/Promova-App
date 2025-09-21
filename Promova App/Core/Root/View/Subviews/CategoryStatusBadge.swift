//
//  CategoryStatusBadge.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import Foundation
import SwiftUI


private struct CategoryStatusDisplay {
    let text: LocalizedStringKey
    let systemIcon: String
    let tint: Color
}

private extension CategoryStatus {
    var display: CategoryStatusDisplay {
        switch self {
        case .free:
                .init(text: "Free",
                      systemIcon: "checkmark.seal",
                      tint: .green)
        case .paid:
                .init(text: "Premium",
                      systemIcon: "lock",
                      tint: .blue)
        case .comingSoon:
                .init(text: "Coming soon",
                      systemIcon: "clock",
                      tint: .clear)
        }
    }
}

struct CategoryStatusBadge: View {
    
    let status: CategoryStatus
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: status.display.systemIcon)
                .frame(width: 10, height: 10)
            Text(status.display.text)
                .font(.caption)
        }
        .foregroundStyle(status.display.tint)
    }
}
