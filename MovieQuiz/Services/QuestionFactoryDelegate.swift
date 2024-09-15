//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Olya on 15.09.2024.
//

import Foundation

protocol QuestionFactoryDelegate:AnyObject{
    func didRecieveNextQuestion(question: QuizQuestion?)
}
