//
//  LanguageView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct LanguageView: View {
    
    @ObservedObject var viewModel: LanguageViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeader(title: "Language", onDismiss: viewModel.dismiss)
            
            ForEach(PersistenceData.Language.allCases) { language in
                HStack(spacing: 0) {
                    Text(language.name)
                        .font(.playfair(22, .bold))
                        .padding(.vertical, 7.5)
                    
                    Spacer()
                    
                    Image("icon_triangleRight_filled")
                        .resizable()
                        .scaledToFit()
                        .frame(size: 20)
                        .isHidden(language == viewModel.selectedLanuage)
                }
                .onTapGesture {
                    viewModel.languageTapped(language)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(viewModel: LanguageViewModel(persistenceService: PersistenceService()))
    }
}
