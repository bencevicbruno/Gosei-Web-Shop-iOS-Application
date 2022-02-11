//
//  SearchView.swift
//  Gosei
//
//  Created by Bruno Benčević on 18.01.2022..
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack {
            xButton
                .padding(.leading, 10)
            
            VStack {
                searchField
                
                content
                    .padding(.bottom, TabBarView.safeHeight)
            }
            .padding(.horizontal, 40)
        }
        .background(Color.background)
        .foregroundColor(Color.text)
    }
    
    var content: some View {
        switch(viewModel.contentState) {
        case .initial:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(loadingView)
        case .loaded(let results):
            return AnyView(loadedResult(results))
        case .error(let message):
            return AnyView(ErrorView(title: "Error", description: message))
        }
    }
}

private extension SearchView {
    
    var xButton: some View {
        HStack {
            Image(.icon_arrowLeft)
                .resizable()
                .scaledToFit()
                .frame(size: 40)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.dismiss()
                }
            
            Spacer()
        }
    }
    
    var searchField: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Type here to search", text: $viewModel.searchText)
                    .font(.workSans(20, .regular))
                    .frame(height: 40)
                    .background(Color.background)
                    .foregroundColor(Color.text)
                
                Image("icon_x_lightGray")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.searchText = ""
                    }
            }
            .frame(height: 40)
            .padding(.bottom, 5)
            .padding(.leading, 5)
            
            Rectangle()
                .fill(Color.lightGray)
                .frame(height: 1)
        }
        .background(Color.background)
        .foregroundColor(Color.text)
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            
            LoadingIndicator(.constant(true))
                .frame(size: 40)
            
            Spacer()
        }
    }
    
    func loadedResult(_ results: [String]) -> some View {
        if results.count == 0 {
            return AnyView(noSearchResults)
        } else {
            return AnyView(searchResults(results))
        }
    }
    
    func searchResults(_ results: [String]) -> some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(results, id: \.self) { result in
                    HStack {
                        Text(result)
                            .font(.workSans(20, .regular))
                        
                        Spacer()
                    }
                }
            }
        }
    }
    
    var noSearchResults: some View {
        ErrorView(title: "Oh, it must be us", description: "We are sorry but we didn't find what you were searching for.", imageName: "icon_sadFace")
    }
}

struct SearchView_Previews: PreviewProvider {
    static let results = (1...10).reduce(into: [String]()) { result, number in
        result.append("search result #\(number)")
    }
    
    static var previews: some View {
        Group {
            VStack {
                SearchView(viewModel: SearchViewModel(state: .initial))
                
                Spacer()
            }
            
            SearchView(viewModel: SearchViewModel(state: .error(message: "Here is an error")))
            SearchView(viewModel: SearchViewModel(state: .loaded(results: Self.results)))
            SearchView(viewModel: SearchViewModel(state: .loading))
        }
        .frame(size: .infinity)
    }
}
