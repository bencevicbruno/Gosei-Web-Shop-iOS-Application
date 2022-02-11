//
//  ChangeInfoView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct ChangeInfoView: View {
    
    @ObservedObject var viewModel: ChangeInfoViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(title: "Change Info", onDismiss: viewModel.dismiss)
            
            VStack(alignment: .leading, spacing: 0) {
                emailField
                
                adressField
                
                phoneNumberField
                    .padding(.top, 20)
                
                birthdayFields
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    saveButton
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
        }
        .foregroundColor(Color.text)
        .background(Color.background)
        .navigationBarHidden(true)
    }
}

private extension ChangeInfoView {
    
    func textField(_ binding: Binding<String>, hint: String, color: Color) -> some View {
        TextField(hint, text: binding)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 4)
                            .strokeBorder(Color.text, lineWidth: 1)
                            .frame(height: 50))
    }
    
    var emailField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Email")
                .font(.playfair(16, .bold))
                .padding(.bottom, 15)
            
            textField($viewModel.email, hint: "Enter your email here", color: viewModel.isEmailValid ? .black : .goseiRed)
            
            Text("Please insert a valid email adress.")
                .font(.workSans(10))
                .foregroundColor(.goseiRed)
                .isHidden(viewModel.isEmailValid)
                .padding(.vertical, 5)
        }
    }
    
    var adressField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Adress")
                .font(.playfair(16, .bold))
                .padding(.bottom, 15)
            
            textField($viewModel.adress, hint: "Enter your adress here", color: Color.text)
        }
    }
    
    var phoneNumberField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Phone Number")
                .font(.playfair(16, .bold))
                .padding(.bottom, 15)
            
            textField($viewModel.phoneNumber, hint: "Enter your phone number here", color: viewModel.isPhoneNumberValid ? .black : .goseiRed)
            
            Text("Please insert a valid phone number")
                .font(.workSans(10))
                .foregroundColor(.goseiRed)
                .isHidden(viewModel.isPhoneNumberValid)
                .padding(.vertical, 5)
        }
    }
    
    var birthdayFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Date of Birth")
                .font(.playfair(16, .bold))
                .padding(.bottom, 15)
            
            HStack {
                textField($viewModel.birthDay, hint: "dd.", color: viewModel.isBirthdayDateValid ? Color.text : .goseiRed)
                    .frame(width: 50)
                
                textField($viewModel.birthDay, hint: "mm.", color: viewModel.isBirthdayDateValid ? Color.text : .goseiRed)
                    .frame(width: 50)
                
                textField($viewModel.birthDay, hint: "yyyy.", color: viewModel.isBirthdayDateValid ? Color.text : .goseiRed)
                    .frame(width: 70)
            }
            
            Text("Please insert a valid date.")
                .font(.workSans(10))
                .foregroundColor(.goseiRed)
                .isHidden(viewModel.isBirthdayDateValid)
                .padding(.vertical, 5)
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

struct ChangeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeInfoView(viewModel: .init(user: .sample))
        ChangeInfoView(viewModel: .invalidLabels)
    }
}
