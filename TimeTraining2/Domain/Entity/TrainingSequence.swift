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
        self.elapseTime = HMSTime(from: Float(newElapseDuration))
        self.remainTime = HMSTime(from: Float(newRemainDuration))
        self.steps = steps
        self.currentStepId = nil

        self.completedIteration = completedIteration
        self.totalIteration = totalIteration

        self.label = label
    }

    init(exerciseSequence: ExerciseSequence, completedIteration: Int=0) {
        let steps = exerciseSequence.steps.map { exerciseStep in
            TrainingStep(totalDuration: exerciseStep.duration, progressRate: 0, title: exerciseStep.title)
        }
        self.init(steps: steps,
                  completedIteration: completedIteration,
                  totalIteration: exerciseSequence.totalIteration,
                  label: exerciseSequence.label)
    }

    mutating func addDuration(duration: Float) -> Float {
        if( duration <= 0 || sequenceCompleted ) {
            return duration
        }
        var overDuration: Float = duration
        var newElapseDuration:Float = totalDuration/Float(totalIteration) * Float(completedIteration)
        currentStepId = nil
        for(index) in steps.indices {
            overDuration = steps[index].addDuration(overDuration)
            if ( overDuration == 0  && currentStepId == nil) {
                currentStepId = steps[index].id
            }
            newElapseDuration += steps[index].elapseDuration
        }
        if(currentStepId == nil) {
            currentStepId = steps.last?.id
        }
        
        let newRemainDuration = totalDuration - newElapseDuration
        if(overDuration > 0 ) {
            if completedIteration + 1 < totalIteration {
                for(index) in steps.indices {
                    steps[index].reset()
                }
                completedIteration += 1
                return addDuration(duration: overDuration)
            } 
        }

        self.progressRate = newElapseDuration / Float(self.totalDuration)
        self.elapseTime = HMSTime(from: Float(newElapseDuration))
        self.remainTime = HMSTime(from: Float(newRemainDuration))
        if(overDuration>0) {
            // all completed
            overDuration = 0
            completedIteration = totalIteration
        }
        return 0;
    }

    mutating func reset() {
        for(index) in steps.indices {
            steps[index].reset()
        }
        self.progressRate = 0.0
        self.elapseTime = HMSTime(from: 0.0)
        self.remainTime = HMSTime(from: Float(self.totalDuration))
        self.completedIteration = 0
    }
}
