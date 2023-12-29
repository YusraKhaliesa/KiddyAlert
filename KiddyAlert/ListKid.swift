//
//  ListKid.swift
//  KiddyAlert
//
//  Created by user on 05/12/2023.
//

import SwiftUI
import SwiftData


@available(iOS 17.0, *)
struct ListKid: View {
    
  
    let kiddetails: [KidDetail]
    
    @Environment(\.modelContext) private var context
    
    private func deleteKid(indexSet: IndexSet) {
        indexSet.forEach { index in
            let kiddetail = kiddetails[index]
            context.delete(kiddetail)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    var body: some View {
        List{
            ForEach(kiddetails, id: \.id) { kiddetail in
                NavigationLink(value: kiddetail) {
                    HStack {
                               if kiddetail.gender == 0 {
                                   Image("boy") // Display boy image
                                       .resizable()
                                       .frame(width: 40,height: 40)
                               } else {
                                   Image("girl") // Display girl image
                                       .resizable()
                                       .frame(width: 40,height: 40)
                               }
                            
                        VStack(alignment: .leading) {
                            Text(kiddetail.name)
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                            Text(kiddetail.scName)
                                .font(.system(size: 12, weight: .heavy, design: .default))
                                .foregroundStyle(Color.color)
                        }.padding([.horizontal,.trailing] ,20)
                    }
                }
            }.onDelete(perform: deleteKid)
                .listStyle(.plain)
                .listRowBackground(Color.gray.opacity(0.1))
//                    .listRowInsets(.init(top: 10,
//                                         leading: 10,
//                                         bottom: 10,
//                                         trailing: 10))
                    .listRowSeparatorTint(Color.gray)
            }
        .navigationDestination(for: KidDetail.self) { kiddetail in
            UpdateKidDetail(kiddetail: kiddetail)
                .navigationTitle(kiddetail.name)
        }
    }
}




