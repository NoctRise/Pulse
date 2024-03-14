//
//  RSSFeed.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import SwiftUI

struct RSSFeed: View {
    @EnvironmentObject  var viewModel : RSSViewModel
    
    
    var body: some View {
        
        NavigationStack{
            
            VStack{
                
                if viewModel.showLoadingScreen {
                    ProgressView()
                } else {
                    
                        if let feed = viewModel.feed, !(viewModel.feed?.isEmpty ?? true){
                            List{
                            ForEach(feed, id: \.link){ article in
                                FeedListItemView(article: article)
                                    .swipeActions(edge: .trailing) {
                                        Button {
                                            viewModel.favoriteArticle(article: article)
                                        } label: {
                                            Label("Favorite", systemImage: "heart.fill")
                                                .tint(Color.red)
                                        }
                                    }
                                    .onTapGesture {
                                        if let link = article.link{
                                            viewModel.showWebView(url: link)
                                        }
                                    }
                            }
                            
                        }
                            .refreshable {viewModel.getRSSFeed()}
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
                    }
                    
                    if SettingsViewModel.shared.feeds.count ==  0 {
                            Text("Add feeds in the settings")
                    }
                }
            }
            
            .onChange(of : SettingsViewModel.shared.feeds){
                viewModel.getRSSFeed()
            }
            .listStyle(.plain)
            .toolbar{
                
                NavigationLink(destination: SettingsView(), label:
                                {
                    Image(systemName: "gearshape")
                })
            }
            .scrollIndicators(.never)
            
            .sheet(isPresented: $viewModel.showWebView, content: {
                VStack{
                    HStack{
                        Button("", systemImage: "xmark", action: {viewModel.showWebView.toggle()})
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    WebView(url: URL(string: viewModel.url)!)
                }
            })
            
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    RSSFeed()
        .environmentObject(RSSViewModel())
}
