//
//  CustomClasses.swift
//  Multi Calc 2.0
//
//  Created by Jerrod on 3/21/18.
//  Copyright © 2018 Jerrod Sunderland. All rights reserved.
//

import UIKit

// class for event for each athlete
class Event {
    var name: String
    var eventType: String
    var events: [String]
    var marks: [[String]]
    var scores: [String]
    
    init(name: String, eventType: String, events: [String], marks: [[String]], scores: [String]) {
        self.name = name
        self.eventType = eventType
        self.events = events
        self.marks = marks
        self.scores = scores
    }
    
    // save all events for athlete to NSUserDefaults
    func saveEvents(AID: Int, id: Int) {
        let userSettings = UserDefaults.standard
        userSettings.set(id, forKey: "\(AID)\(id)")
        userSettings.set(name, forKey: "\(AID)eventName\(id)")
        userSettings.set(eventType, forKey: "\(AID)eventType\(id)")
        var num = 1
        if eventType.contains("Dec") {
            num = 10
        }else if eventType.contains("Pen") {
            num = 5
        }else if eventType.contains("Hep") {
            num = 7
        }
        if !marks.isEmpty {
            for i in 0...num - 1 {
                userSettings.set(marks[i][0], forKey: "\(AID)\(i)0marks\(id)")
                userSettings.set(marks[i][1], forKey: "\(AID)\(i)1marks\(id)")
                userSettings.set(marks[i][2], forKey: "\(AID)\(i)2marks\(id)")
            }
        }
        if !scores.isEmpty {
            for i in 0...num - 1 {
                userSettings.set(scores[i], forKey: "\(AID)\(i)scores\(id)")
            }
        }
    }
    // delete all events for athlete to NSUserDefaults
    func deleteEvents(AID: Int, id: Int) {
        let userSettings = UserDefaults.standard
        userSettings.removeObject(forKey: "\(AID)\(id)")
        userSettings.removeObject(forKey: "\(AID)eventName\(id)")
        userSettings.removeObject(forKey: "\(AID)eventType\(id)")
        var num = 1
        if eventType.contains("Dec") {
            num = 10
        }else if eventType.contains("Pen") {
            num = 5
        }else if eventType.contains("Hep") {
            num = 7
        }
        if !marks.isEmpty {
            for i in 0...num - 1 {
                userSettings.removeObject(forKey: "\(AID)\(i)0marks\(id)")
                userSettings.removeObject(forKey: "\(AID)\(i)1marks\(id)")
                userSettings.removeObject(forKey: "\(AID)\(i)2marks\(id)")
            }
        }
        if !scores.isEmpty {
            for i in 0...num - 1 {
                userSettings.removeObject(forKey: "\(AID)\(i)scores\(id)")
            }
        }
    }
}
// class for each athlete
class Athlete {
    var name: String
    var events: [Event]
    
    init(name: String, events: [Event]) {
        self.name = name
        self.events = events
    }
    
    // save athlete and all events for athlete to NSUserDefaults
    func saveAthlete(id: Int) {
        let userSettings = UserDefaults.standard
        userSettings.set(id, forKey: "\(id)")
        userSettings.set(name, forKey: "athleteName\(id)")
        if events.count > 0 {
            userSettings.set(events.count - 1, forKey: "totAthleteEvents\(id)")
            // for all events save each one with specific id
            for i in 0...events.count - 1 {
                events[i].saveEvents(AID: id, id: i)
            }
        }
    }
    // remove athlete and all events for athlete to NSUserDefaults
    func deleteAthlete(id: Int) {
        let userSettings = UserDefaults.standard
        userSettings.removeObject(forKey: "\(id)")
        userSettings.removeObject(forKey: "athleteName\(id)")
        if events.count > 0 {
            userSettings.removeObject(forKey: "totAthleteEvents\(id)")
            // for all events save each one with specific id
            for i in 0...events.count - 1 {
                events[i].deleteEvents(AID: id, id: i)
            }
        }
    }
}
// extension to hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
