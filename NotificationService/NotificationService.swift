//
//  NotificationService.swift
//  NotificationService
//
//  Created by Mitchell Flindell on 5/8/2024.
//

import UserNotifications
import OrttoPushMessagingAPNS

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        // 1. Pass UNNotificationRequest to Ortto
        let handled = PushMessaging.shared.didReceive(request, withContentHandler: contentHandler)
        
        // 2 Code to catch if not modified by Ortto
        if !handled {
            print("Handled!")
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
