//
//  Alert.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 29/09/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

enum AlertType {
    case networkError, noTweet, noCoordinates, requestLocation, noHashtag
}

struct Alert {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "Alert", message: "A very very bad thing happened.. network error 😱")
        case .noTweet:
            self = Alert(title: "Alert", message: """
No tweet found.. 😢
Try to make another request 👏
""")
        case .noCoordinates:
            self = Alert(title: "Alert", message: "Please give us your coordinates in your settings.. ☝️")
            
        case .requestLocation:
            self = Alert(title: "Alert", message: "Would you like to search tweets around you (50km)❓")
        case .noHashtag:
            self = Alert(title: "Alert", message: "Please enter a correct hashtag 🧐")
        }
    }
}
