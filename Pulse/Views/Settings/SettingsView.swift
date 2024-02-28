//
//  SettingsView.swift
//  Pulse
//
//  Created by Andi on 20.02.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    var body: some View {
        List{
            Section{
                NavigationLink("Change password"){
                    // TODO
                }
                
                NavigationLink("Edit feeds"){
                    // TODO
                }
                
                Button("Delete account"){
                    //
                }
            }

            Button("Log out", role: .destructive){
                userViewModel.logout()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserViewModel())
}
