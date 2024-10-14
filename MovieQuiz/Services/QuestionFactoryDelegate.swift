//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Olya on 15.09.2024.
//

import Foundation

protocol QuestionFactoryDelegate:AnyObject{
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error) 
}
