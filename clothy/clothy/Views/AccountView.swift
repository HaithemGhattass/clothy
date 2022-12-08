//
//  AccountView.swift
//  Clothy
//
//  Created by haithem ghattas on 28/11/2022.
//

import SwiftUI

struct AccountView: View {
    @State var isDeleted = false
    @State var show = false

    @StateObject private var vm = UsersViewModel()
    @State private var presentAlert = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false

    @Environment(\.presentationMode) var presentationmode
    var body: some View {
        if !show {
        NavigationView{
            List {
                profile
                    .alert(isPresented: $presentAlert) {
                        Alert(
                            title: Text("Pick a source"),
                            
                            primaryButton: .default(Text("Camera"), action: {
                                self.sourceType = .camera
                                self.isImagePickerDisplay.toggle()
                                
                                
                            }),
                            secondaryButton: .default(Text("Gallery"), action: {
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                                
                                
                            })
                        )
                        
                    }
                    .sheet(isPresented: self.$isImagePickerDisplay) {
                        
                        ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                        
                        
                        
                        
                    }
                    .onAppear{
                        
                        
                        vm.fetchuser()
                        
                        
                        
                    }
                
                menu
                links
                Button(role: .destructive) {
                    
                }label: {
                    Text("Delete Account")
                }
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing: Button{
                presentationmode.wrappedValue.dismiss()
            }label: {
                Text("Done").bold()
            })
        }
    }
        if show {
            OnboardingView(show: $show)
                .background(.white)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
                .ignoresSafeArea()
            
            // uncomment for some offset  .ignoresSafeArea(.all, edges: .top)
                .transition(.move(edge: .top))
            //   .offset(y: show ? -10 : 0)
                .zIndex(1)
        }
    }
    
    
    var profile: some View {
        VStack(spacing: 8) {
            
            AsyncImage(url: URL(string: vm.HOST_URL + "uploads/" +  vm.imageF)) { phase in
        if let image = phase.image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 100, height: 100,alignment: .center)
                .background(HexagonView()
                    .offset(x:-50,y:-100)
            )
                .background(
                    BlobView()
                        .offset(x:200 , y:0)
                        .scaleEffect(0.6)
                )
                .onTapGesture {
                    presentAlert = true
                }

        } else if phase.error != nil {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(HexagonView()
                    .offset(x:-50,y:-100)
            )
                .background(
                    BlobView()
                        .offset(x:200 , y:0)
                        .scaleEffect(0.6)
                )
                .onTapGesture {
                    presentAlert = true
                }
            
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
                .background(HexagonView()
                    .offset(x:-50,y:-100)
            )
                .background(
                    BlobView()
                        .offset(x:200 , y:0)
                        .scaleEffect(0.6)
                )
                .onTapGesture {
                    presentAlert = true
                }
        }
            }
            
            
            
//
//
//            Image(systemName: "person.crop.circle.fill.badge.checkmark")
//                .symbolVariant(.circle.fill)
//                .font(.system(size: 32))
//                .symbolRenderingMode(.palette)
//                .foregroundStyle(.blue, .blue.opacity(0.3))
//                .padding()
//                .background(Circle().fill(.ultraThinMaterial))
//                .background(HexagonView()
//                    .offset(x:-50,y:-100)
//            )
//                .background(
//                    BlobView()
//                        .offset(x:200 , y:0)
//                        .scaleEffect(0.6)
//                )
            Text(vm.firstname + " " + vm.lastname)
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.large)
                Text(vm.pseudo)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    var menu : some View {
        Section {
            NavigationLink(destination: ProfileView()) {
                Label("General",systemImage: "gear")
            }
            NavigationLink(destination: ContactView()){
                
                Label("Contact",systemImage: "mail")
            }
            NavigationLink{ChangePasswordView()} label: {
                Label("Password",systemImage: "lock")
            }
            NavigationLink{HomeView()} label: {
                Label("Help",systemImage: "questionmark")
            }
            
               
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    var links : some View {
        Section {
            

            Button(role: .destructive) {
                withAnimation{
                    show.toggle()
                }
            }label: {
                Text("Logout")
            }
            

        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    @StateObject private var vm = UsersViewModel()

    var sourceType: UIImagePickerController.SourceType
   
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
       
//        if(selectedImage != nil){
//
//            vm.PostVideoUrl(url: selectedImage!)
//
//
//        }
        
      
        return imagePicker
        
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
      
    }
    
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(picker: self)
    }
    
    
}

