//
//  ContentView.swift
//  guess the flag -my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import SwiftUI

class FlagManager: ObservableObject {
    private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @Published var correctAnswer = Int.random(in: 0...2)
    @Published var userScore = 0
    @Published var answerTitle = ""
    @Published var showingSheet = false
    
    var allCountries: Array<String> {
        countries
    }
    
    var targetCountry: String {
        allCountries[correctAnswer]
    }
    
    func answer(_ item: Int) {
        if item == correctAnswer {
            userScore += 1
            answerTitle = "Correct"
            newGame()
        } else {
            newGame()
            answerTitle = "Wrong"
        }
    }
    
    func newGame() {
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
    }
    
    func resetGame() {
        newGame()
        userScore = 0
    }
    
}

struct ContentView: View {
    
    @ObservedObject var vm = FlagManager()
    
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
