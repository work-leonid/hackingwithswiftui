//
//  AccountingViewModel.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import Foundation

class AccountingViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var checkAmount = ""
    @Published var tipSelection = 2
    @Published var peopleAmount = 1
    
    // MARK: - Local
    private(set) var tipPercenteges = [10, 15, 20, 0]
    
    // MARK: - Converted properties for calculations
    var currentTipAmount: Double {
        return Double(tipPercenteges[tipSelection])
    }
    
    var isEnabled: Bool {
        if checkAmount.isEmpty {
            return false
        }
        return true
    }
    
    //    MARK: - Total amounts
    var tipAmountForCheck: Double {
        return checkAmount.toDouble() / 100 * currentTipAmount
    }

    var totalPerPerson: String {
        let totalOrder = checkAmount.toDouble() + tipAmountForCheck
        let perPersonAmount = totalOrder / peopleAmount.toDouble()
        return perPersonAmount.formatAsCurrency()
    }
    
    var tipPerPerson: String {
        let tipPerPerson = tipAmountForCheck / peopleAmount.toDouble()
        return tipPerPerson.formatAsCurrency()
    }
    
//    MARK: - Functions
    func incrementPeopleAmount() {
        peopleAmount += 1
    }
    
    func decrementPeopleAmount() {
        peopleAmount -= 1
        if peopleAmount < 1 {
            peopleAmount = 1
        }
    }
}
