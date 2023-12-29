//
//  AddNew.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//
//
//  LabelList.swift
//  KiddoAlert
//
//  Created by user on 10/11/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct AddNew: View {
    
    @State private var name = ""
    @State private var scName = ""
    @State private var doTime: Date = Date.now
    @State private var pTime: Date = Date.now
    @State private var gender = 0 // Default value for gender
    @State private var showingAlert = false
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Kid's Name", text: $name)
                        .disableAutocorrection(true)
                    TextField("School Name", text: $scName)
                        .autocorrectionDisabled()
                    
                    Picker("Gender", selection: $gender) {
                        Image("boy").tag(0)
                        Image("girl").tag(1)
                            .imageScale(.small)
                        
                    }
                    
                    .pickerStyle(SegmentedPickerStyle())
                    
                    DatePicker("Drop Off Time", selection: $doTime, displayedComponents: .hourAndMinute)
                        .fontWeight(.bold)
                    DatePicker("Pick Up Time", selection: $pTime, displayedComponents: .hourAndMinute)
                        .fontWeight(.bold)
                }header: {
                    Text("Kids Detail")
                }
                
                Section{
                    
                }
                
                Section{
                    Button("SAVE")
                    {
                        let kiddetail = KidDetail(name: name, scName: scName, doTime: doTime, pTime: pTime, gender: gender)
                        context.insert(kiddetail)
                        scheduleNotifications()
                        showingAlert = true
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                
                .disabled(name.isEmpty || scName.isEmpty)
                .alert("Great!", isPresented: $showingAlert) {
                    Button("OK") {
                        dismiss()
                    }
                } message: {
                    Text("You've saved \(name)'s details.")
                }
                .foregroundColor(.color)
                .listRowBackground(getListBackgroundColor())
                .bold()
                
                .navigationTitle("Add Kid's Detail")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
            }
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



#Preview {
    AddNew()
}
