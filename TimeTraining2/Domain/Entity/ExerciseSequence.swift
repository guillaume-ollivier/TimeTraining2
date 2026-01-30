//
//  SequenceList.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 28/12/2025.
//

import Foundation

struct SequencePosition {
    let isFirst: Bool
    let isLast: Bool
}

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
        getDurationsList().reduce(0, +)
    }

    func getDurationsList() -> [Float] {
        guard totalIteration > 0 else { return [] }

        var durations: [Float] = []
        for iteration in 0..<totalIteration {
            durations.append(getDuration(iteration: iteration))
        }
        return durations
    }

    func getDuration(iteration: Int) -> Float {
        var duration: Float = 0
        let iteration = max(0, min(iteration, totalIteration - 1))

        if(totalIteration == 0) {
            return duration
        }

        for step in steps {
            if iteration == 0 && step.enabledFisrt {
                duration += step.duration
            } else if iteration == totalIteration - 1 && step.enabledLast {
                duration += step.duration
            } else if iteration > 0 && iteration < totalIteration - 1 {
                duration += step.duration
            }
        }
        return duration
    }
    func getDuration(position: SequencePosition) -> Float {
        var duration: Float = 0
        for step in steps {
            if position.isFirst && step.enabledFisrt {
                duration += step.duration
            } else if position.isLast && step.enabledLast {
                duration += step.duration
            } else if !position.isFirst && !position.isLast {
                duration += step.duration
            }
        }
        return duration
    }
    
}
