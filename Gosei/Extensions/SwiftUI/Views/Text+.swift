//
//  Text+.swift
//  Gosei
//
//  Created by Bruno Benčević on 05.02.2022..
//

import Foundation
import SwiftUI

extension Text {
    
    init(_ localizable: Localizable) {
        self.init(localizable.localized)
    }
}
