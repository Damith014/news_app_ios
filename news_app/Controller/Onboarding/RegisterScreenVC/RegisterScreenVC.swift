//
//  RegisterScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

class RegisterScreenVC: UIViewController {
    // MARK: Internal

    @IBOutlet weak var label_login: UILabel!
    @IBOutlet weak var text_name: UITextField!
    @IBOutlet weak var text_email: UITextField!
    @IBOutlet weak var text_password: UITextField!
    @IBOutlet weak var button_register: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        self.text_name.delegate = self
        self.text_email.delegate = self
        self.text_password.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterScreenVC.tapLogin))
        self.label_login.isUserInteractionEnabled = true
        self.label_login.addGestureRecognizer(tap)
    }

    @objc func tapLogin(sender: UITapGestureRecognizer) {
        self.goToLogin()
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        if self.text_name.text!.count == 0 {
            Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidName, buttonTitle: "OK", onClickCallback: {
            })
        } else if !Utility.isValidEmail(self.text_email.text!) {
            Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidEmail, buttonTitle: "OK", onClickCallback: {
            })
        } else if self.text_password.text!.count < 6 {
            Utility.showInformativeAlertView(vc: self, "", message: Constant.serverAPI.errorMessages.kInvalidPassword, buttonTitle: "OK", onClickCallback: {
            })
        } else {
            Utility.setUserProperty(value: self.text_name.text!, key: Constant.userDefaultKeys.kUserNameKey)
            Utility.setUserProperty(value: self.text_email.text!, key: Constant.userDefaultKeys.kUserEmailKey)
            Utility.setUserProperty(value: self.text_password.text!, key: Constant.userDefaultKeys.kUserPasswordKey)
            self.goToLogin()
        }
    }

    // MARK: Private

    private func goToLogin() {
        let loginScreenVC = LoginScreenVC(nibName: "LoginScreenVC", bundle: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(loginScreenVC, animated: true)
    }
}

extension RegisterScreenVC: UITextViewDelegate, UITextFieldDelegate {
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
