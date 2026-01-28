//
//  TrainingStep.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 28/12/2025.
//

import Foundation

struct ExerciseStep: Identifiable, Hashable, Codable {
    let id:UUID 
    var title:String
    var duration: Float

    init(
        id: UUID = UUID(),
        title: String,
        duration: Float
    ) {
        self.id = id
        self.title = title
        self.duration = duration
    }
    
    /// Durée exposée à l’UI (secondes entières)
    var durationSeconds: Int {
        get {
            Int(duration.rounded())
        }
        set {
            duration = Float(newValue)
        }
    }
}
