//
//  ContentView.swift
//  guess the flag -my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import SwiftUI

struct FlagButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .overlay(configuration.isPressed ? Color.white : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.3), radius: configuration.isPressed ? 2 : 10, x: 0.0, y: configuration.isPressed ? 0 : 10)
            .opacity(configuration.isPressed ? 0.9 : 1)
            
        
    }
}

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
//                                vm.resetGame()
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
                                    buttons: [.destructive(Text("Reset game"), action: {
                                        vm.resetGame()
                                    }), .cancel()])
                            }
                        }
                    }
                }
                .foregroundColor(.white)

                Spacer()
                
                VStack(spacing: 30) {
                    ForEach(0..<3) { item in
                        Button(action: {
                            vm.answer(item)
                        }, label: {
                            Image(vm.allCountries[item])
                        })
                        .buttonStyle(FlagButton())
                        
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
