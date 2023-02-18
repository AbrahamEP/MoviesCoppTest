//
//  LoginView.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 11/02/23.
//

import UIKit

protocol LoginViewDelegate {
    func didPressedLogin(_ view: LoginView)
}

class LoginView: UIView {

    let stackView: UIStackView! = {
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.contentMode = .scaleToFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let logoImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "TheMovieDB")
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return imageView
    }()
    
    let loginButton: UIButton! = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(loginButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    let usernameTextField: UITextField! = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "username"
        
        return textField
    }()
    let passwordTextField: UITextField! = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "password"
        
        return textField
    }()
    let errorMessageLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    @IBAction private func loginButtonAction() {
        
        delegate?.didPressedLogin(self)
    }
    
    private func setupViews() {
        self.setupStackView()
        
        usernameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        errorMessageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupStackView() {
        self.addSubview(self.stackView)
        
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let views = [
            logoImageView,
            usernameTextField,
            passwordTextField,
            loginButton,
            errorMessageLabel
        ]
        
        views.forEach {
            self.stackView.addArrangedSubview($0 ?? UIView())
        }
        
    }

}
