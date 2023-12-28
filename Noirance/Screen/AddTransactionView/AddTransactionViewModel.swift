//
//  AddTransactionViewModel.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 12/01/24.
//

import Foundation

final class AddTransactionViewModel: ObservableObject {
    
    let walletsss: [Wallet]   = [ Wallet(name: "Jago", balance: 550_000, image: ""),
                                Wallet(name: "BCA", balance: 2_000_000, image: ""),
                                Wallet(name: "Cash", balance: 650_000, image: "")
    ]
    let categoriesss: [Category]  = [ Category(name: "Food", icon: "fork.knife", totalBudget: 600_000, totalUsed: 330_000),
                                    Category(name: "Transport", icon: "car", totalBudget: 300_000, totalUsed: 70_000),
                                    Category(name: "Utilities", icon: "tag", totalBudget: 100_000, totalUsed: 20_000),
                                    Category(name: "Shopping", icon: "cart", totalBudget: 200_000, totalUsed: 170_000)
    ]
    
    @Published var date = Date()
    @Published var totalAmount: Decimal = 0.0
    
    @Published var selectedTransactionType = "Expense"
    @Published var selectedWallet = "Jago"
    @Published var selectedCategory = "Food"
    
    let transactions = ["Expense", "Revenue"]
    
    var wallets: [String] {
        walletsss.map { $0.name }
    }
    
    var categories: [String] {
        categoriesss.map{ $0.name }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()

}
