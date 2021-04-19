//
//  SegmentedPicker.swift
//  WeSplitMy
//
//  Created by Leonid Nazarov on 19.04.2021.
//

import SwiftUI

struct SegmentedPicker: View {
    
    @State private var selectedItem = 1
    let items = [0, 1, 2, 3, 4]
    
    var body: some View {
        VStack {
            Picker("Picker", selection: $selectedItem) {
                ForEach(0..<items.count) { item in
                    Text("\(items[item])")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Text("Current item is: \(items[selectedItem])")
        }
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker()
    }
}
