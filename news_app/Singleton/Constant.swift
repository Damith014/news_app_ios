//
//  Constant.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import Foundation
import UIKit

struct APPDELEGATECONSTANT {
    static var APPDELEGATE = (UIApplication.shared.delegate as? AppDelegate)
}

@available(iOS 13.0, *) struct SCENEDELEGATECONSTANT {
    static var SCENEDELEGATE = (UIApplication.shared.delegate as? SceneDelegate)
}

class Constant: NSObject {
    
    struct userDefaultKeys {
        static let kUserNameKey = "user_name"
        static let kUserEmailKey = "user_email"
        static let kUserPasswordKey = "user_password"
        static let kIsUserLoginKey = "is_user_login"
    }

    // MARK: API constants

    struct serverAPI {
        struct APIKeys {
            static let kRequestContentTypeJson = "application/json"
            static let KAPIKey = "d44ee9e5894d474a9573228aae0eb3e4"
        }

        struct requestMethods {
            static let kPostMethod = "POST"
            static let kGetMethod = "GET"
        }

        struct URL {
            static let baseAuthUrl = "https://\(AppDelegate.isDevelopment ? "newsapi.org/v2/" : "")"
            static let kGetTopHedline = baseAuthUrl + "top-headlines?country=%@&language=%@&apiKey="
            static let kGetTopUpdates = baseAuthUrl + "top-headlines?country=us&page=%@&apiKey="
            static let kSearch = baseAuthUrl + "everything?q=%@&apiKey="
            static let kCategory = baseAuthUrl + "top-headlines?category=%@&country=%@&language=%@&apiKey="
        }

        struct errorMessages {
            static let kInvalidName = "Please enter valid name"
            static let kInvalidEmail = "Please enter valid email"
            static let kInvalidPassword = "Please enter valid password"
            static let kIncorrectEmail = "Incorrect email"
            static let kIncorrectPassword = "Incorrect password"
            static let kNoInternetConnectionMessage = "Please connect the device with internet"
            static let kErrorDefaultTitle = "Uh Oh..."
            static let kNoInternetErrorTitle = "Network Error"
            static let kErrorDefaultMessage = "Something went wrong!\nPlease try again"
        }
    }
}
