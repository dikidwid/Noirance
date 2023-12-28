//
//  MainView.swift
//  Noirance
//
//  Created by Diki Dwi Diro on 11/01/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $viewModel.currentTab) {
                HomeView()
                    .tag(Tab.Home)
                
                AddTransactionView()
                    .tag(Tab.AddNewTransaction)
                
                ProfileView()
                    .tag(Tab.Profile)
            }
            
            customTabBar()
                .offset(y: viewModel.isIdle ? 150 : 0)
                .onAppear {
                    viewModel.hiddenDefaultTabBar()
                }
        }
        .onAppear {
            viewModel.resetIdleTimer()
        }
        .onTapGesture {
            viewModel.resetIdleTimer()
        }
        .onReceive(viewModel.idleTimer) { _ in
            viewModel.checkIdleTime()
        }
    }
    
    @ViewBuilder
    private func customTabBar() -> some View {
        HStack {
            Button {
                viewModel.currentTab = .Home
            } label: {
                VStack {
                    Image(systemName: "house.fill")
                        .scaleEffect(1.25)
                        .tint(viewModel.currentTab == .Home ? .customBlack : .gray.opacity(0.5))
                    
                    Text("Home")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(viewModel.currentTab == .Home ? .customBlack : .gray.opacity(0.5))
                        .padding(.top, 5)
                }
                .padding()
            }
            
            Spacer().frame(width: 10)
            
            Button {
                viewModel.currentTab = .AddNewTransaction
            } label: {
                VStack {
                    Image(systemName: "plus")
                        .scaleEffect(1.25)
                        .padding()
                        .tint(.customWhite)
                        .background {
                            Circle()
                                .fill(.customBlack)
                                .shadow(radius: 5)
                        }
                        .offset(y: -40)
                        .padding(.bottom, -50)
                    
                    Text("Add\nTransaction")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(viewModel.currentTab == .AddNewTransaction ? .customBlack : .gray.opacity(0.5))
                        .padding(.top, 5)
                }
            }
            
            Spacer().frame(width: 10)
            
            Button {
                viewModel.currentTab = .Profile
            } label: {
                VStack {
                    Image(systemName: "person.fill")
                        .scaleEffect(1.25)
                        .tint(viewModel.currentTab == .Profile ? .customBlack : .gray.opacity(0.5))
                    
                    Text("Profile")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(viewModel.currentTab == .Profile ? .customBlack : .gray.opacity(0.5))
                        .padding(.top, 5)
                }
                .padding()
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Material.ultraThin.quinary)
                .shadow(color: .customBlack.opacity(5), radius: 4, x: 5, y: 5)
        }
        .padding(.horizontal, 35)
        .animation(.interpolatingSpring, value: viewModel.isIdle)
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.light)
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
