//
//  ProfileScreenVC.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

class ProfileScreenVC: UIViewController {
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    func setup() {
        self.label_name.text = Utility.getUserProperty(key: Constant.userDefaultKeys.kUserNameKey)
        self.label_email.text = Utility.getUserProperty(key: Constant.userDefaultKeys.kUserEmailKey)
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        Utility.setIsUserLogin(value: false)

        let loginScreenVC = LoginScreenVC(nibName: "LoginScreenVC", bundle: nil)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(loginScreenVC, animated: true)
    }
}
