//
//  CombineTestsScreen.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import SwiftUI

struct CombineTestsScreen: View {
    var body: some View {
        VStack {
            header
            
            content
        }
    }
    
    var header: some View {
        HStack {
            Spacer()
            
            Text("Combine Tests")
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
        }
        .padding()
        .background(Color(uiColor: .systemFill))
    }
    
    var content: some View {
        TabView {
            DataFetchingScreen()
                .tabItem {
                    Image(systemName: "wifi")
                    Text("Data")
                }
            
            BluetoothScreen()
                .tabItem {
                    Image(systemName: "b.circle")
                    Text("Bluetooth")
                }
            
            TimerScreen()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }
            
            LocationScreen()
                .tabItem {
                    Image(systemName: "location")
                    Text("Location")
                }
        }
    }
}

struct CombineTestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CombineTestsScreen()
    }
}
