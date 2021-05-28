//
//  ContentView.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var vm = AccountingViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                if vm.checkAmount.toDouble() > 0 {
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
                                Text("\(vm.tipAmountForCheck.formatAsCurrency())")
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
