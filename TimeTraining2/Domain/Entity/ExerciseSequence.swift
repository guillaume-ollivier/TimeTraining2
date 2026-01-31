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

    func getSteps(iteration: Int) -> [ExerciseStep] {
        var selectedSteps: [ExerciseStep] = []
        let iteration = max(0, min(iteration, totalIteration - 1))

        for step in steps {
            if iteration == 0 && step.enabledFirst {
                selectedSteps.append(step)
            } else if iteration == totalIteration - 1 && step.enabledLast {
                selectedSteps.append(step)
            } else if iteration > 0 && iteration < totalIteration - 1 && step.enabledMiddle{
                selectedSteps.append(step)
            }
        }
        return selectedSteps
    }

    func getDuration(iteration: Int) -> Float {
        getSteps(iteration: iteration).reduce(0.0) { $0 + $1.duration }
    }
    
}
