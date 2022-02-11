//
//  DataFetchingScreen.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import SwiftUI
import Combine

struct DataFetchingScreen: View {
    
    @ObservedObject var viewModel = DataFetchingViewModel()
    
    var body: some View {
        VStack {
            header
            
            searchBox
            
            searchResults
            
            options
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
            
            Text("Fetching data from internet")
                .font(.headline)
                .fontWeight(.medium)
            
            Spacer()
        }
    }
    
    var searchBox: some View {
        HStack {
            TextField("Search Movies", text: $viewModel.keyword)
            
            Image(systemName: "magnifyingglass")
                .contentShape(Rectangle())
                .onTapGesture(perform: viewModel.fetchMovies)
        }
        .frame(width: 300)
        .padding(5)
        .background(Color(uiColor: .systemFill))
    }
    
    var searchResults: some View {
        List {
            ForEach(viewModel.searchResults) { show in
                Text(show.name)
            }
        }
    }
    
    var options: some View {
        VStack {
            HStack {
                Text("Fetch data while typing:")
                    .layoutPriority(999)
                
                Spacer()
                
                Toggle("", isOn: $viewModel.fetchDataWhileTyping)
            }
            
            HStack {
                Stepper("Delay amount: \(viewModel.delayTime)", value: $viewModel.delayIndex, in: viewModel.delayIndexRange)
            }
        }
        .padding()
        .padding(.horizontal)
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    init() {
    }
}

struct DataFetchingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DataFetchingScreen()
    }
}
