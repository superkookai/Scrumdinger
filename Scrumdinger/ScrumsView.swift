//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Weerawut Chaiyasomboon on 22/12/2566 BE.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            List(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar(content: {
                Button(action: {}, label: {
                    Image(systemName: "plus")
                })
                .accessibilityLabel("New Scrum")
            })
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}
