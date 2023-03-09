//
//  SceneDelegate.swift
//  MyFirstApp
//
//  Created by Lefteris Kostakis on 7/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let sc = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: sc)
        //Initialize tabbarController
        let tabBarCtrl = UITabBarController()
//        tabBarCtrl.tabBar.tintColor = .red
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainView")
        mainVC.view.backgroundColor = .white
        let settingsVC = SettingsViewController()
        
        guard let mainVC = mainVC as? MainViewController else {
            fatalError("Could not instantiate main view controller.")
        }
        Settings.viewController = mainVC
        Settings.currentLevel = mainVC.selectedLevel.rawValue
        settingsVC.view.backgroundColor = .white
        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "znsNtvIconSettings"), tag: 1)
        
//        let settingsVC = SettingsViewController()
//        settingsVC.view.backgroundColor = .systemBlue
//        settingsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)), tag: 1)
//        let pokemonsVC = storyboard.instantiateViewController(withIdentifier: "pokemonVC")
//        let unselectedImage = UIImage(systemName: "plus",
//                                      withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))
//        let selectedImage = UIImage(systemName: "minus",
//                                    withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
//        let f1 = UITabBarItem(title: "pokemons", image: unselectedImage, selectedImage: selectedImage)
//        f1.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 20.0)
//        pokemonsVC.tabBarItem = f1
        
        // 2nd view controller on tab bar
//        let transactionVC = FirstViewController()
//        transactionVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)), tag: 1)
//
//        // 3rd view controller on tab bar
//        let summaryVC = UIViewController()
//        summaryVC.view.backgroundColor = .white
//        summaryVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.pie", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)), tag: 2)
//
//        // 3th view controller on tab bar
//        let fourthVC = UIViewController()
//        fourthVC.view.backgroundColor = .white
//        let image = UIImage(systemName: "crown",
//                            withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
//
//        fourthVC.tabBarItem = UITabBarItem(title: "4th VC", image: image, tag: 3)
        let navigationController = UINavigationController(rootViewController: mainVC)
        tabBarCtrl.setViewControllers([navigationController, settingsVC], animated: false)
        
        window?.rootViewController = tabBarCtrl
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

