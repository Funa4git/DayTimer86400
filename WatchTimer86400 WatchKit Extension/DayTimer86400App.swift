//
//  DayTimer86400App.swift
//  WatchTimer86400 WatchKit Extension
//  
//  Created by Funa on 2022/05/04
//  
//

import SwiftUI

@main
struct DayTimer86400App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
