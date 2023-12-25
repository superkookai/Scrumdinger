//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Weerawut Chaiyasomboon on 25/12/2566 BE.
//

import SwiftUI

struct NewScrumSheet: View {
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumView: Bool
    @State private var newScrum = DailyScrum.emptyScrum
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            isPresentingNewScrumView = false
                        }, label: {
                            Text("Dismiss")
                        })
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }, label: {
                            Text("Add")
                        })
                    }
                })
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData), isPresentingNewScrumView: .constant(true))
}
