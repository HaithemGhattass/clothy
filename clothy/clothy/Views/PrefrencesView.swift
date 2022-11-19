//
//  PrefrencesView.swift
//  clothy
//
//  Created by haithem ghattas on 7/11/2022.
//

import SwiftUI

struct PrefrencesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private let columns: [GridItem] = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),  GridItem(.fixed(120))]

  
   @State var selected = false
    var PREFS = ["ROCK","POP","PUNK","IDK","yess","piww","paap","yeeaa","oyy"]
    
    func idk() {
        
        self.updateSelectedButtons(value: PREFS.firstIndex(of: "ROCK")! + 1)
           
        
    }
    
    func updateSelectedButtons(value: Int)
       {
         //  if self.buttonList.contains(where: {$0.self.})
           if self.buttonList.contains(where: { $0.buttonIndex == value } )
           {
               self.buttonList.remove(at: self.buttonList.firstIndex(where: {$0.buttonIndex == value})!)
               self.count -= 1
           }
           else
           {
               if(self.count != 3 ){
                   print(self.colorIndex)
                   self.buttonList.append(ColorButton(color: colors[self.colorIndex].value, buttonIndex: value))
                   self.count += 1
                   self.colorIndex += 1
                   if self.colorIndex >= 1
                   {
                       self.colorIndex = 0
                   }
               }
               
           }
       }


       func getColor(_ value: Int) -> Color
       {
           return self.buttonList.first(where: { $0.buttonIndex == value })?.color ?? Color.white
           
       }
    @State private var buttonList = [ColorButton]()

       @State private var selectedButtons: [Int] = [Int]()
       @State private var colorIndex: Int = 0
       @State private var count: Int = 0
    
    init()
       {

       }
    var body: some View {
        
        
        VStack
            {
                
                Text((self.count == 3 ) ? "you atteinted maximum items " : " You selected \(self.count) items")
                    .foregroundColor((self.count == 3 ) ? Color.red : Color.black)
             
                LazyVGrid(columns: columns){
                  

                    ForEach((1..<PREFS.count+1), id: \.self)
                    { index in
                
                       

                            Button(action: {
                                
                                self.updateSelectedButtons(value: index)
                            }) {
                                Text("\(PREFS[index - 1])")
                                    .foregroundColor(Color.black)
                                    .padding()
                            }
                            .background(self.getColor(index))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(hex: "5f9fff"), lineWidth: 1) )
                            .padding()
                        }
                    

                }
                Spacer()
            }.onAppear{idk()}
     
        
        .navigationTitle("Prefrences")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
           
            trailing:
            Button(action : {self.presentationMode.wrappedValue.dismiss()
 }){
                Text("Save")
        })
        
        
        
        
        
    }
    
    
    
    struct ColorModel: Identifiable {
        let value: Color
        let id = UUID()
    }
    
    
    let colors = [
        ColorModel(value: Color(hex: "5f9fff"))
        
    ]

    struct ColorButton
    {
        let color: Color
        let buttonIndex: Int
    }

       
}


struct PrefrencesView_Previews: PreviewProvider {
    static var previews: some View {
        PrefrencesView()
    }
}
