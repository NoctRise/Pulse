//
//  ContentView.swift
//  Pulse
//
//  Created by Andi on 07.02.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pulseViewModel = PulseViewModel()
    @StateObject var redditViewModel = RedditViewModel()
    var body: some View {
        
            TabView{
                CommunityFeedView()
                    .tabItem {
                        Label("Feed", systemImage:"newspaper")
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
            .environmentObject(redditViewModel)
            .environmentObject(pulseViewModel)
    }
}

#Preview {
    ContentView()
}
