//
//  FeedListItemView.swift
//  Pulse
//
//  Created by Andi on 15.02.24.
//

import SwiftUI

struct FeedListItemView: View {
    var post : RedditPost
    var body: some View {
        
        HStack(alignment: .top){
                Image("redditLogo")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading){
                if let title = post.data?.title {
                    Text(title)
                        .bold()
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                }
                    if let subreddit = post.data?.subreddit_name_prefixed{
                        Text(subreddit)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    HStack{
                        if let author = post.data?.author{
                            Text("submitted by \(author) ")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .font(.subheadline)
                        }
                    }
                    
            }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
        .padding([.top, .horizontal])
    
    }
}

#Preview {
    FeedListItemView(post : RedditPost(data: (RedditPostData.dummy)))
}
