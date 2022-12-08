//
//  SearchView.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//


import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var showCourse = false
    @State var selectedCloset = closets[0]
    @Namespace var namespace
    
    var body: some View {
        NavigationView {
            VStack {
                content
                Spacer()
            }
        }
        .searchable(text: $text) {
            ForEach(suggestions) { sugg in
                Button {
                    text = sugg.text
                } label: {
                    Text(sugg.text)
                }
                .searchCompletion(sugg.text)
            }
        }
    }
    
    var content: some View {
        VStack {
            ForEach(Array(results.enumerated()), id: \.offset) { index, closet in
                if index != 0 { Divider() }
                Button {
                    showCourse = true
                    selectedCloset = closet
                } label:  {
                    ListRow(title: closet.title, icon: "magnifyingglass")
                }
                .buttonStyle(.plain)
            }
            
            if results.isEmpty {
                Text("No results found")
            }
        }
        .padding(20)
       .background(.ultraThinMaterial)
       //.backgroundStyle(cornerRadius: 30)
        .padding(20)
        .navigationTitle("Search")
        .background(
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 200)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: -200)
                .blur(radius: 20)
        )
        .background(
            Image("Blob 1").offset(x: -100, y: -200)
                .accessibility(hidden: true)
        )
        .sheet(isPresented: $showCourse) {
          //  CourseView(namespace: namespace, course: $selectedCourse, isAnimated: false)
        }
    }
    
    var results: [Closet] {
        if text.isEmpty {
            return closets
        } else {
            return closets.filter { $0.title.contains(text) }
        }
    }
    
    var suggestions: [Suggestion] {
        if text.isEmpty {
            return suggestionsData
        } else {
            return suggestionsData.filter { $0.text.contains(text) }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
    
struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestionsData = [
    Suggestion(text: "Outwears"),
    Suggestion(text: "T-shirts"),
    Suggestion(text: "Hats"),
    Suggestion(text: "Jeans")
]
