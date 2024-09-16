//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Olya on 15.09.2024.
//

import Foundation
import UIKit

class AlertPresenter: AlertPresenterProtocol {
    
    
    weak var delegate:  AlertPresenterDelegate?
    func setup(delegate: AlertPresenterDelegate){
        self.delegate = delegate
    }
    private var viewController = UIViewController()
    func presentAlert(quiz result:AlertModel) {
        let alert = UIAlertController(title: result.title, message: result.message, preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) {
            [weak self] _ in
            guard let self = self else {return}
            alert.addAction(action)
            self.viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}

