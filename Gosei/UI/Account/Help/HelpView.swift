//
//  HelpView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct HelpView: View {
    
    @ObservedObject var viewModel: HelpViewModel
    
    var body: some View {
        VStack {
            NavigationHeader(title: "Report your problem", onDismiss: viewModel.dismiss)
            
            messageField
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
            
            emailField
                .padding(.horizontal, 30)
            
            Spacer()
            
            sendButton
            
            Spacer()
        }
        .foregroundColor(Color.text)
        .background(Color.background)
        .navigationBarHidden(true)
    }
}

private extension HelpView {
    
    // TODO: Implement TextView wrapping
    var messageField: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 4)
                .stroke(style: .init(lineWidth: 1))
                .frame(height: 200)
            
            Text("Write your message here...")
                .font(.workSans(14))
                .foregroundColor(.gray)
                .padding(10)
        }
    }
    
    var emailField: some View {
        TextField("*Optional email", text: $viewModel.email)
            .foregroundColor(Color.text)
            .font(.workSans(14))
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(style: .init(lineWidth: 1)))
    }
    
    var sendButton: some View {
        Text("SEND")
            .font(.workSans(16, .medium))
            .foregroundColor(Color.background)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 4)
                            .fill(Color.text))
            .onTapGesture {
                viewModel.sendTapped()
            }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(viewModel: .init())
    }
}
