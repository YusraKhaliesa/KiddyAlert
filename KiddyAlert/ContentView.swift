//
//  ContentView.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//

//
//  ContentView.swift
//  KiddoAlert
//
//  Created by user on 10/11/2023.
//
import SwiftData
import SwiftUI

struct ContentView: View {
//        @State private var path = [KidDetail]()
//        @State private var isPresented: Bool = false
//        @State private var isDeleteModeActive: Bool = false // Track delete mode
//        @Query(sort: \KidDetail.name) var kiddetails: [KidDetail]
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        Group{
            if $viewModel.userSession != nil {
                MainView()
            } else {
                LoginView()
            }
        }
        
        
        
//        #Preview(body: {
//            ContentView()
//            
//        })
    }
}

