//
//  UpdateKidDetail.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct UpdateKidDetail: View {
    
    @State private var name: String = ""
    @State private var scName: String = ""
    @State private var doTime: Date = Date.now
    @State private var pTime: Date = Date.now
    @State private var gender: Int = Int()
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let kiddetail: KidDetail
    
    var body: some View {
        Form {
            Section {
                TextField("Kid's Name", text: $name)
                TextField("School Name", text: $scName)
                Picker("Gender", selection: $gender) {
                    Image("boy").tag(0)
                    Image("girl").tag(1) }
                .imageScale(.small)
                .pickerStyle(SegmentedPickerStyle())
                DatePicker("Drop Off Time", selection: $doTime, displayedComponents: .hourAndMinute)
                    .fontWeight(.bold)
                DatePicker("Pick Up Time", selection: $pTime, displayedComponents: .hourAndMinute)
                    .fontWeight(.bold)
            }
            
            Section{
                Button("UPDATE") {
                    kiddetail.name = name
                    kiddetail.scName = scName
                    kiddetail.gender = gender// Use selectedGender
                    kiddetail.doTime = doTime
                    kiddetail.pTime = pTime
                    scheduleNotifications()
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .foregroundColor(.color)
            .listRowBackground(getListBackgroundColor())
            .bold()
        }
        .onAppear {
            name = kiddetail.name
            scName = kiddetail.scName
            gender = kiddetail.gender
            doTime = kiddetail.doTime
            pTime = kiddetail.pTime
            
        }
    }
    
    
    
    func getListBackgroundColor() -> Color {
        return gender == 0 ? Color.boyblue  : Color.girlpink
    }
    
    
    
    func scheduleNotifications(){
        
        
        let notificationCenter = UNUserNotificationCenter.current()
        let hour = 21 // 9 PM in 24-hour format
        let minute = 0
        
        
        // Notification for 15 minutes after Drop Off Time
        scheduleNotification1(for: doTime, withTimeInterval: 900, notificationCenter: notificationCenter, identifier: "DropOffNotification1")
        
        // Notification for 30 minutes after Drop Off Time
        scheduleNotification1(for: doTime, withTimeInterval: 3600, notificationCenter: notificationCenter, identifier: "DropOffNotification2")
        
        // Notification for 15 minutes after Pick Up Time
        scheduleNotification(for: pTime, withTimeInterval: 900, notificationCenter: notificationCenter, identifier: "PickUpNotification")
        
        // Notification every night for parent
        scheduleDailyNotification(at: hour, minute: minute, notificationCenter: notificationCenter, identifier: "YourNotificationIdentifier")
        
        
    }
    
    
    func scheduleDailyNotification(at hour: Int, minute: Int, notificationCenter: UNUserNotificationCenter, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Hello Parent,did you check your kids detail for tomorrow?"
        
        if let soundURL = Bundle.main.url(forResource: "level", withExtension: "mp3") {
            let sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundURL.absoluteString))
            content.sound = sound
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    
    func scheduleNotification1(for date: Date, withTimeInterval timeInterval: TimeInterval, notificationCenter: UNUserNotificationCenter, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Did you drop off \(name) at \(scName)?"
        content.badge = 0
        
        if let soundURL = Bundle.main.url(forResource: "level", withExtension: "mp3") {
            let sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: soundURL.absoluteString))
            content.sound = sound
        }
        let triggerDate = date.addingTimeInterval(timeInterval)
        let components = Calendar.current.dateComponents([.hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func scheduleNotification(for date: Date, withTimeInterval timeInterval: TimeInterval, notificationCenter: UNUserNotificationCenter, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Did you pickup \(name) at \(scName)"
        content.badge = 0
        
        
        if let soundURL = Bundle.main.url(forResource: "level", withExtension: "mp3") {
            let sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: soundURL.absoluteString))
            content.sound = sound
        }
        let triggerDate = date.addingTimeInterval(timeInterval)
        let components = Calendar.current.dateComponents([.hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}







