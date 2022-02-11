//
//  SignupView.swift
//  Gosei
//
//  Created by Bruno Benčević on 29.11.2021..
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject var viewModel: SignupViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(.icon_arrowLeft)
                    .resizable()
                    .scaledToFit()
                    .frame(size: 30)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.dismiss()
                    }
                
                Spacer()
            }
            
            Spacer()
            
            Image(.gosei_logo)
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            
            Spacer()
            
            VStack(alignment: .leading) {
                InputField($viewModel.email, hint: Localizable.email.localized.capitalized)
                
                PasswordField($viewModel.password)
                
                PasswordField($viewModel.repeatedPassword, hint: Localizable.repeat_password.localized)
                
                passwordsNotMatchingLabel
            }
            
            signUpButton
                .padding(.vertical)
            
            TextSeparator(Localizable.or.localized.uppercased())
            
            HStack(spacing: 20) {
                externalLoginButton(.google, onTapped: viewModel.googleSingupTapped)
                
                externalLoginButton(.facebook, onTapped: viewModel.facebookSignupTapped)
                
                externalLoginButton(.apple, onTapped: viewModel.appleSignupTapped)
            }
            .padding(.bottom)
            
            Spacer()
        }
        .padding(.horizontal, 20).background(Color.background)
        .foregroundColor(Color.text)
        .sheet(item: $viewModel.externalSignupSheet) { type in
            externalSignupSheet(type)
        }
        .navigationBarHidden(true)
    }
}

private extension SignupView {
    
    var passwordsNotMatchingLabel: some View {
        Text(Localizable.passwords_not_matching.localized)
            .multilineTextAlignment(.leading)
            .font(.system(size: 10))
            .foregroundColor(.red)
            .isHidden(viewModel.arePasswordsMathing)
    }
    
    var signUpButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.goseiRed)
            
            Text("SIGN UP")
                .font(.workSans(16, .medium))
                .foregroundColor(.white)
        }
        .frame(height: 60)
        .onTapGesture {
            viewModel.signUpTapped()
        }
    }
    
    func externalLoginButton(_ type: ExternalLoginType, onTapped: EmptyCallback? = nil) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.background)
            
            type.logoImage
                .resizable()
                .scaledToFit()
                .shadow(color: .text.opacity(0.2), radius: 5, x: 3, y: 3)
                .frame(size: 40 / 2)
        }
        .frame(size: 40)
        .shadow(color: .text.opacity(0.2), radius: 5, x: 3, y: 3)
        .onTapGesture {
            onTapped?()
        }
    }
    
    func externalSignupSheet(_ type: ExternalLoginType) -> some View {
        let foregroundColor: Color
        let backgroundColor: Color
        
        switch (type) {
        case .google:
            foregroundColor = .black
            backgroundColor = .white
        case .facebook:
            foregroundColor = .white
            backgroundColor = .facebookBlue
        case .apple:
            foregroundColor = .white
            backgroundColor = .black
        }
        
        return VStack(spacing: 20) {
            Text("\(type.rawValue) SignUp has not been implemented.")
                .font(.playfair(22, .bold))
                .foregroundColor(foregroundColor)
            
            Text("Close")
                .font(.workSans(16, .bold))
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.closeExternalSignupSheet()
                }
                .padding(5)
                .padding(.horizontal, 10)
                .foregroundColor(backgroundColor)
                .background(Capsule().fill(foregroundColor))
        }
        .padding(.horizontal, 50)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center )
        .background(backgroundColor)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(viewModel: SignupViewModel())
            
        SignupView(viewModel: SignupViewModel())
            .previewDevice("The Living Hell")
    }
}
