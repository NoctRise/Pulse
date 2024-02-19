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
    
    var body: some View {
        VStack{
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Passwort", text: $password)
            
                .onChange(of: password, {print(password)})
            Spacer()
            Button{
                loginState ? userViewModel.login(email: email, password: password) : userViewModel.register(email: email, password: password)
            } label : {
                Text(loginState ? "Login" : "Register")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            .buttonStyle(.borderedProminent)
            
            Button(loginState ? "No account? Sign up here" : "Already got an account? Login here"){
                loginState.toggle()
            }
        }
        
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(UserViewModel())
}
