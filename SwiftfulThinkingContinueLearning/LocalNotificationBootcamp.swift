//
//  LocalNotificationBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 20/07/2023.
//

import SwiftUI
import UserNotifications


class NotificationManager {
    
    static let instance = NotificationManager()//singleton
    
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: options) { (success, error) in
                if let error = error {
                    print("ERROR: \(error)")
                } else {
                    print("SUCCESS")
                }
                
            }
    }
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle="This was soo easy!"
        content.sound = .default
        content.badge = 1
        
        //time
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval:5.0,
        repeats: false)
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            .onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            
        }
        
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
