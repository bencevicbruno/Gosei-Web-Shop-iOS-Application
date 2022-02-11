//
//  LoginView.swift
//  Gosei
//
//  Created by Bruno Benčević on 28.11.2021..
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Spacer(minLength: 10)
            
            Image(.gosei_logo)
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer(minLength: 10)
            
            externalLoginButtons
                .padding()
            
            TextSeparator(Localizable.or.localized.uppercased())
                .padding(.vertical)
            
            VStack(alignment: .leading) {
                InputField($viewModel.email, hint: Localizable.email.localized.capitalized)
                    .frame(height: 60)
                
                PasswordField($viewModel.password)
                    .frame(height: 60)
                
                invalidCredentialsLabel
            }
            
            loginButton
                .padding(.vertical)
            
            signupLabel
                .padding(.all.subtracting(.top))
            
            Spacer(minLength: 10)
        }
        .padding(.horizontal, 20)
        .background(Color.background)
        .sheet(item: $viewModel.externalLoginSheet) { type in
            externalLoginSheet(type)
        }
    }
}

private extension LoginView {
    
    var externalLoginButtons: some View {
        HStack(spacing: 20) {
            externalLoginButton(.google, onTapped: viewModel.googleSignInTapped)
            
            externalLoginButton(.facebook, onTapped: viewModel.facebookSignInTapped)
            
            externalLoginButton(.apple, onTapped: viewModel.appleSignInTapped)
        }
    }
    
    var invalidCredentialsLabel: some View {
        Text(Localizable.wrong_credidentials.localized)
            .multilineTextAlignment(.leading)
            .font(.system(size: 10))
            .foregroundColor(.red)
            .isHidden(!viewModel.areCredidentialsInvalid)
    }
    
    var loginButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.goseiRed)
            
            Text(Localizable.log_in.localized.uppercased())
                .font(.workSans(16, .medium))
                .foregroundColor(.white)
        }
        .frame(height: 60)
        .onTapGesture {
            viewModel.loginTapped()
        }
    }
    
    var signupLabel: some View {
        Group {
            Text(Localizable.new_to_gosei.localized.uppercased())
                .fontWeight(.medium)
                .foregroundColor(Color.text)
            + Text(" " + Localizable.sign_up.localized.uppercased())
                .fontWeight(.medium)
                .foregroundColor(Color.goseiRed)
        }
        .multilineTextAlignment(.center)
        .onTapGesture {
            viewModel.onGoToSignUp?()
        }
    }
}

private extension LoginView {
    
    func externalLoginButton(_ type: ExternalLoginType, onTapped: EmptyCallback? = nil) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.background)
            
            type.logoImage
                .resizable()
                .scaledToFit()
                .shadow(color: Color.text.opacity(0.2), radius: 5, x: 3, y: 3)
                .frame(size: 40 / 2)
        }
        .frame(size: 40)
        .shadow(color: Color.text.opacity(0.2), radius: 5, x: 3, y: 3)
        .onTapGesture {
            onTapped?()
        }
    }
    
    func externalLoginSheet(_ type: ExternalLoginType) -> some View {
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
            Text("\(type.rawValue) \(Localizable.login_is_not_implemented.localized)")
                .font(.playfair(22, .bold))
                .foregroundColor(foregroundColor)
            
                 Text(Localizable.close.localized.capitalized)
                .font(.workSans(16, .bold))
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.closeExternalLoginSheet()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(navigationController: UINavigationController(), persistenceService: PersistenceService()))
            .previewDevices(.iPhone13, .iPhoneSE, .iPhone8)
    }
}
