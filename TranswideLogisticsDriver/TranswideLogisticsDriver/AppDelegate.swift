//
//  AppDelegate.swift
//  TranswideLogisticsDriver
//
//  Created by apple on 4/29/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Firebase
import Messages
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate {

      var window: UIWindow?
     let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 10.0, *) {
                    // For iOS 10 display notification (sent via APNS)
                    UNUserNotificationCenter.current().delegate = self
                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                      options: authOptions,
                      completionHandler: {_, _ in })
                  } else {
                    let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                    application.registerUserNotificationSettings(settings)
                  }
    FirebaseApp.configure()
        application.registerForRemoteNotifications()
               Messaging.messaging().delegate = self
        GMSServices.provideAPIKey(APIKeys.googleApiKey)
               GMSPlacesClient.provideAPIKey(APIKeys.googleApiKey)
         IQKeyboardManager.shared.enable = true
        self.setInitialViewController()
       self.getToken()
        // Override point for customization after application launch.
        return true
    }
    
    func setInitialViewController()  {
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

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created. // Called when a new scene session is being created.
               // Use this method to select a configuration to create the new scene with.
               return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
              return Auth.auth().canHandle(url)
    }
    
    //MARK:- Methods For FCM
         func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
             print("Firebase registration token: \(fcmToken)")
            UserDefaults.standard.set(fcmToken, forKey: "token")
            UserDefaults.standard.synchronize()
             Global.shared.FCMToken = fcmToken
         }
         func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
             print("Token: \(fcmToken)")
            UserDefaults.standard.set(fcmToken, forKey: "token")
            UserDefaults.standard.synchronize()
             Global.shared.FCMToken = fcmToken
         }
         
         func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
             print(remoteMessage.appData)
         }
         func getToken() {
             if let token = UserDefaults.standard.value(forKey: "token") as? String{
                 Global.shared.FCMToken = token
             }
             InstanceID.instanceID().instanceID { (result, error) in
                 if let error = error {
                     print("Error fetching remote instange ID: \(error)")
                 } else if let result = result {
                     print("Remote instance ID token: \(result.token)")
                     Global.shared.FCMToken = result.token
                 }
             }
         }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
         // If you are receiving a notification message while your app is in the background,
         // this callback will not be fired till the user taps on the notification launching the application.
         // TODO: Handle data of notification

         // With swizzling disabled you must let Messaging know about the message, for Analytics
         // Messaging.messaging().appDidReceiveMessage(userInfo)

         // Print message ID.
         if let messageID = userInfo[gcmMessageIDKey] {
           print("Message ID: \(messageID)")
         }

         // Print full message.
         print(userInfo)
       }

       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         // If you are receiving a notification message while your app is in the background,
         // this callback will not be fired till the user taps on the notification launching the application.
         // TODO: Handle data of notification

         // With swizzling disabled you must let Messaging know about the message, for Analytics
         // Messaging.messaging().appDidReceiveMessage(userInfo)

         // Print message ID.
         if let messageID = userInfo[gcmMessageIDKey] {
           print("Message ID: \(messageID)")
         }

         // Print full message.
         print(userInfo)

         completionHandler(UIBackgroundFetchResult.newData)
       }


}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //open app
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
//    let notificationData = notification.request.content.userInfo
//               Global.shared.requestId = notificationData["gcm.notification.requestId"] as! String
//           
//               let mainController = self.getMainContainer()
//               if let controller = mainController as? MainContainerViewController {
//                   controller.showNearbyRequestController()
//                  
//               }else {
//                  
//               }
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([.alert, .sound, .badge])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
            let notificationData = response.notification.request.content.userInfo
            Global.shared.requestId = notificationData["gcm.notification.requestId"] as! String
        
            let mainController = self.getMainContainer()
            if let controller = mainController as? MainContainerViewController {
                controller.showNearbyRequestController()
               
            }else {
               
            }
   
    //background app open
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    completionHandler()
  }
    
    
    func getMainContainer() -> UIViewController? {
        var top = UIApplication.shared.keyWindow!.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            }else if let ky = top as? KYDrawerController {
                top = (ky.mainViewController as! UINavigationController).topViewController as! MainContainerViewController
                break
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            }else {
                break
            }
        }
        return top
    }
}



