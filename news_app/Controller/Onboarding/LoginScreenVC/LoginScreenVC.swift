//
//  LoginScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

class LoginScreenVC: UIViewController {
    @IBOutlet weak var label_register: UILabel!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_password: UITextField!
    @IBOutlet weak var button_login: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        self.text_email.delegate = self
        self.text_password.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginScreenVC.tapRegister))
        self.label_register.isUserInteractionEnabled = true
        self.label_register.addGestureRecognizer(tap)
    }

    @objc func tapRegister(sender: UITapGestureRecognizer) {
        let registerScreenVC = RegisterScreenVC(nibName: "RegisterScreenVC", bundle: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(registerScreenVC, animated: true)
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        if !Utility.isValidEmail(self.text_email.text!) {
            Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidEmail, buttonTitle: "OK", onClickCallback: {
            })
        } else if self.text_password.text!.count < 6 {
            Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidPassword, buttonTitle: "OK", onClickCallback: {
            })
        } else {
            let email = Utility.getUserProperty(key: Constant.userDefaultKeys.kUserEmailKey)
            let password = Utility.getUserProperty(key: Constant.userDefaultKeys.kUserPasswordKey)
            if email != self.text_email.text! {
                Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidEmail, buttonTitle: "OK", onClickCallback: {
                })
            } else if password != self.text_password.text! {
                Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidPassword, buttonTitle: "OK", onClickCallback: {
                })
            } else {
                Utility.setIsUserLogin(value: true)
                let vc = (APPDELEGATECONSTANT.APPDELEGATE?.setuphomeview())!
                self.navigationController?.pushViewController(vc, animated: true)
//                return self.tabBarController
            }
        }
    }
}

extension LoginScreenVC: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}
