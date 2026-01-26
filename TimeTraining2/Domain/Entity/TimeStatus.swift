//
//  TimeStatus.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 26/01/2026.
//

import Foundation

struct TimeStatus {
    let duration: Float
    let event: TimeEvent

    init(duration: Float, event: TimeEvent) {
        self.duration = duration
        self.event = event
    }

    func make(status: TimeStatus) -> TimeStatus {
        if(status.event.priority > self.event.priority) {
            return TimeStatus(duration: duration, event: status.event)
        } else {
            return TimeStatus(duration: duration, event: self.event)
        }
    }
}
