//
//  ContentView.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI

class SplitViewModel: ObservableObject {
    
    @Published var checkAmount = ""
    @Published var tipSelection = 2
    @Published var peopleAmount = 1
    
    var tipPercenteges = [10, 15, 20, 0]
    
    var currentTipCount: Double {
        return Double(tipPercenteges[tipSelection])
    }
    
    var totalOrder: Double {
        return Double(checkAmount) ?? 0
    }
    
    var amountOfPeople: Double {
        return Double(peopleAmount)
    }
    
    var formatterCurrency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var totalPerPerson: String {
        let tipPerPerson = totalOrder / 100 * currentTipCount
        let totalOrder = totalOrder + tipPerPerson
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


struct StepperView: View {
    @State private var value = 0
    let colors: [Color] = [.orange, .red, .gray, .blue,
                           .green, .purple, .pink]

    func incrementStep() {
        value += 1
        if value >= colors.count { value = 0 }
    }

    func decrementStep() {
        value -= 1
        if value < 0 { value = colors.count - 1 }
    }

    var body: some View {
        Stepper(onIncrement: incrementStep,
            onDecrement: decrementStep) {
            Text("Value: \(value) Color: \(colors[value].description)")
        }
        .padding(5)
        .background(colors[value])
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = SplitViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Total")) {
                    HStack {
                        Text("Payment for \(vm.peopleAmount) person:")
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
