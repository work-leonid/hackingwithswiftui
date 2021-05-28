//
//  ContentView.swift
//  guess the flag -my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = FlagGameManager()
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Guess the flag")
                        Text("\(vm.targetCountry)")
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Score")
                        HStack {
                            Button(action: {
                                vm.resetGame()
                                vm.showingSheet = true
                            }, label: {
                                HStack {
                                    Text("\(vm.userScore)")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            })
                            .actionSheet(isPresented: $vm.showingSheet) {
                                ActionSheet(
                                    title: Text("title"),
                                    message: Text("title"),
                                    buttons: [.default(Text("ok")), .cancel()])
                            }
                        }
                    }
                }
                .foregroundColor(.white)

                Spacer()
                
                VStack {
                    ForEach(0..<3) { item in
                        Button(action: {
                            vm.answer(item)
                        }, label: {
                            Image(vm.allCountries[item])
                        })
                    }
                }
                
                Spacer()
                
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
