//
//  SignInViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-09.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDecoration()
    }

    func initializeDecoration() {
        title = "登录"
        
        usernameTextField.borderStyle = UITextBorderStyle.RoundedRect
        let leftUsernameImageView = UIImageView()
        leftUsernameImageView.image = UIImage(named: "username-icon")
        let leftUsernameView = UIView()
        leftUsernameView.addSubview(leftUsernameImageView)
        leftUsernameView.frame = CGRectMake(0, 0, 35, 25)
        leftUsernameImageView.frame = CGRectMake(5, 0, 25, 25)
        usernameTextField.leftView = leftUsernameView
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        let leftPasswordImageView = UIImageView()
        leftPasswordImageView.image = UIImage(named: "password-icon")
        let leftPasswordView = UIView()
        leftPasswordView.addSubview(leftPasswordImageView)
        leftPasswordView.frame = CGRectMake(0, 0, 35, 25)
        leftPasswordImageView.frame = CGRectMake(5, 0, 25, 25)
        passwordTextField.leftView = leftPasswordView
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
        signInButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
    }

}
