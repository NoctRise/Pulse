//
//  AuthenticationView.swift
//  Pulse
//
//  Created by Andi on 19.02.24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var userViewModel : UserViewModel
    
    var body: some View {
        VStack{
            
            Image("Logo")
                .resizable()
                .frame(maxWidth: 225, maxHeight: 60)
                .padding()
            TextField("Email", text: $userViewModel.email)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Passwort", text: $userViewModel.password)
                .textFieldStyle(.roundedBorder)
            Button{
                userViewModel.loginState ? userViewModel.login() : userViewModel.register()
            } label : {
                Text(userViewModel.loginState ? "Login" : "Register")
                    .frame(maxWidth: .infinity)
            }
            .disabled(userViewModel.disableButton)
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            
            Button(userViewModel.loginState ? "No account? Sign up here" : "Already got an account? Login here"){
                userViewModel.loginState.toggle()
            }
            
        }
        .padding()
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(UserViewModel())
}
