//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Weerawut Chaiyasomboon on 26/12/2566 BE.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Dismiss")
                    })
                }
            })
        }
    }
}

#Preview {
    ErrorView(errorWrapper: ErrorWrapper.wrapper)
}
