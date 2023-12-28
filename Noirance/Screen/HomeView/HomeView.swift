//
//  HomeView.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 28/12/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.formattedDate)
                            .font(.system(.subheadline, weight: .regular))
                        
                        Text("Hi, Diki!")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    ProfilePicture(imageName: "userProfile", backgroundColor: .secondary.opacity(0.25))
                        .padding(.horizontal)
                    
                }
                .padding(.top)
                .padding(.bottom, 60)
                            
                Text("Total Balance:")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 1)

                Text("Rp. \(viewModel.totalBalance, specifier: "%.f")")
                    .font(.system(size: 28, weight: .heavy))
                
                TabView(selection: $viewModel.walletIndex) {
                    ForEach(viewModel.wallets.indices, id: \.self) { index in
                        WalletCard(wallet: viewModel.wallets[index])
                    }
                }
                .onAppear {
                    viewModel.configurePageIndicatorAppearance()
                }
                .onReceive(viewModel.slideTimer) { _ in
                    withAnimation {
                        viewModel.checkCurrentWalletIndex()
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 385)
                .offset(y: -30)
                .padding(.bottom, -30)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Spending Budget")
                            .font(.system(size: 18, weight: .semibold))
                        .padding(.bottom, 0.25)
                        
                        Text("Keep an eye on your available budget.")
                            .font(.system(size: 11.5, weight: .regular))
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Edit")
                            .font(.system(size: 15, weight: .semibold))
                    }
                    .buttonStyle(.bordered)
                    .tint(.customBlack)
                }
                .padding()
                
                ForEach(viewModel.categories) { category in
                   ExpenseBudget(category: category)
                        .padding(.vertical)
                }
                
                Divider()
                    .padding()
                    
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Recent Transactions")
                            .font(.system(size: 18, weight: .semibold))
                        .padding(.bottom, 0.25)
                        
                        Text("View your latest financial activity history.")
                            .font(.system(size: 11.5, weight: .regular))
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("View All")
                            .font(.system(size: 15))
                    }
                    .buttonStyle(.plain)
                    .underline()
                }
                .padding()
                
                ForEach(viewModel.expenses) { expense in
                    ExpenseList(expense: expense)
                        .padding(.bottom, 7.5)
                }
//                .padding(.horizontal)
                
            }
            .padding(.horizontal)
        }
        .background {
            Color.customWhite.ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func ProfilePicture(imageName: String, backgroundColor: Color) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(backgroundColor))
            }
    }
    
    @ViewBuilder
    private func WalletCard(wallet: Wallet) -> some View {
        let animationTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        Image("walletCard")
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .overlay {
                VStack(alignment: .leading) {
                    Label {
                        Text(wallet.name)
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "creditcard")
                    }
                    .foregroundStyle(.customWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top], 30)
                    
                    Spacer()
                    
                    Text("Balance")
                        .font(.caption2)
                    
                    Text("Rp. \(wallet.balance, specifier: "%.f")")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                    
                    Text("Diki Dwi Diro")
                        .font(.caption)
                        .padding(.bottom, 30)
                }
                .foregroundStyle(.customWhite)
                .padding(.leading, 30)
            }
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.customBlack.opacity(0.20))
                    .rotationEffect(.degrees(viewModel.isWalletCardAppear ? -12 : 0))
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.customBlack.opacity(0.10))
                    .rotationEffect(.degrees(viewModel.isWalletCardAppear ? -24 : 0))
            }
            .onReceive(animationTimer) { _ in
                withAnimation {
                    viewModel.isWalletCardAppear = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        viewModel.isWalletCardAppear = false
                    }
                }
            }
            .animation(.spring(), value: viewModel.isWalletCardAppear)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private func ExpenseBudget(category: Category) -> some View {
        let circularProgressBar = viewModel.updateCircularProgressBar(of: category)
        let persentageUsedBudget = viewModel.calculatePercentageUsedBudget(of: category)
        
        HStack {
            Image(systemName: category.icon)
                .imageScale(.large)
                .foregroundStyle(.customBlack)
                .overlay {
                    ZStack {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .fill(.secondary.opacity(0.5))
                            .frame(width: 50, height: 50)
                        
                        Circle()
                            .trim(from: 0.0, to: viewModel.isScreenAppear ? circularProgressBar : 0.0)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .rotationEffect(Angle(degrees: 270))
                            .frame(width: 50, height: 50)
                    }

                }
                .frame(width: 50, height: 50)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.system(size: 15, weight: .regular))
                    .padding(.bottom, 1)
                
                Text("\(persentageUsedBudget, specifier: "%.0f")% used")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Remaining")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 1)
                
                Text("Rp. \(category.totalBudget - category.totalUsed, specifier: "%.f")")
                    .font(.system(size: 13, weight: .semibold))
            }
        }
        .onAppear {
            viewModel.isScreenAppear = true
        }
        .animation(.interpolatingSpring(duration: 3), value: viewModel.isScreenAppear)
        .padding(.horizontal)
        
    }
    
    @ViewBuilder
    private func ExpenseList(expense: Expense) -> some View {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM | HH:mm"
            return formatter
        }()
        var formattedDate: String {
            dateFormatter.string(from: expense.date)
        }
        
        HStack{
            HStack {
                Image("expense")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                    .padding(.all, 7.5)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.customWhite)
                        //                            .padding()
                        //                            .shadow(radius: 5)
                    }
                
                VStack(alignment: .leading) {
                    Text(expense.name)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.bottom, 2)
                    
                    Text(expense.category)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            VStack {
                Text("- Rp. \(expense.amount, specifier: "%.2f")")
                    .font(.system(size: 15, weight: .bold))
                    .padding(.bottom, 2)
                
                Text(formattedDate)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Material.ultraThin)
                .fill(.secondary.opacity(0.2))
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.light)
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
