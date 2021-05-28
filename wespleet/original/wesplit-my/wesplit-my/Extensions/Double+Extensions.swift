//
//  Double+Extensions.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import Foundation

extension Double {
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
