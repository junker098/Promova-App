//
//  AnimalsCategoryAlerts.swift
//  Promova App
//
//  Created by Yuriy on 22.09.2025.
//

import Foundation
import ComposableArchitecture

private enum AlertsConstant {
    static let errorTitle = TextState("Error")
    static let ok = TextState("OK")
    static let cancel = TextState("Cancel")
    static let showAd = TextState("Show Ad")
    static let comingSoonTitle = TextState("Coming soon")
    static let comingSoonMessage = TextState("This category will be available later.")
    static func premiumTitle(_ title: String) -> TextState {
        TextState("“\(title)” is premium. Watch a short ad to unlock.")
    }
    static let watchAdToContinue = TextState("Watch Ad to continue")
}

enum AlertAction: Equatable {
    case showAdTapped(AnimalsCategory)
    case cancelTapped
    case okTapped
}

extension AlertState where Action == AlertAction {
    
    static func ok(_ title: TextState, message: TextState? = nil) -> Self {
        AlertState {
            title
        } actions: {
            ButtonState(action: .send(.okTapped)) { AlertsConstant.ok }
        } message: {
            message ?? AlertsConstant.ok
        }
    }
    
    static func error(_ message: String) -> Self {
        .ok(AlertsConstant.errorTitle, message: TextState(message))
    }
    
    static func premium(for animal: AnimalsCategory) -> Self {
        AlertState {
            AlertsConstant.watchAdToContinue
        } actions: {
            ButtonState(role: .cancel, action: .send(.cancelTapped)) {
                AlertsConstant.cancel
            }
            ButtonState(action: .send(.showAdTapped(animal))) {
                AlertsConstant.showAd
            }
        } message: {
            AlertsConstant.premiumTitle(animal.title)
        }
    }
    
    static func comingSoon() -> Self {
        .ok(AlertsConstant.comingSoonTitle, message: AlertsConstant.comingSoonMessage)
    }
}
