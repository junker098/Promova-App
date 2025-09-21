//
//  FactCardView.swift
//  Promova App
//
//  Created by Yuriy on 21.09.2025.
//

import SwiftUI

struct FactCardView: View {
    
    let fact: AnimalFactDescription
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: fact.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(fact.fact)
                .multilineTextAlignment(.center)
                .font(.body)
                .padding(.top, 4)
                .padding(.horizontal)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.8), radius: 6, y: 2)
        )
    }
}
