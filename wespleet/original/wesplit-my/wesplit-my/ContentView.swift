//
//  ContentView.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI

class SplitViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var checkAmount = ""
    @Published var tipSelection = 2
    @Published var peopleAmount = 1
    
    // MARK: - Local
    var tipPercenteges = [10, 15, 20, 0]
    
    // MARK: - Converted
    var currentTipAmount: Double {
        return Double(tipPercenteges[tipSelection])
    }
    
    var checkAmountConverted: Double {
        return Double(checkAmount) ?? 0
    }
    
    var peopleAmountConverted: Double {
        return Double(peopleAmount)
    }
    
    // MARK: - Formatter
    var formatterCurrency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
//    MARK: - Total amounts
    var totalPerPerson: String {
        let tipPerPerson = checkAmountConverted / 100 * currentTipAmount
        let totalOrder = checkAmountConverted + tipPerPerson
        let perPersonAmount = totalOrder / peopleAmountConverted
    
        let result = formatterCurrency.string(from: NSNumber(value: perPersonAmount))!
        
        return result
    }
    
    var tipPerCheck: String {
        let totalCheck = Double(checkAmount) ?? 0
        let tipPercent = Double(tipPercenteges[tipSelection])
        
        let tipPerPerson = totalCheck / 100 * tipPercent
        let result = formatterCurrency.string(from: NSNumber(value: tipPerPerson))!
        
        return result
    }
    
    var tipPerPerson: String {
//        let totalCheck = Double(checkAmount) ?? 0
//        let tipPercent = Double(tipPercenteges[tipSelection])
        
//        let tipPerPerson = totalCheck / 100 * tipPercent
        var perPerson: Double = 0
        
        
        let tipInPercent = checkAmountConverted / 100 * currentTipAmount
        let tipPerPerson = tipInPercent / peopleAmountConverted
        
//        if checkAmountConverted == 0 {
//            perPerson = 0
//        } else {
//            perPerson = currentTipAmount / 100 / peopleAmountConverted
//        }
        
        
        
        let result = formatterCurrency.string(from: NSNumber(value: tipPerPerson))!
        
        return result
    }
    
    
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

struct ContentView: View {
    
    @ObservedObject var vm = SplitViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                if vm.checkAmountConverted > 0 {
                    Section {
                        HStack {
                            Text("Each person pay")
                            Spacer()
                            Text("\(vm.totalPerPerson)")
                                .font(.title)
                                .padding(.vertical)
                        }
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Per check")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                Text("\(vm.tipPerCheck)")
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Per person")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                Text("\(vm.tipPerPerson)")
                            }
                            
                        }
                        .padding(.vertical)
                        
                    }
                }
                
                
                
                Section {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            TextField("Check", text: $vm.checkAmount)
                                .keyboardType(.decimalPad)
                                .padding(.leading)
                            Text("$")
                        }
                    
                    Stepper("For \(vm.peopleAmount) person") {
                        vm.incrementPeopleAmount()
                    } onDecrement: {
                        vm.decrementPeopleAmount()
                    }

                    VStack(alignment: .leading) {
                    
                        Text("Tip amount")
                        Picker("Tip count", selection: $vm.tipSelection) {
                            ForEach(0..<vm.tipPercenteges.count) { index in
                                Text("\(vm.tipPercenteges[index])%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        
    }
}
