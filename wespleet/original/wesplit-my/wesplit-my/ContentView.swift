//
//  ContentView.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI

class SplitViewModel: ObservableObject {
    
    @Published var checkAmount = ""
    @Published var peopleAmount = ""
    @Published var tipSelection = 2
    @Published var peopleAmountInt = 1
    
    var tipPercenteges = [10, 15, 20, 0]
    
    var formatterCurrency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var totalPerPerson: String {
        let totalCheck = Double(checkAmount) ?? 0
        let tipPercent = Double(tipPercenteges[tipSelection])
        let amountOfPeople = Double(peopleAmount) ?? 1
        
        let tipPerPerson = totalCheck / 100 * tipPercent
        let totalOrder = totalCheck + tipPerPerson
        let perPersonAmount = totalOrder / amountOfPeople
    
        let priceString = formatterCurrency.string(from: NSNumber(value: perPersonAmount))!
        
        return priceString
    }
    
    var tipPerCheck: String {
        let totalCheck = Double(checkAmount) ?? 0
        let tipPercent = Double(tipPercenteges[tipSelection])
        
        let tipPerPerson = totalCheck / 100 * tipPercent
        let result = formatterCurrency.string(from: NSNumber(value: tipPerPerson))!
        
        return result
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = SplitViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Total")) {
                    HStack {
                        Text("Per \(vm.peopleAmount) person:")
                        Spacer()
                        Text("\(vm.totalPerPerson)")
                    }
                    HStack {
                        Text("Tip per check:")
                        Spacer()
                        Text("\(vm.tipPerCheck)")
                    }
                }
                
                
                Section {
                    HStack {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            TextField("Check", text: $vm.checkAmount)
                                .keyboardType(.decimalPad)
                                .padding(.leading)
                            Text("$")
                        }
                        
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            TextField("People", text: $vm.peopleAmount)
                                .keyboardType(.numberPad)
                                .padding(.leading, 28)
                            Image(systemName: "person.2.fill")
//                                .font(.title)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    Stepper("People: \(vm.peopleAmountInt)") {
                        self.vm.peopleAmountInt += 1
                    } onDecrement: {
                        if self.vm.peopleAmountInt > 1 {
                            self.vm.peopleAmountInt -= 1
                        }
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
    }
}
