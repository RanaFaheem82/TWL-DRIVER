//
//  SceneDelegate.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
         self.setupInitialController(session, options: connectionOptions)
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    @available(iOS 13.0, *)
    fileprivate func setupInitialController(_ session:UISceneSession, options:UIScene.ConnectionOptions) {
      if window == nil {
        let windowScene = UIWindowScene(session: session, connectionOptions: options)
        window = UIWindow(windowScene: windowScene)
      }
       let isLogin = UserDefaultsManager.shared.isUserLoggedIn
             Global.shared.isLogedIn = isLogin
             var vc: UIViewController!
             
             if(isLogin){
                 Global.shared.user = UserDefaultsManager.shared.loggedInUserInfo!
                 let storyBoard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
                 vc = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.KYDrawerController) as! KYDrawerController
             }else {
                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            vc = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
             }
             let navigationController = BaseNavigationController(rootViewController: vc)
            navigationController.navigationBar.isHidden = true
             window?.rootViewController = navigationController
             window?.makeKeyAndVisible()
    }
}

