//
//  EditFeedView.swift
//  Pulse
//
//  Created by Andi on 13.03.24.
//

import SwiftUI

struct EditFeedView: View {
    @EnvironmentObject var settingsViewModel : SettingsViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                
                
                if !settingsViewModel.feeds.isEmpty{
                    List{
                        ForEach(settingsViewModel.feeds, id: \.self){ feed in
                            
                            Text(feed)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        settingsViewModel.deleteFeed(feed: feed)
                                        
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
                else
                {
                    Text("Add some feeds")
                }
            }
            .toolbar{
                Button{
                    settingsViewModel.showAlert.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .alert("Add new feed",isPresented: $settingsViewModel.showAlert) {
                TextField("Feed URL", text: $settingsViewModel.feedURL)
                    .textInputAutocapitalization(.never)
                
                Button("OK", action: {settingsViewModel.addFeed()
                })
                Button("Cancel", role: .cancel) { settingsViewModel.clearFeedURL()}
            }
            
        }
    }
}

#Preview {
    EditFeedView()
        .environmentObject(SettingsViewModel())
}
