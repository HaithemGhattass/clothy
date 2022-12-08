//
//  RoomRow.swift
//  clothy
//
//  Created by haithem ghattas on 6/12/2022.
//

import SwiftUI

struct RoomRow: View {
    @StateObject private var vm = UsersViewModel()
    @State var showchats = false
    var user : String
    
    var body: some View {
        HStack/*(alignment: .top, spacing: 16)*/ {
            AsyncImage(url: URL(string: vm.HOST_URL + "uploads/" +  vm.imageF)) { phase in
        if let image = phase.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 100, height: 100,alignment: .center)
             
        } else if phase.error != nil {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
               
               
              
            
           // Color.red // Indicates an error.
        } else {
           // Color.blue // Acts as a placeholder.
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
              
               
        }
            }
            
            VStack(alignment: .leading /*, spacing: 8*/) {
          
                Text(vm.firstname)
                    .fontWeight(.semibold)
                Text(vm.pseudo)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
            Text("date")
                .font(.system(size: 14 , weight: .light))
                .foregroundStyle(.secondary)
        }
        .onAppear{
            vm.getUserTrade(id: user)
          
        }
     
        
    }
}


struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        RoomRow(user: "1")
        
    }
}
