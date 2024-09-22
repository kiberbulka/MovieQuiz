//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Olya on 17.09.2024.
//

import Foundation

struct GameResult:Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetterThan(_ another: GameResult)->Bool{
        correct > another.correct
    }
}
