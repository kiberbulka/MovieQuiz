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
    weak var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func presentAlert(with model: AlertModel?) {
        let alert = UIAlertController(
                    title: model?.title,
                    message: model?.message,
                    preferredStyle: .alert)
                
                let action = UIAlertAction(title: model?.buttonText, style: .default) {[weak self] _ in
                    model?.completion?()
                    self?.delegate?.presentAlert()
                }
                alert.addAction(action)
                viewController?.present(alert, animated: true, completion: nil)
            }
}


