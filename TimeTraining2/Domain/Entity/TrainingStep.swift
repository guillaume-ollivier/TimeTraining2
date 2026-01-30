//
//  TrainingStep.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import Foundation

struct TrainingStep {
    let id:UUID = UUID()
    var elapseTime: HMSTime
    var remainTime: HMSTime
    var progressRate: Float
    let intervalEvent:Float = 10.0 // seconds
    let nbLastSecond:Int = 2 // seconds
    let exerciseStep:ExerciseStep
    
    var title: String {
        exerciseStep.title
    }
    
    var totalDuration: Float {
        max(exerciseStep.duration, 0)
    }
    
    var elapseDuration: Float {
        return totalDuration * progressRate
    }

    var remainDuration: Float {
        return totalDuration - elapseDuration
    }
    
    var enabledFirst: Bool {
        exerciseStep.enabledFisrt
    }
    
    var enabledLast: Bool {
        exerciseStep.enabledLast
    }
    init(step: ExerciseStep, progressRate: Float) {
        let progressRate = min(max(progressRate, 0), 1)
        let totalDuration = max(step.duration, 0)
        let elapseDuration = Int(ceil(totalDuration * progressRate))
        let remainDuration = Int(totalDuration) - elapseDuration
        self.exerciseStep = step
        self.elapseTime = HMSTime(from: elapseDuration)
        self.remainTime = HMSTime(from: remainDuration)
        self.progressRate = progressRate
    }
  
    mutating func addDuration(_ duration: Float) -> TrainingStatus {
        guard duration >= 0 else { return TrainingStatus(duration: 0, event: .NONE) }
        let oldRemainDuration = remainDuration
        if (oldRemainDuration == 0) {
            /// Etape déjà terminée
            return TrainingStatus(duration: duration, event: .NONE)
        } else if(remainDuration <= duration) {
            /// Etape se termine
            let overDuration = duration - oldRemainDuration
            self.remainTime = HMSTime(from: 0)
            self.elapseTime = HMSTime(from: Int(self.totalDuration))
            self.progressRate = 1.0
            return TrainingStatus(duration: overDuration, event: .END_STEP)
        } else {
            /// Etape en cours
            let newRemainDuration = oldRemainDuration - duration
            let newRemainDurationInt = Int(ceil(newRemainDuration))
            let newElapseDuration = self.totalDuration - newRemainDuration
            let newElapseDurationInt = Int(self.totalDuration) - newRemainDurationInt
            self.progressRate = newElapseDuration / self.totalDuration
            self.remainTime = HMSTime(from: newRemainDurationInt)
            self.elapseTime = HMSTime(from: newElapseDurationInt)
            /// Event computing
            var event: TimeEvent = .NONE
            if (Int(newRemainDuration / intervalEvent) != Int(oldRemainDuration / intervalEvent)) {
                event = .INTERVAL_STEP
            }
            
            let oldSeconds=Int(ceil(oldRemainDuration))
            let newSeconds=Int(ceil(newRemainDuration))
            if(newSeconds<Int(intervalEvent) && oldSeconds != newSeconds) {
                event = .LAST_SECONDS(seconds: newSeconds)
            }
            return TrainingStatus(duration: 0, event: event)
        }
    }

    mutating func reset() {
        self.progressRate = 0.0
        self.elapseTime = HMSTime(from: 0)
        self.remainTime = HMSTime(from: Int(self.totalDuration))
    }

}
