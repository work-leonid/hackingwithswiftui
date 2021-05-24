//
//  ContentView.swift
//  wesplit-original
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeopleField = ""
    @State private var tipsSelection = 2
//    @State private var amountOfPeople = 2
    
    var tipsPercenteges = [10, 15, 20, 30, 0]
    
    var totalPerPerson: Double {
//        let peopleCount = Double(amountOfPeople + 2)
        let tipSelected = Double(tipsPercenteges[tipsSelection])
        let orderAmount = Double(checkAmount) ?? 0
        let peopleCount = Double(numberOfPeopleField) ?? 1
                
        let tipValue = orderAmount / 100 * tipSelected
        let grandTotal = orderAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalForCheck: Double {
        let tipSelected = Double(tipsPercenteges[tipsSelection])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelected
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalTip: Double {
        let tipSelected = Double(tipsPercenteges[tipsSelection])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelected
        
        return tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
//                    Picker("Number of people", selection: $amountOfPeople) {
//                        ForEach(2..<99) {
//                            Text("\($0) people")
//                        }
//                    }
                    
                    TextField("Number of people", text: $numberOfPeopleField)
                        .keyboardType(.numberPad)
                    
                }
                
                Section(header: Text("Tips persentage")) {
                    Picker("Tips", selection: $tipsSelection) {
                        ForEach(0..<tipsPercenteges.count) { index in
                            Text("\(tipsPercenteges[index])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount the tip")) {
                    Text("$\(totalTip, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount for the check")) {
                    Text("$\(totalForCheck, specifier: "%.2f")")
                }
                
            }
            .navigationTitle("We split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
