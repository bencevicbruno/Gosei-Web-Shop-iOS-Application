//
//  Date+.swift
//  Gosei
//
//  Created by Bruno Benčević on 17.01.2022..
//

import Foundation

extension Date {
    
    init?(day: Int, month: Int, year: Int) {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month, day: day)
        
        if let date = calendar.date(from: components) {
            self = date
        } else {
            return nil
        }
    }
    
    var asString: String? {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
        guard let day = components.day, let month = components.month, let year = components.year else { return nil }
        
        return "\(day)/\(month < 10 ? "0\(month)" : "\(month)")/\(year)"
    }
}
