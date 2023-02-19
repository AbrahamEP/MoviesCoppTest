//
//  LoginViewController.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 11/02/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView: LoginView! = LoginView()
    let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLoginView()
    }
    
    private func setupLoginView() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.delegate = self
        self.view.addSubview(loginView)
        
        loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: LoginViewDelegate {
    func didPressedLogin(_ view: LoginView) {
        
        self.apiService.login(with: self.loginView.usernameTextField.text ?? "", password: self.loginView.passwordTextField.text ?? "") { access in
            switch access {
            case .granted:
                
                UserDefaults.setLoginStatus(true)
                let mainVC = MainViewController()
                let navVC = UINavigationController(rootViewController: mainVC)
                navVC.navigationBar.prefersLargeTitles = true
                
                if let window = self.view.window {
                    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                        window.rootViewController = navVC
                    }, completion: nil)
                }
            case .rejected:
                self.loginView.errorMessageLabel.text = "Acceso negado"
            }
        }
    }
}
