//
//  PulseApp.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI
import Firebase

@main
struct PulseApp: App {
    
    @StateObject private var userViewModel = UserViewModel()
    
    init(){
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            if userViewModel.userIsLoggedIn{
                ContentView()
            }
            else{
                AuthenticationView()
            }
            
        }
        .environmentObject(userViewModel)
    }
}
