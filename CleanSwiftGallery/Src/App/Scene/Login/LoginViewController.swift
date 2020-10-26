//
//  LoginViewController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 01.07.2020.
//  Copyright (c) 2020 Роман. All rights reserved.
//


import UIKit
import MaterialTextField

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenter!
    
    

    @IBOutlet weak var usernameTextField: MFTextField! {
        didSet {
            usernameTextField.delegate = self
        }
    }

    @IBOutlet weak var passwordTextField: MFTextField! {
        didSet {
            passwordTextField.delegate = self

        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        if let login = usernameTextField.text, let password = self.passwordTextField.text {
            print(login)
            print(password)
            presenter.login(login, password)
        }
    }
    override func viewDidLoad() {
        self.navigationController!.navigationBar.isHidden = true
        super.viewDidLoad()
        self.setFonts()
        if presenter == nil {
            LoginConfigurator().configure(view: self)
        }
    }
    
    func setFonts() {
        let font = UIFont.init(name: "Roboto", size: 17)
        usernameTextField.font = font
        passwordTextField.font = font
    }
}

extension LoginViewController: LoginView {
    
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
            case usernameTextField:
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                textField.resignFirstResponder()
            default:
                textField.resignFirstResponder()
        }
        return true
    }
}
