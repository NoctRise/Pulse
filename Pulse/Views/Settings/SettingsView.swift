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
            
            Button("Log out", role: .destructive){
                userViewModel.logout()
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserViewModel())
}
