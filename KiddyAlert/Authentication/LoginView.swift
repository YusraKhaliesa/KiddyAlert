//
//  LoginView.swift
//  KiddyAlert
//
//  Created by user on 27/12/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel : AuthViewModel
     
    var body: some View {
        NavigationStack {
            VStack {
                //image
                Image("Sc1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 120)
                    .padding(.vertical, 30)
                
                
                // form fields
                VStack(spacing: 20) {
                    InputFieldView(text: $email,
                                   title: "Email Address",
                                   placeholder:"name@example.com")
                    .textInputAutocapitalization(.never)
                    
                    InputFieldView(text: $password,
                                   title: "Passsword",
                                   placeholder: "Enter your password",
                                   isSecureField: true)
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button
                Button(action: {
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                }) {
                    Text("Sign In")
                        .fontWeight(.heavy)
                        .font(.title3)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .cornerRadius(10)
                }
                .padding(.top,24)
                
                Spacer()
                
                //sign up button
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

//MARK: - 


extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
#Preview {
    LoginView()
}
