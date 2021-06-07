//
//  AppDelegate+APNs.swift
//  App
//
//  Created by ChungTV on 07/06/2021.
//

import Foundation
import UserNotificationsUI
import UserNotifications
import Logger
import Firebase

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Log.d("[Notification]", "willPresent:", notification.request.content.userInfo.toJSON(beautify: true))
        
        let userInfo = notification.request.content.userInfo
        //        let id = notification.request.identifier
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound])
        } else {
            completionHandler([.alert, .sound])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        Log.d("[Notification]", "didReceive response:", userInfo.toJSON(beautify: true))
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            Log.d(userInfo)
            openNotification(userInfo)
        }
        
        completionHandler()
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(.noData)
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.map({ String(format: "%02x", $0) }).joined()
        self.deviceToken = token
        Log.d("deviceToken: \(token)")
    }
    
    // MARK: - MessagingDelegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        self.fcmToken = fcmToken
    }
    
    func registerForAPNs() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound],
                                                completionHandler: { [weak self] granted , error in
                                                    Log.d("[Notification]", "Permission granted: \(granted)")
                                                    guard granted else { return }
                                                    self?.getNotificationSettings()
                                                })
    }
    
    private func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        Log.d("[Notification]", "Settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    private func openNotification(_ notification: [AnyHashable: Any]?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: {
            
        })
    }
    
}
