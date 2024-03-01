//
//  AuthenticationView.swift
//  Pulse
//
//  Created by Andi on 19.02.24.
//

import SwiftUI

struct AuthenticationView: View {
    @State var loginState = true
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var userViewModel : UserViewModel
    private var disableButton : Bool {
        email.isEmpty || password.isEmpty
    }
    
    var body: some View {
        VStack{
            
            Image("Logo")
                .resizable()
                .frame(maxWidth: 225, maxHeight: 60)
                .padding()
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Passwort", text: $password)
                .textFieldStyle(.roundedBorder)
            Button{
                loginState ? userViewModel.login(email: email, password: password) : userViewModel.register(email: email, password: password)
            } label : {
                Text(loginState ? "Login" : "Register")
                    .frame(maxWidth: .infinity)
            }
            .disabled(disableButton)
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            
            Button(loginState ? "No account? Sign up here" : "Already got an account? Login here"){
                loginState.toggle()
            } 
            
        }
        .padding()
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(UserViewModel())
}
