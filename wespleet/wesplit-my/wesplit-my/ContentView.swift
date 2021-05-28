//
//  ContentView.swift
//  wesplit-my
//
//  Created by Leonid Nazarov on 24.05.2021.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var vm = AccountingViewModel()
    
    var totalView: some View {
        Section {
            HStack {
                Text("totalCheckTitle")
                Spacer()
                Text("\(vm.totalPerPerson)")
                    .font(.title)
                    .padding(.vertical)
            }
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("totalTipsForAllTitle")
                        .font(.callout)
                        .foregroundColor(.gray)
                    Text("\(vm.tipAmountForCheck.formatAsCurrency())")
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("totalTipPerPersonTitle")
                        .font(.callout)
                        .foregroundColor(.gray)
                    Text("\(vm.tipPerPerson)")
                }
                
            }
            .padding(.vertical)
        }
    }
    
    var formView: some View {
        Section {
            HStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    TextField("textFieldPlaceholder", text: $vm.checkAmount)
                        .keyboardType(.decimalPad)
                        .padding(.leading)
                    Text("$")
                }
                
                Stepper(
                    onIncrement: { vm.incrementPeopleAmount() },
                    onDecrement: { vm.decrementPeopleAmount() },
                    label: {
                        Text("peopleAmount \(vm.peopleAmount)")
                            .font(.callout)
                    })
            }
            
            VStack(alignment: .leading) {
                Text("tipPersentagesTitle")
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
    
    var body: some View {
        NavigationView {
            Form {
                if vm.isEnabled {
                    totalView
                }
                formView
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
            .environment(\.locale, .init(identifier: "ru"))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        
        ContentView()
            .environment(\.locale, .init(identifier: "ru"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        
    }
}
