//
//  AppDelegate.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    static let isDevelopment: Bool = true

    var window: UIWindow?
    var tabBarController = UITabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UINavigationController(rootViewController: SplashScreenVC(nibName: "SplashScreenVC", bundle: nil) as SplashScreenVC)
        self.window?.makeKeyAndVisible()

        if Utility.getIsUserLogin() {
            let tab_vc = self.setuphomeview()
            var main_nav = UINavigationController()
            main_nav = UINavigationController(rootViewController: self.tabBarController)
            main_nav.isNavigationBarHidden = true

            self.window?.rootViewController = tab_vc
            self.window?.makeKeyAndVisible()
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: LoginScreenVC(nibName: "LoginScreenVC", bundle: nil) as LoginScreenVC)
            self.window?.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *) func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *) func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    func setuphomeview() -> UITabBarController {
        var controllers: [UIViewController] = []

        // Crate VC
        let homeVC = UINavigationController(rootViewController: HomeScreenVC(nibName: "HomeScreenVC", bundle: nil))
        let profileVC = UINavigationController(rootViewController: ProfileScreenVC(nibName: "ProfileScreenVC", bundle: nil))

        homeVC.isNavigationBarHidden = true
        profileVC.isNavigationBarHidden = true

        controllers.append(homeVC)
        controllers.append(profileVC)

        let item1 = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)

        homeVC.tabBarItem = item1
        profileVC.tabBarItem = item2

        UITabBar.appearance().tintColor = UIColor(red: 255 / 255.0, green: 58 / 255.0, blue: 68 / 255.0, alpha: 1)

        self.tabBarController.viewControllers = controllers
        return self.tabBarController
    }
}
