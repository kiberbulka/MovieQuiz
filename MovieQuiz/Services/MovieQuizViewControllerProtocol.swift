//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Olya on 13.10.2024.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer:Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    func proceedWithAnswer(isCorrect:Bool)
}
