//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Weerawut Chaiyasomboon on 22/12/2566 BE.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var isPresentingEditView = false
    @State private var editingScrum = DailyScrum.emptyScrum
    
    var body: some View {
        List{
            Section {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
                
            } header: {
                Text("Meeting Info")
            }
            
            Section {
                ForEach(scrum.attendees){ attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }
            
            Section {
                if scrum.history.isEmpty{
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }else{
                    ForEach(scrum.history){ history in
                        NavigationLink {
                            HistoryView(history: history)
                        } label: {
                            HStack{
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                            }
                        }
                    }
                }
            } header: {
                Text("History")
            }

        }
        .navigationTitle(scrum.title)
        .toolbar(content: {
            Button(action: {
                editingScrum = scrum
                isPresentingEditView = true
            }, label: {
                Text("Edit")
            })
        })
        .sheet(isPresented: $isPresentingEditView, content: {
            NavigationStack {
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                isPresentingEditView = false
                            }, label: {
                                Text("Cancel")
                            })
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button(action: {
                                isPresentingEditView = false
                                scrum = editingScrum
                            }, label: {
                                Text("Done")
                            })
                        }
                    })
            }
        })
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
