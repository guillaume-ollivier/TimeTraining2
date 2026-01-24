//
//  SequenceList.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 28/12/2025.
//

import Foundation

struct ExerciseSequence: Identifiable, Hashable, Codable {
    let id:UUID
    var label: String
    var steps: [ExerciseStep]
    var totalIteration: Int
    
    init(
        id: UUID = UUID(),
        label: String,
        steps: [ExerciseStep],
        totalIteration: Int
    ) {
        self.id = id
        self.label = label
        self.steps = steps
        self.totalIteration = totalIteration
    }
    
    var totalDuration:Float {
        let stepsDuration = steps.reduce(0) { partialResult, step in
            partialResult+step.duration
        }
        return stepsDuration * (Float)(totalIteration)
    }
}
