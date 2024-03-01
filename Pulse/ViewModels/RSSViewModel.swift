//
//  RSSViewModel.swift
//  Pulse
//
//  Created by Andi on 29.02.24.
//

import Foundation

@MainActor
class RSSViewModel : ObservableObject {
    
    private var rss = ["https://www.bleepingcomputer.com/feed/", "https://www.darkreading.com/rss.xml", "https://www.reddit.com/r/netsec/new/.rss", "https://www.reddit.com/r/blueteamsec/.rss"]
    
    @Published var feed : [Item]?
    
    @Published var showWebView = false
    @Published var url = ""
    
    
    func getRSSFeed(){
        
        var newFeed : [Item] = []
        Task {
            for rssName in rss{
                do {
                    guard let feed = try await RSSRepository.getRSSFeed(rss: rssName) else {
                        print("error getting Rss feed")
                        return
                    }
                    
                    newFeed.append(contentsOf: feed)
                }
                catch{
                    print("Failed getting getting rss feed: \(error)")
                }
            }
            feed = newFeed.sorted(by: {
                $0.pubDate ?? "1" > $1.pubDate ?? "2"
            })
        }
    }
    
    func showWebView(url : String){
        self.url = url
        showWebView.toggle()
    }
}
