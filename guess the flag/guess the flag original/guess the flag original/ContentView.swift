//
//  ContentView.swift
//  guess the flag original
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Your score: \(userScore)")
                        .font(.callout)
                        
                }
                .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button(action: {
                            selectCountry(number)
                        }, label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                                .shadow(color: Color.black, radius: 2)
                        })
                    }
                }
                .alert(isPresented: $showingScore) {
                    Alert(title: Text("\(scoreTitle)"), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("ok")) {
                        askQuestion()
                    })
                }
                Spacer()
            }
        }
    }
    
    func selectCountry(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
