//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Weerawut Chaiyasomboon on 22/12/2566 BE.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    @State private var isRecording = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                Spacer()
                
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
                
                Spacer()
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear(perform: {
            startScrum()
        })
        .onDisappear(perform: {
            endScrum()
        })
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum(){
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
            
        }
        
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        
        scrumTimer.startScrum()
    }
    
    private func endScrum(){
        scrumTimer.stopScrum()
        
        speechRecognizer.stopTranscribing()
        isRecording = false
        
        let newHistory = History(attendees: scrum.attendees, transcript: speechRecognizer.transcript)
        scrum.history.insert(newHistory, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
