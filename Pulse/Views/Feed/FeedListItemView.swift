//
//  FeedListItemView.swift
//  Pulse
//
//  Created by Andi on 15.02.24.
//

import SwiftUI

struct FeedListItemView: View {
    var article : Item
    var body: some View {
        
        HStack(alignment: .top){
                
                VStack(alignment: .leading){
                    if let title = article.title  {
                    Text(title)
                        .bold()
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                }
                    
                    HStack{
                        if let author = article.author, !author.isEmpty{
                            Text("submitted by \(author) ")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                        }
                        else if let creator = article.creator, !creator.isEmpty{
                        Text("submitted by \(creator) ")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                        }
                    }
              
                    Text(article.pubDate ?? "-")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
            }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    
    }
}

#Preview {
    FeedListItemView(article : Item.dummy)
}
