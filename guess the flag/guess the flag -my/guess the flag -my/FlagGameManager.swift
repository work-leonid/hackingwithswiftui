//
//  FlagGameManager.swift
//  guess the flag -my
//
//  Created by Leonid Nazarov on 28.05.2021.
//

import Foundation

class FlagGameManager: ObservableObject {
    
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
