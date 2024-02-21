//
//  CommunityFeedView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct CommunityFeedView: View {
    @EnvironmentObject var redditViewModel : RedditViewModel
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                if let posts = redditViewModel.posts{
                    ForEach(posts, id: \.data?.id){ post in
                        FeedListItemView(post: post)
                            .onTapGesture {
                                redditViewModel.showWebView(post: post)
                            }
                    }
                }
                else {
                    Text("Pull to refresh feed.")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .toolbar{
                NavigationLink(destination: SettingsView()){
                    Image(systemName: "gearshape")
                }
            }
            .scrollIndicators(.never)
            .sheet(isPresented: $redditViewModel.showSheet, content: {
                VStack{
                    HStack{
                        Button("", systemImage: "xmark", action: {redditViewModel.showSheet.toggle()})
                            .padding()
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    
                    WebView(url: URL(string: redditViewModel.url)!)
                }
            })
            .navigationTitle("Community feed")
        }
        
        .refreshable {
            redditViewModel.getRedditPosts()
        }
    }
}

#Preview {
    CommunityFeedView()
        .environmentObject(RedditViewModel())
}
