//
//  ContentView.swift
//  wesplit
//
//  Created by Leonid on 29.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfPeople = 2
    @State private var checkAmount = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        
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
                        ForEach( 2..<100 ) { item in
                            Text("\(item)")
                        }
                    }
                }
                Section(header: Text("Hou much %")) {
                    Picker("", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) { item in
                            Text("\(tipPercentages[item])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
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
