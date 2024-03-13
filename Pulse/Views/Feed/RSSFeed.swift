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
            List{
                if let feed = viewModel.feed, !(viewModel.feed?.isEmpty ?? true){
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
                else {
                    VStack{
                        Text("Pull to refresh feed.")
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                }
            }
            
            .listStyle(.plain)
            .toolbar{
                
                
                
                
                
                NavigationLink(destination: SettingsView(), label:
                                {
                    Image(systemName: "gearshape")
                })
                //                        viewModel.showSettings.toggle()
                
            }
            .scrollIndicators(.never)
            //            .sheet(isPresented: $viewModel.showSettings){
            //                VStack{
            //                    HStack{
            //                        Button("", systemImage: "xmark", action: {viewModel.showSettings.toggle()})
            //                            .padding()
            //                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            //                    SettingsView()
            //                }
            //                .presentationDetents([.height(350), .medium, .large])
            //            }
            
            
            
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
            
            .navigationTitle("Feed")
        }
        
        .refreshable {
            viewModel.getRSSFeed()
        }
    }
}

#Preview {
    RSSFeed()
        .environmentObject(RSSViewModel())
}
