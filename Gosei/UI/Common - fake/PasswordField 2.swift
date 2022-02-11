//
//  PasswordField.swift
//  Gosei
//
//  Created by Bruno Benčević on 29.11.2021..
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    
    @State private var isPasswordHidden: Bool = true
    private var hint: String
    private var borderColor: Color
    
    var body: some View {
        HStack {
            inputField
                .foregroundColor(.darkGray)
                .padding()
            
            eyeIcon
                .resizable()
                .frame(size: 20)
                .onTapGesture {
                    self.isPasswordHidden.toggle()
                }
                .padding(.trailing)
        }
        .font(.workSans(14))
        .background(Color.white)
        .padding(1)
        .background(borderColor)
        
    }
    
    private var inputField: some View {
        self.isPasswordHidden ?
            AnyView(SecureField(hint, text: $password)) :
            AnyView(TextField(hint, text: $password))
    }
    
    private var eyeIcon: Image {
        self.isPasswordHidden ? Image.passwordHidden : Image.passwordShown
    }
    
    init(_ password: Binding<String>, hint: String = Localizable.password.capitalized, borderColor: Color = .gray) {
        self._password = password
        self.hint = hint
        self.borderColor = borderColor
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(.constant(""))
    }
}
