//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Olya on 16.09.2024.
//

import Foundation

protocol AlertPresenterDelegate: AnyObject {
    func showAlert(model: AlertModel?)
}
