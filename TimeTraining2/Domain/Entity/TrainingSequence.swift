//
//  TrainingSequence.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import Foundation

struct TrainingSequence {
    let id:UUID = UUID()
    var elapseTime: HMSTime
    var remainTime: HMSTime
    var progressRate: Float
    var totalDuration: Float
    var steps: [TrainingStep]
    var currentStepId:UUID?
    var completedIteration: Int
    var totalIteration: Int
    var label: String

    var elapseDuration: Float {
        return totalDuration * progressRate
    }

    var remainDuration: Float {
        return totalDuration - elapseDuration
    }

    var sequenceCompleted: Bool {
        return completedIteration >= totalIteration
    }

    init(steps: [TrainingStep], completedIteration: Int=0, totalIteration: Int, label: String) {
        let stepsTotalDuration = steps.reduce(0) { partialResult, step in
            return partialResult + Int(step.totalDuration)
        }
        let newElapseDuration = stepsTotalDuration * completedIteration
        let newRemainDuration = stepsTotalDuration * (totalIteration - completedIteration)
        
        self.totalDuration = Float(stepsTotalDuration*totalIteration)
        self.progressRate = Float(newElapseDuration)/Float(self.totalDuration)
        self.elapseTime = HMSTime(from: newElapseDuration)
        self.remainTime = HMSTime(from: newRemainDuration)
        self.steps = steps
        self.currentStepId = nil

        self.completedIteration = completedIteration
        self.totalIteration = totalIteration

        self.label = label
    }

    init(exerciseSequence: ExerciseSequence, completedIteration: Int=0) {
        let steps = exerciseSequence.steps.map { exerciseStep in
            TrainingStep(step:exerciseStep,
                         progressRate: 0)
        }
        self.init(steps: steps,
                  completedIteration: completedIteration,
                  totalIteration: exerciseSequence.totalIteration,
                  label: exerciseSequence.label)
    }

    mutating func addDuration(duration: Float) -> TrainingStatus {
        return addDuration(initialStatus: TrainingStatus(duration: duration, event: .NONE))
    }

    mutating func addDuration(initialStatus: TrainingStatus) -> TrainingStatus {
        if( initialStatus.duration <= 0 || sequenceCompleted ) {
            return initialStatus
        }

        /// Initialisation avec les précédentes itérations
        var newStatus = initialStatus
        var newElapseDuration:Float = totalDuration/Float(totalIteration) * Float(completedIteration)

        /// Décompte les étapes
        currentStepId = nil
        for(index) in steps.indices {
            let stepStatus = steps[index].addDuration(newStatus.duration)
            newStatus = stepStatus.make(status: newStatus)
            if ( newStatus.duration == 0  && currentStepId == nil) {
                currentStepId = steps[index].id
            }
            newElapseDuration += steps[index].elapseDuration
        }
        if(currentStepId == nil) {
            currentStepId = steps.last?.id
        }
        
        let newRemainDuration = totalDuration - newElapseDuration
        let newRemainDurationInt = Int(ceil(newRemainDuration))
        let newElapseDurationInt = Int(totalDuration) - newRemainDurationInt
        self.progressRate = newElapseDuration / Float(self.totalDuration)
        self.elapseTime = HMSTime(from: newElapseDurationInt)
        self.remainTime = HMSTime(from: newRemainDurationInt)
        
        if(newStatus.duration == 0) {
            /// Etapes en cours
 
            return newStatus;
        } else {
            /// Etapes terminées
            if completedIteration + 1 < totalIteration {
                /// Itérations en cours
                for(index) in steps.indices {
                    steps[index].reset()
                }
                /// Itérations suivantes
                completedIteration += 1
                return addDuration(initialStatus: TrainingStatus(duration: newStatus.duration, event: .END_SEQUENCE))
            } else {
                /// Exercice terminé
                completedIteration = totalIteration
                return TrainingStatus(duration: 0, event: .END_EXERCISE)
            }
        }
    }

    mutating func reset() {
        for(index) in steps.indices {
            steps[index].reset()
        }
        self.progressRate = 0.0
        self.elapseTime = HMSTime(from: 0)
        self.remainTime = HMSTime(from: Int(self.totalDuration))
        self.completedIteration = 0
    }
}
