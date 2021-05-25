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
    
    // MARK: - Converted properties for calculations
    var currentTipAmount: Double {
        return Double(tipPercenteges[tipSelection])
    }
    
    var checkAmountDouble: Double {
        return Double(checkAmount) ?? 0
    }
    
    var peopleAmountDouble: Double {
        return Double(peopleAmount)
    }
    
    // MARK: - Currency formatter
    var formatterCurrency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    //    MARK: - Total amounts
    var tipAmountForCheck: Double {
        return checkAmountDouble / 100 * currentTipAmount
    }

    var totalPerPerson: String {
        let totalOrder = checkAmountDouble + tipAmountForCheck
        let perPersonAmount = totalOrder / peopleAmountDouble
        let result = formatterCurrency.string(from: NSNumber(value: perPersonAmount))!
        
        return result
    }
    
    
    var tipPercentFormatted: String {
        let result = formatterCurrency.string(from: NSNumber(value: tipAmountForCheck))!
       
        return result
    }
    
    var tipPerPerson: String {
        let tipPerPerson = tipAmountForCheck / peopleAmountDouble
        let result = formatterCurrency.string(from: NSNumber(value: tipPerPerson))!

        return result
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

struct ContentView: View {
    
    @ObservedObject var vm = SplitViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                if vm.checkAmountDouble > 0 {
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
                                Text("\(vm.tipPercentFormatted)")
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
                    
                    HStack {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            TextField("Check amount", text: $vm.checkAmount)
                                .keyboardType(.decimalPad)
                                .padding(.leading)
                            Text("$")
                        }
                        
                        Stepper(
                            onIncrement: { vm.incrementPeopleAmount() },
                            onDecrement: { vm.decrementPeopleAmount() },
                            label: {
                                Text("for \(vm.peopleAmount)")
                                    .font(.callout)
                            })
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Tip amount")
                            .font(.callout)
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
