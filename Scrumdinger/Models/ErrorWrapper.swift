//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Weerawut Chaiyasomboon on 26/12/2566 BE.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}

extension ErrorWrapper{
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired,
                     guidance: "You can safely ignore this error.")
    }
}
