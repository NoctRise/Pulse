//
//  ContentView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pulseViewModel = PulseViewModel()
    @StateObject var rssViewModel = RSSViewModel()
    
    var body: some View {
        
            TabView{
                RSSFeed()
                    .tabItem {
                        Label("Feed", systemImage:"newspaper")
                    }
                
                if rssViewModel.favorites.count > 0 {
                    FavoriteView()
                        .tabItem {
                            Label("Favorite", systemImage:"heart.fill")
                        }
                        .badge(rssViewModel.favorites.count)
                }
                
                AnalyzeView()
                    .tabItem {
                        Label("Analyze", systemImage: "magnifyingglass")
                    }
                
                ExploreView()
                    .tabItem {
                        Label("Explore", systemImage: "eye")
                    }
            }
            
            .environmentObject(pulseViewModel)
            .environmentObject(rssViewModel)
    }
}

#Preview {
    ContentView()
}
