//
//  ImageSlider.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.01.2022..
//

import SwiftUI

struct ImageSlider: View {
    
    @ObservedObject var viewModel: ImageSliderViewModel
    
    private var spacing: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: spacing) {
                prevPicture
                    .frame(width: geo.size.width)
                    .clipped()
                    .offset(x: geo.size.width * viewModel.slideValue)
                
                currentPicture
                    .frame(width: geo.size.width)
                    .clipped()
                    .offset(x: geo.size.width * viewModel.slideValue)
                
                nextPicture
                    .frame(width: geo.size.width)
                    .clipped()
                    .offset(x: geo.size.width * viewModel.slideValue)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded { value in
                    let dragAmount = value.translation.width
                    
                    if dragAmount > 0 {
                        viewModel.previousPicture()
                    } else if value.translation.width < 0 {
                        viewModel.nextPicture()
                    }
                })
        }
    }
    
    init(_ viewModel: ImageSliderViewModel, spacing: CGFloat = 0) {
        self.viewModel = viewModel
        self.spacing = spacing
    }
}

private extension ImageSlider {
    
    var currentPicture: some View {
        Image(viewModel.images[viewModel.index])
            .resizable()
            .scaledToFill()
    }
    
    var prevPicture: some View {
        Image(viewModel.images[viewModel.previousIndex])
            .resizable()
            .scaledToFill()
    }
    
    var nextPicture: some View {
        Image(viewModel.images[viewModel.nextIndex])
            .resizable()
            .scaledToFill()
    }
}

struct ImageSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = ImageSliderViewModel.forPreview
        
        return VStack {
            ImageSlider(viewModel)
            
            HStack {
                Button("Back") {
                    viewModel.previousPicture()
                }
                
                Button("Next") {
                    viewModel.nextPicture()
                }
            }
        }
    }
}
