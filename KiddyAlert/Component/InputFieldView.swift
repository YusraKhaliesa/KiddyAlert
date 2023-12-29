//
//  InputFieldView.swift
//  KiddyAlert
//
//  Created by user on 27/12/2023.
//

import SwiftUI

struct InputFieldView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(title)
                .foregroundStyle(Color.gray)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
              TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}
            struct InputFieldView_Previews: PreviewProvider {
                static var previews: some View {
                    InputFieldView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
                }
                
            }
