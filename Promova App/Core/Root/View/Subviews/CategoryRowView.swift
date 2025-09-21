//
//  CategoryRowView.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import SwiftUI

struct CategoryRowView: View {
    
    let animal: AnimalsCategory
    let tap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: animal.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 121, maxHeight: 90)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 121, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(animal.title)
                    .font(.title3)
                Text(animal.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                CategoryStatusBadge(status: animal.effectiveStatus)
            }
            Spacer()
        }
        .padding(10)
        
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(radius: 1, y: 1)
        )
        .overlay(
            ComingSoonOverlay(active: animal.effectiveStatus == .comingSoon)
        )
        .contentShape(Rectangle())
        .onTapGesture(perform: tap)
    }
}

private struct ComingSoonOverlay: View {
    
    let active: Bool

    var body: some View {
        if active {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.black.opacity(0.45))

                Image("comingSoon")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(-45))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .opacity(0.9)
            }
        }
    }
}
