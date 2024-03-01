//
//  RSSFeed.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import SwiftUI

struct RSSFeed: View {
    @ObservedObject var viewModel = RSSViewModel()
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                if let feed = viewModel.feed{
                    ForEach(feed, id: \.link){ article in
                        FeedListItemView(article: article)
                            .onTapGesture {
                                if let link = article.link{
                                    viewModel.showWebView(url: link)
                                }
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
            .sheet(isPresented: $viewModel.showWebView, content: {
                VStack{
                    HStack{
                        Button("", systemImage: "xmark", action: {viewModel.showWebView.toggle()})
                            .padding()
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    
                    WebView(url: URL(string: viewModel.url)!)
                }
            })
            .navigationTitle("Community feed")
        }
        
        .refreshable {
            viewModel.getRSSFeed()
        }
    }
}

#Preview {
    RSSFeed()
}
