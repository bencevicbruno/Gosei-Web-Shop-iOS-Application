//
//  TimerScreen.swift
//  Gosei
//
//  Created by Bruno Benčević on 04.01.2022..
//

import SwiftUI

struct Pacman: Identifiable {
    let id = UUID()
    private var mouthTime = 0.0
    private var offset = Double.random(in: 0...(2 * .pi))
    
    mutating func update() {
        mouthTime += 0.1
    }
    
    var shape: some Shape {
        let height = abs(sin(mouthTime - offset)) * 0.5
        
        return Triangle(points: [
            CGPoint(x: 0.5, y: 0.5),
            CGPoint(x: 1.0, y: 0.0 + height),
            CGPoint(x: 1.0, y: 1.0 - height)
        ])
    }
    
}

struct TimerScreen: View {
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var pacmans = [Pacman]()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(pacmans) { pacman in
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.yellow)
                            
                            pacman.shape
                                .foregroundColor(Color(uiColor: .systemGroupedBackground))
                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        
                        Spacer()
                    }
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
        }
        .onReceive(timer) { _ in
            updatePacmans()
        }
    }
    
    init() {
        var pacmans = [Pacman]()
        (1...10).forEach { _ in
            pacmans.append(Pacman())
        }
        
        self._pacmans = State(initialValue: pacmans)
    }
    
    private func updatePacmans() {
        for i in 0..<pacmans.count {
            pacmans[i].update()
        }
    }
}

struct TimerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TimerScreen()
    }
}
