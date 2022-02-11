//
//  ImageSliderViewModel.swift
//  Gosei
//
//  Created by Bruno Benčević on 08.01.2022..
//

import Foundation
import Combine
import SwiftUI

final class ImageSliderViewModel: ObservableObject {
    
    var images: [String]
    
    @Published var index = 0
    @Published var slideValue = 0.0
    @Published var isInteractionDisabled = false
    
    init(images: [String]) {
        self.images = images
    }
    
    var previousIndex: Int {
        (self.index - 1) < 0 ? (self.images.count - 1) : (self.index - 1)
    }
    
    var nextIndex: Int {
        (self.index + 1) % self.images.count
    }
    
    // MARK: - Interaction
    
    func nextPicture() {
        guard !self.isInteractionDisabled else { return }
        self.isInteractionDisabled = true
        
        Self.animate { [weak self] in
            self?.slideValue = -1.0
        } completion: { [weak self] in
            guard let self = self else { return }
            
            self.index = (self.index + 1) % self.images.count
            self.slideValue = 0.0
            self.isInteractionDisabled = false
        }
    }
    
    func previousPicture() {
        guard !self.isInteractionDisabled else { return }
        self.isInteractionDisabled = true
        
        Self.animate { [weak self] in
            self?.slideValue = 1.0
        } completion: { [weak self] in
            guard let self = self else { return }
            
            self.index = (self.index - 1) < 0 ? (self.images.count - 1) : (self.index - 1)
            self.slideValue = 0.0
            self.isInteractionDisabled = false
        }
    }
    
    static var forPreview: ImageSliderViewModel {
        let images = ItemCategory.allCases.reduce(into: []) { result, category in
            result.append(category.imageName)
        }
        
        return ImageSliderViewModel(images: images)
    }
}

private extension ImageSliderViewModel {
    
    static func animate(_ animation: @escaping () -> Void, completion: @escaping () -> Void) {
        let animationDuration = 0.5
        
        withAnimation(Animation.easeInOut(duration: animationDuration)) {
            animation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            completion()
        }
    }
}
