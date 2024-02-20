//
//  CommunityFeedView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct CommunityFeedView: View {
    @EnvironmentObject var redditViewModel : RedditViewModel
    @State var showSheet = false
    @State var url = ""
    var body: some View {
        
        NavigationStack{
            ScrollView{
                if let posts = redditViewModel.posts{
                    ForEach(posts, id: \.data?.id){ post in
                        FeedListItemView(post: post)
                            .onTapGesture {
                                url="https://www.reddit.com\(String(post.data!.permalink))"
                            }
                    }
                }
                else {
                    Text("Pull to refresh feed.")
                    Spacer()
                    Image(systemName: "chevron.down")   
                }
            }
            .onChange(of: url) {
                showSheet = true
            }
            .toolbar{
                NavigationLink(destination: SettingsView()){
                    Image(systemName: "gearshape")
                }
            }
            .scrollIndicators(.never)
            .sheet(isPresented: $showSheet, content: {WebView(url: URL(string: url)!)})
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
