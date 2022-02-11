//
//  NotImplementedView.swift
//  Gosei
//
//  Created by Bruno Benčević on 24.01.2022..
//

import SwiftUI

struct NotImplementedView: View {
    
    var title: String?
    var onDismissed: EmptyCallback?
    
    var body: some View {
        VStack {
            if let title = title {
                NavigationHeader(title: title, onDismiss: onDismissed)
            }
            
            Spacer()
            
            Group {
                Text("This View has not been implemented. Please go back :)")
            }
            .font(.workSans(22, .medium))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .foregroundColor(Color.text)
        .background(Color.background)
    }
}

struct NotImplementedView_Previews: PreviewProvider {
    static var previews: some View {
        NotImplementedView(title: "Test Case #1")
        
        NotImplementedView()
    }
}
