//
//  LocationScreen.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import SwiftUI

struct LocationScreen: View {
    
    @ObservedObject var viewModel = LocationViewModel()
    
    var body: some View {
        VStack {
            Text("Hi there!")
                .padding(.all.subtracting(.bottom))
            
            Text("You're currently in \(viewModel.currentLocation).")
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Your coordinates are \(coordinates).")
                .multilineTextAlignment(.center)
                .padding(.all.subtracting(.top))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(uiColor: .systemGroupedBackground)))
    }
}

private extension LocationScreen {
    var coordinates: String {
        "\(viewModel.currentCoordinates.latitude)°, \(viewModel.currentCoordinates.longitude)°"
    }
}

struct LocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationScreen()
    }
}
