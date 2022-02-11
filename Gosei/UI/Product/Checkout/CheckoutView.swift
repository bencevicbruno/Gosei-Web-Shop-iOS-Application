//
//  CheckoutView.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.02.2022..
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var viewModel: CheckoutViewModel
    
    var body: some View {
        VStack {
            header
            
            CheckoutProgressBar($viewModel.step)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            
            content
                .transition(.opacity)
                .padding(.horizontal, 40)
            
        }
        .background(Color.background)
        .foregroundColor(Color.text)
        .navigationBarHidden(true)
    }
}

private extension CheckoutView {
    
    var header: some View {
        HStack(spacing: 0) {
            Image(.icon_arrowLeft)
                .resizable()
                .scaledToFit()
                .frame(size: 30)
                .padding(5)
                .isHidden(viewModel.step != .billing)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.viewModel.backTapped()
                }
            
            Spacer(minLength: 10)
            
            Text(viewModel.step.title)
                .font(.playfair(18, .bold))
            
            Spacer(minLength: 10)
            
            Image(.icon_x)
                .resizable()
                .scaledToFit()
                .frame(size: 20)
                .padding(10)
                .isHidden(viewModel.step == .done)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.viewModel.xTapped()
                }
        }
    }
    
    var content: some View {
        switch(viewModel.step) {
        case .shipping:
            return AnyView(shippingDetailsContent)
        case .billing:
            return AnyView(paymentDetailsContent)
        case .done:
            return AnyView(doneContent)
        }
    }
    
    var shippingDetailsContent: some View {
        VStack(spacing: 20) {
            inputField($viewModel.adress, title: "Adress")
            
            inputField($viewModel.streetNumber, title: "Street Number")
            
            inputField($viewModel.country, title: "Country")
            
            Spacer(minLength: 20)
            
            actionButton("CHECKOUT", onTapped: viewModel.checkoutTapped)
            
            Spacer(minLength: 20)
        }
    }
    
    var paymentDetailsContent: some View {
        VStack(spacing: 20) {
            inputField($viewModel.name, title: "name")
            
            HStack(alignment: .bottom, spacing: 0) {
                inputField($viewModel.cardNumber, title: "Card Number")
                
                VStack(alignment: .trailing) {
                    Image("logo_visa")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                    
                    Rectangle()
                        .fill(Color.text)
                        .frame(height: 1)
                }
                .frame(width: 60)
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Expiration Date")
                        .font(.playfair(16, .bold))
                        .foregroundColor(Color.text)
                    
                    HStack(alignment: .bottom, spacing: 2) {
                        VStack(spacing: 0) {
                            TextField("", text: $viewModel.expirationMonth)
                                .frame(height: 30)
                                .padding(.bottom, 5)
                            
                            Rectangle()
                                .fill(Color.text)
                                .frame(height: 1)
                        }
                        
                        Image(.icon_slash)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            
                        VStack(spacing: 0) {
                            TextField("", text: $viewModel.expirationYear)
                                .frame(height: 30)
                                .padding(.bottom, 5)
                            
                            Rectangle()
                                .fill(Color.text)
                                .frame(height: 1)
                        }
                    }
                    .frame(height: 35)
                }
                
                Spacer(minLength: 70)
                
                inputField($viewModel.cvv, title: "CVV")
                    .frame(width: 60)
            }
            
            Spacer(minLength: 20)
            
            actionButton("CONFIRM", onTapped: viewModel.confirmTapped)
            
            Spacer(minLength: 20)
        }
    }
    
    var doneContent: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 20)
            
            Image(.ilustration_checkoutSucessful)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200, alignment: .center)
            
            Spacer(minLength: 20)
            
            Group {
                Text("Your order number is:")
                    .padding(.bottom, 5)
                
                Text("HFS123456789")
            }
            .font(.playfair(16, .bold))
            .foregroundColor(Color.text)
            
            Spacer(minLength: 20)
            
            actionButton("RETURN TO HOME PAGE", onTapped: viewModel.returnToHomePageTapped)
            
            Spacer(minLength: 20)
        }
    }
    
    func inputField(_ binding: Binding<String>, title: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.playfair(16, .bold))
                .foregroundColor(Color.text)
            
            TextField("", text: binding)
                .frame(height: 30)
                .padding(.bottom, 5)
            
            Rectangle()
                .fill(Color.text)
                .frame(height: 1)
            
        }
    }
    
    func actionButton(_ title: String, onTapped: EmptyCallback? = nil) -> some View {
        Text(title)
            .font(.workSans(16, .regular))
            .foregroundColor(Color.background)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 4)
                            .fill(Color.text))
            .contentShape(RoundedRectangle(cornerRadius: 4))
            .onTapGesture {
                onTapped?()
            }
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(viewModel: CheckoutViewModel(step: .billing))
            .previewDevices(.iPhone13, .iPhoneSE)
    }
}
