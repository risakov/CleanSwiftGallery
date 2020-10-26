//
//  EditProfileViewController.swift
//  CleanSwiftGallery
//
//  Created by Роман on 13.07.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var presenter: EditProfilePresenter!

    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var passwordRepetition: UITextField!
    
    var user: UserEntity?
    var settings: Settings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            EditProfileConfigurator().configure(view: self)
        }
        setupTextFields()
        setupDelegatesForTextFields()
        setupRightItem()
        setupLeftItem()
    }
    
    func setupDelegatesForTextFields() {
        fullname.delegate = self
        birthday.delegate = self
        email.delegate = self
        password.delegate = self
        newPassword.delegate = self
        passwordRepetition.delegate = self
    }
    
    func setupRightItem() {
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(R.image.save(), for: .normal)
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightButton.addTarget(self, action: #selector(EditProfileViewController.save), for: .touchUpInside)
        let item = UIBarButtonItem(customView: rightButton)
        self.navigationItem.setRightBarButtonItems([item], animated: true)
    }
    
    func setupLeftItem() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black;
    }
    
    @objc func save() {
        self.presenter.saveNewPassword(self.password.text,
                                       self.newPassword.text,
                                       self.passwordRepetition.text,
                                       completionHandler: self.presenter.saveMainInfo(self.email.text,
                                                                       self.fullname.text,
                                                                       self.birthday.text))
    }
    
    func setupTextFields() {
        self.settings = self.presenter.getSettings()
        self.fullname.text = self.settings?.account?.fullName
        if let birthday = self.settings?.account?.birthday {
            self.birthday.text = Date.convertToStringInCurrentFormat(rawDate: birthday)
        }
        self.email.text = self.settings?.account?.email
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        self.presenter.logOut()
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
}
extension EditProfileViewController: EditProfileView {
    
}
