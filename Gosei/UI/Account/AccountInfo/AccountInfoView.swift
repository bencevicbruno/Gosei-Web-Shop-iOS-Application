//
//  AccountInfoView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct AccountInfoView: View {
    
    @ObservedObject var viewModel: AccountInfoViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(title: "Account Info") {
                viewModel.dismiss()
            }
            
            ScrollView(.vertical) {
                changePictureSection
                
                separator
                
                changeInfoSection
                
                separator
                
                changePasswordSection
            }
            
            .padding(.horizontal, 45)
        }
        .foregroundColor(Color.text)
        .background(Color.background)
        .navigationBarHidden(true)
    }
}

private extension AccountInfoView {
    
    var changePictureSection: some View {
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
            
            HStack {
                Text("Change picture")
                    .font(.workSans(14))
                
                Image(.icon_camera)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 20)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.changePictureTapped()
                    }
            }
        }
        .padding(.vertical, 20)
    }
    
    var separator: some View {
        Rectangle()
            .frame(height: 2)
    }
    
    func sectionHeader(_ title: String, onTapped: EmptyCallback? = nil) -> some View {
        HStack {
            Text(title)
                .font(.playfair(24, .bold))
            
            Spacer()
            
            Image(.icon_edit)
                .resizable()
                .scaledToFit()
                .frame(size: 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    onTapped?()
                }
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
    }
    
    func infoRow(_ info: String, value: String) -> some View {
        HStack(spacing: 0) {
            Text(info)
                .font(.playfair(16, .bold))
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 40)
            
            Text(value)
                .font(.workSans(14))
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 10)
    }
    
    var changeInfoSection: some View {
        VStack {
            sectionHeader("Change Info") {
                viewModel.changeInfoTapped()
            }
            
            infoRow("Name", value: viewModel.user.name)
            
            infoRow("Email", value: viewModel.user.email)
            
            infoRow("Address", value: viewModel.user.address ?? "Unknown")
            
            infoRow("Phone Number", value: viewModel.user.phoneNumber ?? "Unknown")
            
            infoRow("Date or Birth", value: viewModel.user.birthday?.asString ?? "Unknown")
        }
    }
    
    var changePasswordSection: some View {
        VStack {
            sectionHeader("Change Password") {
                viewModel.changePasswordTapped()
            }
            
            infoRow("Password", value: "********")
        }
    }
}

struct AccountInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AccountInfoView(viewModel: AccountInfoViewModel(user: .sample))
    }
}
