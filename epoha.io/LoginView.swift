//
//  LoginView.swift
//  epoha.io
//
//  Created by constantine kos on 04.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    var body: some View {
        MainLoginView()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct MainLoginView: View {
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View{

        NavigationView{

            VStack{
                if self.status {
                    Homescreen()
                } else {
                    ZStack {
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            Text("")
                        }
                        .hidden()

                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {

                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in

                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct Homescreen: View {
    var body: some View{
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack{

                Text("Logged successfully")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("MainText"))

                Button(action: {
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }) {
                    Text("Log out")
                        .foregroundColor(Color("Golden"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Background"))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
                .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
                .padding(.top, 20)
                
            }
        }
    }
}

struct Login: View {

    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""

    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)

            ZStack(alignment: .topTrailing) {

                GeometryReader {_ in
                    VStack{
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .foregroundColor(.gray)
                            .frame(width: 32, height: 8)
                            .padding(.top, 10)
                        
                        Image("3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .padding(.top, 20)

                        Text("Log in to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("MainText"))
                            .padding(.top, 35)

                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Golden") : Color("MainText"),lineWidth: 2))
                            .padding(.top, 25)

                        HStack(spacing: 15) {
                            VStack{

                                if self.visible {
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                                else{
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("MainText"))
                            }

                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Golden") : Color("MainText"),lineWidth: 2))
                        .padding(.top, 25)

                        HStack{
                            Spacer()

                            Button(action: {
                                self.reset()
                            }) {
                                Text("Forget password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("MainText"))
                            }
                        }
                        .padding(.top, 20)

                        Button(action: {
                            self.verify()
                        }) {
                            Text("Log in")
                                .foregroundColor(Color("Golden"))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Background"))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
                        .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 25)
                    Spacer()
                }

                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Golden"))
                }
                .padding()
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }

    func verify() {
        if self.email != "" && self.pass != ""{

            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in

                if err != nil{

                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }

    func reset(){
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in

                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.error = "RESET"
                self.alert.toggle()
            }
        } else {
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
    }
}

struct SignUp : View {

    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""

    var body: some View{

        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .topLeading) {

                GeometryReader{_ in

                    VStack{
                        Text("Create new account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("MainText"))
                            .padding(.top, 10)
                        
                        Image("3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .padding(.top, 10)

                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Golden") : Color("MainText"),lineWidth: 2))
                            .padding(.top, 25)

                        HStack(spacing: 15) {

                            VStack{

                                if self.visible {
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                                else {
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }

                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("MainText"))
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Golden") : Color("MainText"), lineWidth: 2))
                        .padding(.top, 25)

                        HStack(spacing: 15){

                            VStack{
                                if self.revisible{
                                    TextField("Re-enter password", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                                else{
                                    SecureField("Re-enter password", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                            }

                            Button(action: {
                                self.revisible.toggle()
                            }) {
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("MainText"))
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Golden") : Color("MainText"),lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            self.register()
                        }) {
                            Text("Register")
                                .foregroundColor(Color("Golden"))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Background"))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
                        .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
                        .padding(.top, 20)
                        
                    }
                    .padding(.horizontal, 25)
                    Spacer()
                }

                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("Golden"))
                }
                .padding()
            }

            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    func register() {
        if self.email != ""{

            if self.pass == self.repass{

                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in

                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }

                    print("success")

                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            } else {
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

struct ErrorView : View {

    @Binding var alert: Bool
    @Binding var error: String

    var body: some View{

        GeometryReader{_ in

            VStack{

                HStack{

                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)

                    Spacer()
                }
                .padding(.horizontal, 25)

                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(Color.white)
                    .padding(.top)
                    .padding(.horizontal, 25)

                Button(action: {
                    self.alert.toggle()
                }) {
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundColor(Color("Golden"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 25)

            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.black)
            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
