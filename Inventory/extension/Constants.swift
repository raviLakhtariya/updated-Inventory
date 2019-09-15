//
//  Constants.swift
//  Inventory
//
//  Created by Ravi on 08/07/19.
//  Copyright © 2019 gunatitsolutions. All rights reserved.
//

import Foundation
import UIKit


let  APPDELEGATE =  UIApplication.shared.delegate as! AppDelegate
let preferenceHelper = PreferenceHelper.preferenceHelper
let passwordLength = 6

struct DialogTags {
    static let networkDialog:Int = 400
}
struct DateFormat
{
    static let TIME_FORMAT_AM_PM = "hh:mm a"
    static let WEB   = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let DATE_TIME_FORMAT = "dd MMMM yyyy, HH:mm"
    static let HISTORY_TIME_FORMAT = "hh:mm a"
    static let DATE_FORMAT = "yyyy-MM-dd"
    static let DD_MM_YY = "dd-MM-yyyy"
    static let DATE_FORMAT_MONTH = "MMMM yyyy"
    static let DATE_MM_DD_YYYY = "MM/dd/yyyy"
    static let TIME_FORMAT_HH_MM = "HH:mm"
    static let DATE_TIME_FORMAT_AM_PM = "yyyy-MM-dd hh:mm a"
    static let SCHEDUALE_DATE_FORMATE = "EEEE d MMMM 'at' HH:mm"
    static let WEEK_FORMAT = "EEE, dd MMMM"
    static let DD_MMM_YY = "dd MMM yy"
    static let EARNING = "MMM dd, YYYY"
}
/*struct Notification {
    var id:String
    var title:String
    var datetime:DateComponents
}
class LocalNotificationManager
{
    var notifications = [Notification]()
    
}
func listScheduledNotifications()
{
    UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
        
        for notification in notifications {
            print(notification)
        }
    }
}
private func requestAuthorization()
{
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        
        if granted == true && error == nil {
            self.scheduleNotifications()
        }
    }
}
 
 
 func schedule()
 {
 UNUserNotificationCenter.current().getNotificationSettings { settings in
 
 switch settings.authorizationStatus {
 case .notDetermined:
 self.requestAuthorization()
 case .authorized, .provisional:
 self.scheduleNotifications()
 default:
 break // Do nothing
 }
 }
 }
 
 
 private func scheduleNotifications()
 {
 for notification in notifications
 {
 let content      = UNMutableNotificationContent()
 content.title    = notification.title
 content.sound    = .default
 
 let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: false)
 
 let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
 
 UNUserNotificationCenter.current().add(request) { error in
 
 guard error == nil else { return }
 
 print("Notification scheduled! --- ID = \(notification.id)")
 }
 }
 }
 
 
 let manager = LocalNotificationManager()
 manager.notifications = [
 Notification(id: "reminder-1", title: "Remember the milk!", datetime: DateComponents(calendar: Calendar.current, year: 2019, month: 4, day: 22, hour: 17, minute: 0)),
 Notification(id: "reminder-2", title: "Ask Bob from accounting", datetime: DateComponents(calendar: Calendar.current, year: 2019, month: 4, day: 22, hour: 17, minute: 1)),
 Notification(id: "reminder-3", title: "Send postcard to mom", datetime: DateComponents(calendar: Calendar.current, year: 2019, month: 4, day: 22, hour: 17, minute: 2))
 ]
 
 manager.schedule()
 
 
 
 

 
 
*/
