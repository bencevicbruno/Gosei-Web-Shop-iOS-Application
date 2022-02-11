//
//  UIStyleService.swift
//  Gosei
//
//  Created by Bruno Benčević on 07.02.2022..
//

import Foundation

final class UIStyleService: ObservableObject {
    @Published var language: PersistenceData.Language = .english
    @Published var colorScheme: PersistenceData.ColorScheme = .light
}
