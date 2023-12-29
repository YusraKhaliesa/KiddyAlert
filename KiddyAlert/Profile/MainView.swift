//
//  MainView.swift
//  KiddyAlert
//
//  Created by user on 27/12/2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @State private var path = [KidDetail]()
    @State private var isPresented: Bool = false
    @State private var isDeleteModeActive: Bool = false // Track delete mode
    @Query(sort: \KidDetail.name) var kiddetails: [KidDetail]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack{
                    VStack (alignment: .leading , spacing: 4){
                        Text("Hello, Parent!")
                            .foregroundStyle(Color.color)
                            .bold()
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment:.leading)
                            .padding([.top, .leading], 15)
                        Spacer(minLength: 5)
                        InfoView()
                            .padding([.top, .leading], 15)
                        
                        VStack (alignment: .leading , spacing: 5, content: {
//
                        })
                        .frame(maxWidth: .infinity, alignment:.leading)
                        .padding([.top, .leading], 15)

                        Spacer(minLength: 0)
                        
                        if kiddetails.isEmpty {
                            VStack(alignment:.center){
                              
                                emptyTransactionsView
                                    .padding([.leading,.bottom], 75 )
                            }
                            
                        } else {
                            VStack(alignment: .leading, spacing: -20){
                                
                                    Text("Your Kids List")
                                        .bold()
                                        .foregroundStyle(Color.color)
                                        .font(.system(size: 18, weight: .semibold, design: .rounded)).padding(.leading,15)
                                
                                  
                                ListKid(kiddetails: kiddetails)
                                Spacer(minLength: 0)
                            }
                          
                        }
                        
                    }
                
                            .overlay(alignment: .bottomTrailing) {
                                FloatingActionButton(action: {
                                    isPresented = true // Show the AddNew sheet
                                })
                                .padding()
                                .frame(maxHeight: .infinity, alignment: .bottom)
                            }
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button {
                             
                                    } label: {
                                        Image(systemName: "info.circle.fill")
                                    }

                                }
                            }
                        .toolbarBackground(.hidden, for: .navigationBar)
                }
                
                .scrollContentBackground(.hidden)
            }
        }
        .sheet(isPresented: $isPresented) {
            AddNew()
            
            
        }
        
    }
    
    
    
    struct FloatingActionButton: View {
        var action: () -> Void // Action to be performed on button tap
        
        var body: some View {
            Button(action: {
                action() // Perform the specified action
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.blue)
            .clipShape(Circle())
            .shadow(radius: 5)
        }
    }
    
}

var emptyTransactionsView: some View {
    VStack(alignment: .center) {
    
        Image ("kid1")
        Text("No Kids Detail")
            .font(.headline)
        Text("Click \(Image("add1")) to add your kids detail now!")
            .font(.subheadline)
            .foregroundColor(.gray)
            
        Spacer()
    }
    
}



#Preview {
    MainView()
}
