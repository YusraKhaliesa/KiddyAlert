//
//  InfoView.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//

import SwiftUI

struct InfoView: View {
 
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ForEach(1..<4) { i in
                        cardView(img: "img\(i)")
                    }
                }
                .scrollTargetBehavior(.viewAligned)
            }
            
            
        }
    }

#Preview(body: {
    InfoView()
})

struct cardView : View {
    
    var img = ""
    var body : some View {
        
            Image(img)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
        
        
        .frame(width: 350)
        
        
    }
}


#Preview {
    InfoView()
}
