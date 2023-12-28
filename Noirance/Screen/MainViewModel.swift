//
//  MainViewModel.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 12/01/24.
//

import SwiftUI

enum Tab: CaseIterable {
    case Home, AddNewTransaction, Profile
}

final class MainViewModel: ObservableObject {
    var idleTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var lastInteractionTime = Date()
    @Published var isIdle = false
    
    @Published var currentTab: Tab = .Home
    @Published var showTab = false
    
    func hiddenDefaultTabBar() {
        UITabBar.appearance().isHidden = true
    }
    func resetIdleTimer() {
        lastInteractionTime = Date()
        isIdle = false
    }
    
    func checkIdleTime() {
        let idleThreshold: TimeInterval = 5.0 // Set your desired idle time threshold in seconds
        
        let elapsedTime = Date().timeIntervalSince(lastInteractionTime)
        
        if elapsedTime >= idleThreshold && !isIdle {
            // Screen is considered idle
            print("Screen is idle")
            isIdle = true
            // Perform any actions you need when the screen is idle
        }
    }
}
