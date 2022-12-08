//
//  TitleRow.swift
//  clothy
//
//  Created by haithem ghattas on 4/12/2022.
//
import SwiftUI


struct TitleRow: View {
    var image : String
    var firstname : String
    var lastname : String
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8")
    var name = "Ghattas Haithem"
    @State var openclothes : Bool = false
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(firstname + " " + lastname)
                    .font(.title).bold()
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "tshirt.fill")
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(50)
                .onTapGesture {
                    openclothes.toggle()
                }
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow(image: "https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8", firstname: "haithem", lastname: "ghattas")
            .background(Color("background4"))
    }
}
