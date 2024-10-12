//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Olya on 12.10.2024.
//

import Foundation
import UIKit
final class MovieQuizPresenter{
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?
    let questionsAmount:Int = 10
    var currentQuestionIndex: Int = 0
    var correctAnswers:Int = 0
    var questionFactory: QuestionFactoryProtocol?
    
    
    
    
    
    
    
    func yesButtonClocked() {
        didAnswer(isYes:true)
    }
    func noButtonClicked() {
        didAnswer(isYes:false)
    }
    private func didAnswer(isYes:Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        let givenAnswer = isYes
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    func isLastQuestion()->Bool{
        currentQuestionIndex == questionsAmount - 1
    }
    func resetQuestionIndex(){
        currentQuestionIndex = 0
    }
    func switchToNextQuestion(){
        currentQuestionIndex += 1
    }
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    func showNextQuestionOrResults() {
        if self.isLastQuestion() {
            let currentDate = Date()
            let gameResult = GameResult(correct: correctAnswers,
                                        total: questionsAmount,
                                        date: currentDate)
            
            viewController?.statisticService.store(gameResult)
            guard let gamesCount = viewController?.statisticService.gamesCount,
                  let bestGame = viewController?.statisticService.bestGame,
                  let totalAccuracy = viewController?.statisticService.totalAccuracy else {return}
            
            let bestGameDate = bestGame.date.dateTimeString
            
            let message: [String] = [
            "Ваш результат: \(correctAnswers)",
            "Количество сыгранных квизов: \(gamesCount)",
            "Рекорд: \(bestGame.correct)/10 (\(bestGameDate))",
            "Средняя точность: \("\(String(format: "%.2f", totalAccuracy))%")"
            ]
            
            let text = message.joined(separator: "\n")
            
            let alertModel = QuizResultsViewModel(title: "Этот раунд закончен!",
                                                  text: text,
                                                  buttonText: "Сыграть еще раз")
            self.viewController?.show(quiz:alertModel)
        } else {
            self.switchToNextQuestion()
            viewController?.questionFactory?.requestNextQuestion()
        }
    }
}
