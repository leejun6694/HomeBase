//
//  MyNotification.swift
//  HomeBase
//
//  Created by yangpc on 2017. 8. 26..
//  Copyright © 2017년 LemonKooma. All rights reserved.
//

import Foundation
import UserNotifications

class MyNotification: NSObject {

    static let center = UNUserNotificationCenter.current()
    
    static func add(
        contentOfBody: String,
        appliedDate: Date,
        day: Bool,
        hour: Bool,
        identifierID: Int64) {
        
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default()
        let calendar = Calendar(identifier: .gregorian)
        if hour {
            content.body = String.localizedStringWithFormat(.oneHourBefore, contentOfBody)
            let alarmDay = calendar.date(byAdding: .hour, value: -1, to: appliedDate)
            let alarmDayComponent = calendar.dateComponents([.year, .month, .day, .hour,.minute], from: alarmDay!)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: alarmDayComponent,
                repeats: false)
            let identifier = "\(identifierID)matchHour"
            print("identifier: "+identifier)
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content,
                                                trigger: trigger)
            MyNotification.center.add(request,
                                      withCompletionHandler: {(error) in
                                        if let error = error {
                                            // Something went wrong
                                            print(error)
                                        }
            })

        }
        
        if day {
            content.body = String.localizedStringWithFormat(.oneDayBefore, contentOfBody)
            let alarmDay = calendar.date(byAdding: .day, value: -1, to: appliedDate)
            let alarmDayComponent = calendar.dateComponents([.year, .month, .day, .hour,.minute], from: alarmDay!)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: alarmDayComponent,
                repeats: false)
            let identifier = "\(identifierID)matchDay"
            print("identifier: "+identifier)
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content,
                                                trigger: trigger)
            MyNotification.center.add(request,
                                      withCompletionHandler: {(error) in
                                        if let error = error {
                                            // Something went wrong
                                            print(error)
                                        }
            })

        }
    }
    
    static func remove(identifierID: Int64) {
        MyNotification.center.getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == "\(identifierID)matchDay"
                || notification.identifier == "\(identifierID)matchHour"{
                    print("Remove: \(identifierID)")
                    identifiers.append(notification.identifier)
                }
            }
            MyNotification.center.removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    static func update(
        contentOfBody: String,
        appliedDate: Date,
        day: Bool,
        hour: Bool,
        identifierID: Int64) {
        MyNotification.center.getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == "\(identifierID)matchDay"
                    || notification.identifier == "\(identifierID)matchHour"{
                    print("Remove: \(identifierID)")
                    identifiers.append(notification.identifier)
                }
            }
            MyNotification.center.removePendingNotificationRequests(withIdentifiers: identifiers)
            MyNotification.add(
                contentOfBody: contentOfBody,
                appliedDate: appliedDate,
                day: day,
                hour: hour,
                identifierID: identifierID)
        }
    }
}
