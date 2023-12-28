//
//  Wallet.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 28/12/23.
//

import Foundation


struct Wallet: Identifiable {
    let id = UUID()
    let name: String
    let balance: Double
    let image: String
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let totalBudget: Double
    let totalUsed: Double
}

struct Expense: Identifiable {
    let id = UUID()
    let name: String
    let wallet: String
    let amount: Double
    let date: Date
    let category: String
}

struct Revenue: Identifiable {
    let id = UUID()
    let name: String
    let wallet: String
    let amount: Double
    let date: Date
}
