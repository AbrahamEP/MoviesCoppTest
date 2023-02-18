//
//  UIViewController+Alert.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 17/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}
