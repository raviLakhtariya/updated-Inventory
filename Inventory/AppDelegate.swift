//
//  AppDelegate.swift
//  Inventory
//
//  Created by Janki on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Photos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var reachability: Reachability?;
    var dialogForNetwork:CustomAlertDialog?;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         //   setupNetworkReachability()
    //    UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.init(red: 44/255.0, green: 80/255.0, blue: 137/255.0, alpha: 1.0)
        }
        Util.copyFile(fileName: "Inventory.db")
        checkPermission()
        return true
    }
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    
    func setupNetworkReachability()
    {
        self.reachability = Reachability.init();
        do
        {
            try self.reachability?.startNotifier()
        }
        catch
        {
            print(error)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        //    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(FRESHCHAT_UNREAD_MESSAGE_COUNT_CHANGED), object: nil)
        
    }
    
  /*  func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
*/
    func  openNetworkDialog ()
    {
        dialogForNetwork  = CustomAlertDialog.showCustomAlertDialog(title: "TXT_INTERNET"/*.localized*/, message: "MSG_INTERNET_ENABLE"/*.localized*/, titleLeftButton: "TXT_EXIT"/*.localized*/, titleRightButton: "TXT_OK"/*.localized*/)
        
        self.dialogForNetwork!.onClickLeftButton =
            {
                self.dialogForNetwork!.removeFromSuperview();
                exit(0)
        }
        self.dialogForNetwork!.onClickRightButton =
            {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl)
                {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            
                        })
                    } else
                    {
                        UIApplication.shared.openURL(settingsUrl)
                    }
                }
                self.dialogForNetwork?.removeFromSuperview();
        }
    }
    
    @objc func reachabilityChanged(note: NSNotification)
    {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable
        {
            if (APPDELEGATE.window?.viewWithTag(DialogTags.networkDialog)) != nil
            {
                dialogForNetwork?.removeFromSuperview()
            }
            if reachability.isReachableViaWiFi
            {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Network not reachable")
            openNetworkDialog()
            
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        let id = response.notification.request.identifier
        print("Received notification with ID = \(id)")
        
        completionHandler()
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        let id = notification.request.identifier
        print("Received notification with ID = \(id)")
        
        completionHandler([.sound, .alert])
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("Print entire notification message for preview:  \(notification)")
        
        let userInfoObject = notification.userInfo! as! [String : String]
        
        // Extract custom parameter value from notification message
        let customParameterValue = userInfoObject["customParameterKey_from"]! as String
        print("Message from sent by \(customParameterValue)")
        
        // Extract message alertBody
        let messageToDisplay = notification.alertBody
        
        // Display message alert body in a alert dialog window
        let alertController = UIAlertController(title: "Notification", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        // Present dialog window to user
        window?.rootViewController?.present(alertController, animated: true, completion:nil)
    }

}
/* 33 + 6:14
 6:47
extension AppDelegate: UNUserNotificationCenterDelegate
{
}
*/
