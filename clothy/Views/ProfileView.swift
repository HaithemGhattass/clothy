//
//  ProfileView.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 8/11/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Profile")
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                   
                    
                }
                .padding(20)
                .padding(.bottom, 10)
            }
            
            Text("Need some conents here")
                .customFont(.title3)
                .padding(.horizontal, 20)
            
            VStack(spacing: 20) {
              
            }
            .padding(20)
        }
    }
}

struct ProfileViewPreviews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
