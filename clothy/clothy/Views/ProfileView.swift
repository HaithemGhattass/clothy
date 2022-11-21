//
//  ProfileView.swift
//  clothy
//
//  Created by haithem ghattas on 8/11/2022.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @StateObject private var vm = UsersViewModel()
//    @StateObject private var vmp = ProfileViewModel()
    @StateObject private var loginVM = LoginViewModel()
   
    @State private var presentAlert = false
     private var pv = PrefrencesView()
    var gendr = ["Male", "Female", "other"]
   // @State private var selectedgender: vm.Gendr = .male

    @State var text = UIColor.label

    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var pseudo = ""
    @State private var email = ""
    @State private var phone = 0
    @State private var gender = ""
    @State private var changepass = false
    @State private var trah = false
    @State var selectedItem = "Male"
    @State var options = ["Male", "Female", "Other"]

      


    @State private var birthdate = Date()
    
   

/*
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
          //
            NavigationView{
                Form {
                    ScrollView{
                        ForEach(vm.users,id: \.id) { user in
                        Section(header: Text("Personal information")){
                       
                                
                                VStack(alignment: .leading) {
                                    Text("First Name")
                                        .customFont(.subheadline)
                                        .foregroundColor(.secondary)
                                    TextField(user.pseudo, text: $pseudo)
                                        .customTextField(image: Image(""))
                                }
                                TextField(user.pseudo,text: $pseudo)
                                

                                TextField(user.firstname,text: $firstname)
                                TextField(user.lastname,text: $lastname)
                                TextField(user.email,text: $email)
                                TextField("user.phone",text: $phone)

                                DatePicker("Birthdate",selection: $birthdate,displayedComponents: .date)
                                
                            };
                            
                        .onTapGesture {
                            print("password")
                        }
                        }
                    
                        
                    }
                    .navigationTitle("profile")
                    
                    .onAppear(perform: vm.fetchuser)
                }
            }
        }
    }
    */
     
     
     
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
        
        NavigationView {
          
            Form {
                
              
                
                    general
                   
         
                   
                
                    
                   
               
                
               
                contact
               // password
                passwordd
            //    gotopref //MARK: PREFS
                
                clearAll
                
            }
            //MARK: ALERT!
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
            
           
         
          
           
            
         
            .navigationBarTitle("Profile", displayMode: .inline)

            .toolbar {
                ToolbarItem(placement: .keyboard){
                    Button("Done"){
                        changepass ? print("chp") : vm.editUser(completed: { (reponse)  in
                            
                            if (reponse) {
                              //  trah = true
                                //vmp.updateView()
                               // vm.fetchuser()
                                
                                print($vm.firstname)
                                //User() = reponse
                              //  let utilisateur = reponse as! User
                                print("normalement jawk behy")
                            //    logIn()
                                
                                
                            } else {
                                print("ERROR CANT CONNECT")
                            }
                            
                        })
                        //action(vm.edit)
                    }
                  //  .disabled(!vmp.isValid)
                }
            }
         
        }
       

        }
        
    }
   
}

struct ProfileViewPreviews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
private extension ProfileView {
    var general: some View {
        Section {
            //MARK: IMAGE
           // let name = $vm.imageF
                // Image(uiImage: selectedImage!)
                AsyncImage(url: URL(string: vm.HOST_URL + "uploads/" +  vm.imageF)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        presentAlert = true

                    }
                   
            } else if phase.error != nil {
                Image(systemName: "tshirt.fill")
                
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        presentAlert = true
                    }
               // Color.red // Indicates an error.
            } else {
                Color.blue // Acts as a placeholder.
            }
        }
                        
                  
                 


                
                   
                     
                
           
                 
        
         
        
        
         
            
            TextField(vm.pseudo,text: $vm.pseudo)
                .textContentType(.nickname)
            
               
            
            TextField(vm.firstname,text: $vm.firstname)
                .textContentType(.name)
                .keyboardType(.namePhonePad)
            // .foregroundColor(.black).refreshable (action: vm.fetchuser)
            TextField(vm.lastname,text: $vm.lastname)
                .textContentType(.name)
                .keyboardType(.namePhonePad)
                .foregroundColor(.black)
            
            //MARK: birthdate
            DatePicker("Birthdate", selection: $vm.birthdate,in: ...Date(),displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .accentColor(Color(hex: "5f9fff"))
                .customFont(.subheadline)
                .foregroundColor(.secondary)
                .padding(15)
            
            //MARK: prefrences
            
            
            
            if(!changepass){
            //    selectedgender = vm.selectedgender
                
            //  Text("gender")
                
                Picker("", selection: $vm.selectedgender) { // 3
                    ForEach(options, id: \.self) { item in // 4
                        Text(item) // 5
                            
                    }
                    
                }
                .pickerStyle(.automatic)
                .foregroundColor(.secondary)
                .accentColor(Color(hex: "5f9fff"))
                .padding(15)
                
            }
            
            
            
        }
        
        
    header: {
//        Text("General")
//            .foregroundColor(.black)
        
        
    }footer: {
        Text("please enter your information")
    }
    .headerProminence(.increased)
        
 

        
        
        
        
    }
    var contact: some View {
        Section {
            TextField(String(vm.phone), value: $vm.phone, formatter: NumberFormatter())
            
            //  TextField(vm.phone,value:$vm.phone,formatter: NumberFormatter())
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
            TextField(vm.email,text:$vm.email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
            
            
        }header: {
            Text("Contact")
                .foregroundColor(.black)
            
            
        }footer: {
            Text("please enter your contact informations")
        }
        .headerProminence(.increased)
    }
    var passwordd: some View {
        Section {
            NavigationLink( "Change Password"
                            , destination: ChangePasswordView())
            
        }
    }
    var clearAll: some View {
        Button(role: .destructive) {
            
        }label: {
            Text("Delete Account")
        }
    }
    //MARK: EDIT PREFS
//    var gotopref: some View {
//
//        NavigationLink( "Edit Prefrences"
//                        , destination: PrefrencesView())
//
//
//
//
//    }
    var password: some View {
        Section {
            SecureField(vm.password,text: $vm.password)
                .textContentType(.password)
                .keyboardType(.namePhonePad)
            
            
            
        }header: {
            
            
        }footer: {
            Text("please enter any information")
        }
        .headerProminence(.increased)
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
