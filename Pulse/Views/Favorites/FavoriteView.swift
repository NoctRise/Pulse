//
//  FavoriteView.swift
//  Pulse
//
//  Created by Andi on 11.03.24.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var viewModel : RSSViewModel
    var body: some View {
        NavigationStack{
        if !viewModel.favorites.isEmpty{
            List{
                ForEach(viewModel.favorites, id: \.link){ article in
                    FeedListItemView(article: article)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.unfavoriteArticle(article: article)
                                
                                
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    
                        .onTapGesture {
                            if let link = article.link{
                                viewModel.showWebView(url: link)
                            }
                        }
                }
            }
            .navigationTitle("Favorites")
            .listStyle(.plain)
        }
            else {
                VStack{
                    Text("No favorites added")
                }
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    }
}

#Preview {
    FavoriteView()
        .environmentObject(RSSViewModel())
}
