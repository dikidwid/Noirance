//
//  AddTransactionView.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 11/01/24.
//

import SwiftUI

struct AddTransactionView: View {

    @StateObject var viewModel = AddTransactionViewModel()
    
    var body: some View {
        ZStack {
//            Image("walletCard")
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Material.ultraThin)
                .overlay {
                    VStack {
                        VStack {
                            Text("Please fill the details")
                                .font(.system(size: 18, weight: .heavy))
                            .padding(.bottom, 0.25)
                            
                            Text("Drop all your transaction details here!")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.customBlack.opacity(0.5))
                        }
                        
                        VStack {
                            Text("Type of Transaction")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                
                            
                            Picker("", selection: $viewModel.selectedTransactionType) {
                                ForEach(viewModel.transactions, id: \.self) { transaction in
                                    Text(transaction)
                                }
                            }
                            .pickerStyle(.palette)
                        }
                        .padding(.vertical)
                        
                        DatePicker(selection: $viewModel.date, displayedComponents: .date) {
                            Label("Date", systemImage: "calendar")
                                .font(.system(size: 15, weight: .medium))
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Label("Wallet", systemImage: "creditcard")
                                .font(.system(size: 15, weight: .medium))
                            
                            Spacer()
                            
                            Picker("", selection: $viewModel.selectedWallet) {
                                ForEach(viewModel.wallets, id: \.self) { wallet in
                                    Text(wallet)
                                }
                            }
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Label("Category", systemImage: "tag")
                                .font(.system(size: 15, weight: .medium))
                            
                            Spacer()
                            
                            Picker("Select an option", selection: $viewModel.selectedCategory) {
                                ForEach(viewModel.categories, id: \.self) { categories in
                                    Text(categories)
                                    
                                }
                            }
                        }
                        .padding(.bottom)
                        
                        
                        VStack {
                            Text("Total Amount")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top)
                            
                            TextField("Rp. 0", value: $viewModel.totalAmount, formatter: viewModel.numberFormatter)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(.plain)
                                .keyboardType(.numberPad)
                        }
                    }
                    .tint(.customBlack)
                    .padding(.all, 25)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(width: 300, height: 450)
        }
    }
}

#Preview {
    AddTransactionView()
}
