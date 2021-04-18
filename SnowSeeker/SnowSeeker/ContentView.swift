//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Leonid Nazarov on 18.04.2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                HStack(content: UserView.init)
            } else {
                VStack {
                    UserView()
                }
            }
        }
        
    }
}

struct User: Identifiable {
    var id = "Taylor swift"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
