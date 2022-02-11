//
//  AccountView.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        VStack {
            NavigationHeader(title: "Hello, \(viewModel.firstName)", onDismiss: viewModel.dismiss)
            
            VStack {
                userInfo
                
                button("Account Info") {
                    viewModel.accountInfoTapped()
                }
                
                button("My Orders") {
                    viewModel.goToMyOrders?()
                }
                
                button("Language") {
                    viewModel.goToLanguages?()
                }
                
                button("Help") {
                    viewModel.helpTapped()
                }
                
                nightModeSwitch
                
                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .navigationBarHidden(true)
    }
}

private extension AccountView {
    
    var userInfo: some View {
        VStack {
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(size: 100)
                .clipShape(Circle())
                .padding(.vertical, 20)
            
            line
        }
    }
    
    var line: some View {
        Rectangle()
            .fill(.black)
            .frame(height: 2)
    }
    
    func button(_ text: String, onTapped: EmptyCallback? = nil) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.playfair(24, .bold))
                .padding(.top, 15)
                .padding(.bottom, 10)
            
            line
        }
        .onTapGesture {
            onTapped?()
        }
    }
    
    var nightModeSwitch: some View {
        HStack {
            Text("Light")
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.toggleDarkMode(darkMode: false)
                }
            
            Spacer()
            
            Image("icon_lightMode")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    viewModel.toggleDarkMode()
                }
            
            Spacer()
            
            Text("Dark")
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.toggleDarkMode(darkMode: true)
                }
        }
        .font(.playfair(24, .bold))
        .frame(height: 50)
        .padding(.vertical, 50)
        .contentShape(Rectangle())
        .onSwipe(.left) {
            viewModel.toggleDarkMode(darkMode: false)
        }
        .onSwipe(.right) {
            viewModel.toggleDarkMode(darkMode: true)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(user: .sample))
    }
}
