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
            NavigationHeader(title: "Hello, \(viewModel.firstName)", onDismiss: { [weak viewModel] in
                viewModel?.dismiss()
            })
            
            VStack {
                userInfo
                
                button("Account Info") { [weak viewModel] in
                    viewModel?.accountInfoTapped()
                }
                
                button("My Orders") { [weak viewModel] in
                    viewModel?.goToMyOrders?()
                }
                
                button("Language") { [weak viewModel] in
                    viewModel?.goToLanguages?()
                }
                
                button("Help") { [weak viewModel] in
                    viewModel?.helpTapped()
                }
                
                nightModeSwitch
                
                Spacer()
            }
            .padding(.horizontal, 40)
        }
        .background(Color.background)
        .foregroundColor(Color.text)
        .navigationBarHidden(true)
    }
}

private extension AccountView {
    
    var userInfo: some View {
        VStack {
            AsyncImage(url: viewModel.user.avatarURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(size: 100)
            } placeholder: {
                Image(.icon_avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 100)
            }
            .clipShape(Circle())
            .contentShape(Circle())
            .padding(.vertical, 20)
            
            line
        }
    }
    
    var line: some View {
        Rectangle()
            .fill(Color.text)
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
                .onTapGesture { [weak viewModel] in
                    viewModel?.setColorScheme(.light)
                }
            
            Spacer()
            
            Image(.icon_lightMode)
                .resizable()
                .scaledToFit()
                .onTapGesture { [weak viewModel] in
                    viewModel?.toggleColorScheme()
                }
            
            Spacer()
            
            Text("Dark")
                .contentShape(Rectangle())
                .onTapGesture { [weak viewModel] in
                    viewModel?.setColorScheme(.dark)
                }
        }
        .font(.playfair(24, .bold))
        .frame(height: 50)
        .padding(.vertical, 50)
        .contentShape(Rectangle())
        .onSwipe(.left) { [weak viewModel] in
            viewModel?.setColorScheme(.light)
        }
        .onSwipe(.right) { [weak viewModel] in
            viewModel?.setColorScheme(.dark)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(user: .sample))
    }
}
