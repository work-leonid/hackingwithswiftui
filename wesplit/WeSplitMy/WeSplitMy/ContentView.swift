//
//  ContentView.swift
//  WeSplitMy
//
//  Created by Leonid Nazarov on 19.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
//    var payment: Int {
//        let invoiceInt = Int(checkAmount) ?? 0
//        let percent = Int(tipPercentages[tipPercentage])
//
//        let perPerson = (invoiceInt * percent) / 100
//        let payment = (perPerson / numberOfPeople) + (invoiceInt / numberOfPeople)
//        return payment
//    }
    
    var payment: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Invoice", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { item in
                            Text("\(item)")
                        }
                    }
                }
                
                Section(header: Text("How much %?")) {
                    Picker("Percent", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) { item in
                            Text("\(tipPercentages[item])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("How much each of you should pay")) {
                    Text("$\(payment, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
