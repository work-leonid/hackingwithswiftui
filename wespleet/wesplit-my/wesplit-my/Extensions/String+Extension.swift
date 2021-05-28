//
//  String+Extension.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
}
