//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Olya on 15.09.2024.
//

import Foundation
import UIKit

class AlertPresenter {
    
    weak var delegate: AlertPresenterDelegate?
    
    init(delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
    
    func presentAlert(with model: AlertModel) {
        delegate?.presentAlert(with: model)
    }
}

