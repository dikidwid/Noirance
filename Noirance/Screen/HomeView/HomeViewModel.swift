//
//  HomeViewModel.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 11/01/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    let wallets: [Wallet]   = [ Wallet(name: "Jago", balance: 550_000, image: ""),
                                Wallet(name: "BCA", balance: 2_000_000, image: ""),
                                Wallet(name: "Cash", balance: 650_000, image: "")
    ]
    
    let expenses: [Expense] = [ Expense(name: "Lunch", wallet: "Jago", amount: 15_000, date: Date(), category: "Food"),
                                Expense(name: "Dinner", wallet: "BCA", amount: 10_000, date: Date(), category: "Food"),
                                Expense(name: "Laundry", wallet: "Jago", amount: 5_000, date: Date(), category: "Utilities")
    ]
    
    let categories: [Category]  = [ Category(name: "Food", icon: "fork.knife", totalBudget: 600_000, totalUsed: 330_000),
                                    Category(name: "Transport", icon: "car", totalBudget: 300_000, totalUsed: 70_000),
                                    Category(name: "Utilities", icon: "tag", totalBudget: 100_000, totalUsed: 20_000),
                                    Category(name: "Shopping", icon: "cart", totalBudget: 200_000, totalUsed: 170_000)
    ]
    
    var walletName: [String] {
        wallets.map { wallet in
            return wallet.name
        }
    }
    
    //Calendar Properties
    private let currentDate = Date()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "E, d MMM"
        return formatter
    }()
    var formattedDate: String {
        dateFormatter.string(from: currentDate)
    }
    
    //Timer Properties
    let slideTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    @Published var walletIndex = 0
    
    let totalBalance: Double = 2_000_000
    
    let showTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()    
    @Published var isWalletCardAppear = false
    
    @Published var isScreenAppear = false
    
    func checkCurrentWalletIndex() {
        walletIndex = walletIndex < wallets.count ? walletIndex + 1 : 0
    }
    
    func configurePageIndicatorAppearance() {
            UIPageControl.appearance().currentPageIndicatorTintColor = .customBlack
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.customBlack.withAlphaComponent(0.2)
    }
    
    func calculatePercentageUsedBudget(of category: Category) -> Double {
        return ((Double(category.totalUsed) / Double(category.totalBudget)) * 100)
    }
    
    func updateCircularProgressBar(of category: Category) -> Double {
        let percentageUsed = (Double(category.totalUsed) / Double(category.totalBudget))
        return min(max(percentageUsed, 0.0), 1.0)
    }
}
