//
//  BluetoothScreen.swift
//  Gosei
//
//  Created by Bruno Benčević on 05.01.2022..
//

import SwiftUI

struct BluetoothScreen: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("TODO: Test Bluetooth with Combine")
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
            
            Text("- use didUpdateValueFor and @Published properties")
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
    }
}

struct BluetoothScreen_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothScreen()
    }
}
