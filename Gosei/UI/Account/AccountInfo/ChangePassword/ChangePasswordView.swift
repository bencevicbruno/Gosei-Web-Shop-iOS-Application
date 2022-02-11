//
//  ChangePasswordView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct ChangePasswordView: View {
    
    @ObservedObject var viewModel: ChangePasswordViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(title: "Change Password", onDismiss: viewModel.dismiss)
            
            VStack(alignment: .leading, spacing: 0) {
                oldPasswordField
                
                newPasswordFields
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    saveButton
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 40)
        }
        .foregroundColor(Color.text)
        .background(Color.background)
        .navigationBarHidden(true)
    }
}

private extension ChangePasswordView{
    
    var oldPasswordField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Enter old Password")
                .font(.playfair(16, .bold))
                .padding(.bottom, 15)
            
            PasswordField($viewModel.oldPassword, hint: "Old Password", borderColor: viewModel.oldPasswordValid ? .black : .goseiRed)
            
            Text("Old password is incorrect")
                .font(.workSans(10))
                .foregroundColor(.goseiRed)
                .isHidden(viewModel.oldPasswordValid)
                .padding(.vertical, 3)
        }
    }
    
    var newPasswordFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Enter new Password")
                .font(.playfair(16, .bold))
                .padding(.bottom, 15)
            
            PasswordField($viewModel.newPassword, hint: "New Password", borderColor: viewModel.newPaswordMatching ? .black : .goseiRed)
            
            Text("Repeat new Password")
                .font(.playfair(16, .bold))
                .padding(.top, 10)
                .padding(.bottom, 15)
            
            PasswordField($viewModel.repeatedNewPassword, hint: "Repeat new Password", borderColor: viewModel.newPaswordMatching ? .black : .goseiRed)
            
            Text("Passwords don't match.")
                .font(.workSans(10))
                .foregroundColor(.goseiRed)
                .isHidden(viewModel.newPaswordMatching)
        }
    }
    
    var saveButton: some View {
        Text("SAVE")
            .font(.workSans(16, .medium))
            .foregroundColor(Color.background)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 4)
                            .fill(Color.text))
            .onTapGesture {
                viewModel.saveTapped()
            }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(viewModel: .init(user: .sample))
    }
}
