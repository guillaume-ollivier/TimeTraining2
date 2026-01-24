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
    var totalDuration: Float
    let title:String

    var elapseDuration: Float {
        return totalDuration * progressRate
    }

    var remainDuration: Float {
        return totalDuration - elapseDuration
    }

    init(elapseTime: HMSTime, remainTime: HMSTime, title:String) {
        self.elapseTime = elapseTime
        self.remainTime = remainTime
        self.totalDuration = elapseTime.toSeconds() + remainTime.toSeconds()
        self.progressRate = elapseTime.toSeconds() / self.totalDuration
        self.title = title
    }

    init(totalDuration: Float, progressRate: Float, title:String) {
        let totalDuration = max(totalDuration, 0)  
        let progressRate = min(max(progressRate, 0), 1)
        self.elapseTime = HMSTime(from: totalDuration * progressRate)
        self.remainTime = HMSTime(from: totalDuration * (1 - progressRate))
        self.totalDuration = totalDuration
        self.progressRate = progressRate
        self.title = title
    }
    
    init(elapseDuration: Float, totalDuration: Float, title:String) {
        let totalDuration = max(totalDuration, 0)  
        let elapseDuration = min(max(elapseDuration, 0), totalDuration)
        self.elapseTime = HMSTime(from: elapseDuration)
        self.remainTime = HMSTime(from: totalDuration - elapseDuration)
        self.totalDuration = totalDuration
        self.progressRate = elapseDuration/totalDuration
        self.title = title
    }

    init(remainDuration: Float, totalDuration: Float, title:String) {
        let totalDuration = max(totalDuration, 0)  
        let remainDuration = min(max(remainDuration, 0), totalDuration)
        let elapseDuration = totalDuration - remainDuration
        self.elapseTime = HMSTime(from: elapseDuration)
        self.remainTime = HMSTime(from: remainDuration)
        self.totalDuration = totalDuration
        self.progressRate = elapseDuration/totalDuration
        self.title = title
    }

    init(elapseDuration: Float, remainDuration: Float, title:String) {
        let elapseDuration = max(elapseDuration, 0)
        let remainDuration = max(remainDuration, 0)
        let totalDuration = elapseDuration + remainDuration
        self.elapseTime = HMSTime(from: elapseDuration)
        self.remainTime = HMSTime(from: remainDuration)
        self.totalDuration = totalDuration
        self.progressRate = elapseDuration/totalDuration
        self.title = title
    }

    mutating func addDuration(_ duration: Float) -> Float {
        guard duration >= 0 else { return 0 }
        if remainDuration > duration {
            let newRemainDuration = remainDuration - duration
            let newElapseDuration = self.totalDuration - newRemainDuration
            self.progressRate = newElapseDuration / self.totalDuration
            self.remainTime = HMSTime(from: newRemainDuration)
            self.elapseTime = HMSTime(from: newElapseDuration)
            return 0
        } else {
            let overDuration = duration - remainDuration
            self.remainTime = HMSTime(from: 0)
            self.elapseTime = HMSTime(from: self.totalDuration)
            self.progressRate = 1.0 
            return overDuration
        }
    }

    mutating func reset() {
        self.progressRate = 0.0
        self.elapseTime = HMSTime(from: 0)
        self.remainTime = HMSTime(from: self.totalDuration)
    }

}
