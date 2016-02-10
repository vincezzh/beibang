//
//  RegisterStepOneViewController.swift
//  beibang
//
//  Created by Zhehan Zhang on 2016-02-09.
//  Copyright © 2016 Akhaltech. All rights reserved.
//

import UIKit

class RegisterStepOneViewController: UIViewController {

    @IBOutlet weak var cellphoneTextField: UITextField!
    @IBOutlet weak var validationCodeTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationCodeButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeDecoration()
    }

    func initializeDecoration() {
        title = "注册"
        
        cellphoneTextField.borderStyle = UITextBorderStyle.RoundedRect
        let leftCellphoneImageView = UIImageView()
        leftCellphoneImageView.image = UIImage(named: "avatar")
        let leftCellphoneView = UIView()
        leftCellphoneView.addSubview(leftCellphoneImageView)
        leftCellphoneView.frame = CGRectMake(0, 0, 35, 25)
        leftCellphoneImageView.frame = CGRectMake(5, 0, 25, 25)
        cellphoneTextField.leftView = leftCellphoneView
        cellphoneTextField.leftViewMode = UITextFieldViewMode.Always
        
        validationCodeTextField.borderStyle = UITextBorderStyle.RoundedRect
        let leftValidationCodeImageView = UIImageView()
        leftValidationCodeImageView.image = UIImage(named: "avatar")
        let leftValidationCodeView = UIView()
        leftValidationCodeView.addSubview(leftValidationCodeImageView)
        leftValidationCodeView.frame = CGRectMake(0, 0, 35, 25)
        leftValidationCodeImageView.frame = CGRectMake(5, 0, 25, 25)
        validationCodeTextField.leftView = leftValidationCodeView
        validationCodeTextField.leftViewMode = UITextFieldViewMode.Always
        
        usernameTextField.borderStyle = UITextBorderStyle.RoundedRect
        let leftUsernameImageView = UIImageView()
        leftUsernameImageView.image = UIImage(named: "avatar")
        let leftUsernameView = UIView()
        leftUsernameView.addSubview(leftUsernameImageView)
        leftUsernameView.frame = CGRectMake(0, 0, 35, 25)
        leftUsernameImageView.frame = CGRectMake(5, 0, 25, 25)
        usernameTextField.leftView = leftUsernameView
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        let leftPasswordImageView = UIImageView()
        leftPasswordImageView.image = UIImage(named: "avatar")
        let leftPasswordView = UIView()
        leftPasswordView.addSubview(leftPasswordImageView)
        leftPasswordView.frame = CGRectMake(0, 0, 35, 25)
        leftPasswordImageView.frame = CGRectMake(5, 0, 25, 25)
        passwordTextField.leftView = leftPasswordView
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        
        validationCodeButton.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
    }

}
