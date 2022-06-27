//
//  SceneDelegate.swift
//  news_app
//
//  Created by Damith Laksitha on 2022-06-25.
//

import UIKit

@available(iOS 13.0, *) class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var tabBarController = UITabBarController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
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
            let loginScreen = UINavigationController(rootViewController: LoginScreenVC(nibName: "LoginScreenVC", bundle: nil) as LoginScreenVC)
            loginScreen.isNavigationBarHidden = true
            self.window?.rootViewController = loginScreen
            self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
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
