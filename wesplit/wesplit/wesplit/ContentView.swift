//
//  ContentView.swift
//  wesplit
//
//  Created by Leonid on 29.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfPeople = 2
    @State private var invoiceCount = ""
    @State private var percentTip = 2
    
    let percents = [10, 15, 20, 25, 0]
    
    var invoiceEnd: Double {
        let invoiceInt = Double(invoiceCount) ?? 0
        let newNumberOfPeople = Double(numberOfPeople + 2)
        let newPercents = Double(percents[percentTip])
        
        let summ = invoiceInt / newNumberOfPeople
        let perc = newPercents / 100
        let itogo = summ * perc
        /*
         number of people
         bill
         %
         
         
         $1000 / 10people = $100 * 0.10
 
         */
        return itogo
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Invoice", text: $invoiceCount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach( 2..<100 ) { item in
                            Text("\(item)")
                        }
                    }
                }
                Section(header: Text("Hou much %")) {
                    Picker("", selection: $percentTip) {
                        ForEach(0..<percents.count) { item in
                            Text("\(percents[item])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("$\(invoiceEnd, specifier: "%.2f")")
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
