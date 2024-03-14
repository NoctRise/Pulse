//
//  SettingsView.swift
//  Pulse
//
//  Created by Andi on 20.02.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var settingsViewModel : SettingsViewModel
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    NavigationLink("Change password"){
                        // TODO
                    }
                    
                    NavigationLink("Edit feeds"){
                        
                        EditFeedView()
                    }
                    
                    Button("Delete account"){
                        settingsViewModel.deleteConfirmationAlert.toggle()
                    }
                }
                
                Button("Log out", role: .destructive){
                    userViewModel.logout()
                }
                .frame(maxWidth: .infinity)
            }
            .alert("Delete Account?", isPresented: $settingsViewModel.deleteConfirmationAlert){
                Button("Yes", action: settingsViewModel.deleteUserData)
                Button("Cancel", role: .cancel) { }
            }
        }
        .navigationTitle("Settings")
    }
}


#Preview {
    SettingsView()
        .environmentObject(UserViewModel())
        .environmentObject(SettingsViewModel())
}
