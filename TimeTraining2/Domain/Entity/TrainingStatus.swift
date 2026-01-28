//
//  TimeStatus.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 26/01/2026.
//

import Foundation

struct TrainingStatus {
    let duration: Float
    let event: TimeEvent

    init(duration: Float, event: TimeEvent) {
        self.duration = duration
        self.event = event
    }

    func make(status: TrainingStatus) -> TrainingStatus {
        if(status.event.priority > self.event.priority) {
            return TrainingStatus(duration: duration, event: status.event)
        } else {
            return TrainingStatus(duration: duration, event: self.event)
        }
    }
}
