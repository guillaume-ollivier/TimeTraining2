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
    var exercise: ExerciseSequence
    var currentStepId:UUID?
    var completedIteration: Int
    var label: String
    var steps: [TrainingStep]

    var elapseDuration: Float {
        return totalDuration * progressRate
    }

    var remainDuration: Float {
        return totalDuration - elapseDuration
    }

    var sequenceCompleted: Bool {
        return completedIteration >= totalIteration
    }

    var totalDuration:Float {
        self.exercise.totalDuration
    }

    var totalIteration: Int {
        self.exercise.totalIteration
    }
    
    init(exerciseSequence: ExerciseSequence, completedIteration: Int=0) {
        self.exercise = exerciseSequence
        let steps = exerciseSequence.steps.map { exerciseStep in
            TrainingStep(step:exerciseStep,
                         progressRate: 0)
        }
        let totalDuration = exerciseSequence.totalDuration

        self.steps = steps        
        let completedIteration = max(0, min(completedIteration, exerciseSequence.totalIteration))
        self.completedIteration = completedIteration  

        let newElapseDuration = completedIteration==0 ? 0 : (0..<completedIteration).reduce(0.0) { partialResult, iteration in
            return partialResult + exerciseSequence.getDuration(iteration: iteration)
        }   
        let newRemainDuration = totalDuration - newElapseDuration
        self.progressRate = Float(newElapseDuration)/Float(totalDuration)

        self.elapseTime = HMSTime(from: Int(newElapseDuration))
        self.remainTime = HMSTime(from: Int(newRemainDuration))
        self.currentStepId = nil
        
        self.label = exerciseSequence.label
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
        var newElapseDuration:Float = (0..<completedIteration).reduce(0.0) { $0 + exercise.getDuration(iteration: $1) }

        /// Décompte les étapes
        currentStepId = nil
        for(index) in steps.indices {
            if((steps[index].enabledFirst && completedIteration==0) ||
               (steps[index].enabledLast && completedIteration==totalIteration-1) ||
               (completedIteration>0 && completedIteration<totalIteration-1)) {
                let stepStatus = steps[index].addDuration(newStatus.duration)
                newStatus = stepStatus.make(status: newStatus)
                if ( newStatus.duration == 0  && currentStepId == nil) {
                    currentStepId = steps[index].id
                }
                newElapseDuration += steps[index].elapseDuration
            }
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
                return addDuration(initialStatus: TrainingStatus(duration: newStatus.duration, event: .START_SEQUENCE))
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
