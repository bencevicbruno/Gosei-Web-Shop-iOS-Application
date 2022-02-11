//
//  InputField.swift
//  Gosei
//
//  Created by Bruno Benčević on 30.11.2021..
//

import SwiftUI

struct InputField: View {
    @Binding var input: String
    private var hint: String
    private var hintColor: Color
    private var borderColor: Color
    private var borderSize: CGFloat
    
    var body: some View {
        TextField(hint, text: $input)
            .foregroundColor(hintColor)
            .padding()
            .background(Color.white)
            .padding(borderSize)
            .background(borderColor)
    }
    
    init(_ input: Binding<String>, hint: String = "", hintColor: Color = .darkGray, borderColor: Color = .gray, borderSize: CGFloat = 1) {
        self._input = input
        self.hint = hint
        self.hintColor = hintColor
        self.borderColor = borderColor
        self.borderSize = borderSize
    }
    
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        InputField(.constant("Test"))
    }
}
