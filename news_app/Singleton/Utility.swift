//
//  Utility.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-26.
//

import Foundation
import KVNProgress
import UIKit

class Utility {
    static func setUserProperty(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func getUserProperty(key: String) -> String {
        var value = String()

        if UserDefaults.standard.value(forKey: key) == nil {
            value = ""
        } else {
            value = UserDefaults.standard.value(forKey: key) as! String
        }
        return value
    }

    static func setIsUserLogin(value: Bool) {
        UserDefaults.standard.set(value, forKey: Constant.userDefaultKeys.kIsUserLoginKey)
        UserDefaults.standard.synchronize()
    }

    static func getIsUserLogin() -> Bool {
        var value = Bool()

        if UserDefaults.standard.bool(forKey: Constant.userDefaultKeys.kIsUserLoginKey) == nil {
            value = false
        } else {
            value = UserDefaults.standard.bool(forKey: Constant.userDefaultKeys.kIsUserLoginKey) as! Bool
        }
        return value
    }

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    static func removeAllUserDefaults() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: Constant.userDefaultKeys.kUserNameKey)
        defaults.removeObject(forKey: Constant.userDefaultKeys.kUserEmailKey)
        defaults.removeObject(forKey: Constant.userDefaultKeys.kUserPasswordKey)
        defaults.removeObject(forKey: Constant.userDefaultKeys.kIsUserLoginKey)
    }

    static func showInformativeAlertView(vc: UIViewController, _ title: String?, message: String?, buttonTitle: String, onClickCallback: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {
            _ in
            onClickCallback?()
        }))

        vc.present(alert, animated: true, completion: nil)
    }

    static func dateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: date)

        dateFormatter.dateFormat = "EEE, d MMM, yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: date!)
    }

    static func dateFormatSearch(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: date)

        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: date!)
    }
}
