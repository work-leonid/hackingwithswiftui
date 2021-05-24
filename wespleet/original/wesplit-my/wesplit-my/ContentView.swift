//
//  ContentView.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI

class SplitViewModel: ObservableObject {
    
    @Published var checkAmount = ""
    @Published var peopleAmount = 2
    @Published var tipSelection = 2
    
    var tipPercenteges = [10, 15, 20, 0]
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }
    
    var totalPerPerson: String {
        let totalCheck = Double(checkAmount) ?? 0
        let tipPercent = Double(tipPercenteges[tipSelection])
        let amountOfPeople = Double(peopleAmount + 2)
        
        let tipPerPerson = totalCheck / 100 * tipPercent
        let totalOrder = totalCheck + tipPerPerson
        let perPersonAmount = totalOrder / amountOfPeople
    
        let priceString = formatter.string(from: NSNumber(value: perPersonAmount))!

        
        return priceString
    }
    
    var tipPerCheck: Double {
        let totalCheck = Double(checkAmount) ?? 0
        let tipPercent = Double(tipPercenteges[tipSelection])
        
        let tipPerPerson = totalCheck / 100 * tipPercent
        
        return tipPerPerson
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = SplitViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check amount", text: $vm.checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $vm.peopleAmount) {
                        ForEach(2..<99) {
                            Text("\($0)")
                        }
                    }
                }
                
                
                Section {
                    Picker("Tip count", selection: $vm.tipSelection) {
                        ForEach(0..<vm.tipPercenteges.count) { index in
                            Text("\(vm.tipPercenteges[index])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Tip per check $: \(vm.tipPerCheck, specifier: "%.2f")")
                    Text("Tip per person $: \(vm.tipPerCheck / Double(vm.peopleAmount + 2), specifier: "%.2f")")
                }
                
                Section(header: Text("Per person")) {
                    Text("\(vm.totalPerPerson)")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
