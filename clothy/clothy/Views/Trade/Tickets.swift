//
//  OutFits.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 29/11/2022.
//

import SwiftUI



struct Tickets: View {
    
    @StateObject private var ovm = OutfitViewModel()
    @StateObject private var tvm = TradeViewModel()
    @StateObject private var mg = WebSocketManager()



    var body: some View {
        ZStack {
            ForEach(tvm.tickets,id: \.idd) { ticket in
                InfiniteStackView(tickets : $tvm.tickets , ticket : ticket)
            }
        } .onAppear{
          
            tvm.getswiped(completed: { reponse in
                
                
                if (reponse) {
                    
                    //User() = reponse
                  //  let utilisateur = reponse as! User
                    
                    
                    tvm.getall()
                    
                    
                } else {
                    print("ERROR CANT get")
                }
                
            })
          
           // print(ovm.tickets)
            print("----------")
        }
        .padding()
        .frame( maxWidth :.infinity  , maxHeight :.infinity , alignment :.center)
    }
}

struct Tickets_Previews: PreviewProvider {
    static var previews: some View {
        Tickets()
    }
}
struct InfiniteStackView: View {
    @StateObject private var tvm = TradeViewModel()

    @Binding var tickets : [TicketModel]
    @GestureState var isDragging : Bool = false
    @State var  offset : CGFloat = .zero
    var ticket : TicketModel
    @State var height : CGFloat = 0
    var body : some View {
        VStack{
            Ticket(title : ticket.typee, subtitle : ticket.taille ,top : ticket.couleur,bottom : ticket.photo, taille: ticket.taille,color: ticket.couleur, height : $height)
        }
        .frame(maxWidth :.infinity , maxHeight :.infinity)
        .zIndex(getIndex() == 0 && offset > 100 ? Double(CGFloat(tickets.count) - getIndex()) - 1 : CGFloat(tickets.count) - getIndex())
        .offset(x : offset)
        .rotationEffect(.init(degrees: getRotation(angle: 10)))
        .rotationEffect(getIndex() == 1 ? .degrees(-6):.degrees(0))
        .rotationEffect(getIndex() == 2 ? .degrees(6):.degrees(0))
        .scaleEffect(getIndex() == 0 ? 1 :0.9)
        .offset(x: getIndex() == 1 ? -40 : 0)
        .offset(x: getIndex() == 2 ? 40 : 0)
        .gesture(
            DragGesture()
                .updating($isDragging, body: {_,out,_ in  out = true} )
                .onChanged({ value in
                    var translation = value.translation.width
                    translation = tickets.first?.idd == ticket.idd ? translation : 0
                    translation = isDragging ? translation : 0
                    withAnimation(.easeInOut(duration: 0.3)){
                        offset = translation
                        height = -offset / 5
                    }
                    
                })
                .onEnded({value in
                    let width = UIScreen.main.bounds.width
                    let swipedRight = offset > width/2
                    let swipedLeft = -offset > width/2
                    
                    withAnimation(.easeInOut(duration: 0.5)){
                        if swipedLeft{
                            
                            offset = -width
                            removeticket()
                            tvm.swipeleft(IdOutfit: ticket.id, IdOutfitR: ticket.id, reciver: ticket.userID)
                        } else {
                            if swipedRight{
                                offset = width
                                removeAndadd()
                            }else{
                                offset = .zero
                                height = .zero
                            }
                        }
                       
                       
                    }
                    
                })
        )
    }
    func getIndex() -> CGFloat{
        let index  = tickets.firstIndex { ticket in
            return self.ticket.idd == ticket.idd
        } ?? 0
        return CGFloat(index)
    }
    func getRotation(angle : Double) -> Double {
        let width = UIScreen.main.bounds.width
        let progress = offset / width
        return Double(progress * angle)
    }
    func removeAndadd(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            var updatedticket =  ticket
            updatedticket.idd = UUID().uuidString
            tickets.append(updatedticket)
            withAnimation(.spring()){
                tickets.removeFirst()
            }
        }
    }
    func removeticket(){
        withAnimation(.spring()){
            tickets.removeFirst()
        }
    }
    
}
