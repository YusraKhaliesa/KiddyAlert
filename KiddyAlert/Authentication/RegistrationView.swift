//
//  RegistrationView.swift
//  KiddyAlert
//
//  Created by user on 27/12/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            //image
            Image("Sc1")
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 120)
                .padding(.vertical, 30)
            
            VStack(spacing: 20) {
                InputFieldView(text: $email,
                               title: "Email Address",
                               placeholder:"name@example.com")
                .textInputAutocapitalization(.never)
                
                InputFieldView(text: $fullname,
                               title: "Full Name",
                               placeholder:"Enter your name")
                
                InputFieldView(text: $password,
                               title: "Passsword",
                               placeholder: "Enter your password",
                               isSecureField: true)
                
                ZStack(alignment: .trailing){
                    InputFieldView(text: $confirmpassword,
                                   title: "Confirm Passsword",
                                   placeholder: "Confirm your password",
                                   isSecureField: true)
                    
                    if !password.isEmpty && !confirmpassword.isEmpty {
                        if password == confirmpassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button(action: {
                Task{
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullname: fullname)
                }
            }) {
                Text("SIGN UP")
                    .fontWeight(.heavy)
                    .font(.title3)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
            
            .padding(.top,24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.system(size: 14))
            }
        }
    }
}

// MARK :- AunthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmpassword == password
        && !fullname.isEmpty
    }
}

#Preview {
    RegistrationView()
}
