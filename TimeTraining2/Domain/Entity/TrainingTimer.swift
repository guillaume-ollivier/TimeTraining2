//
//  TrainingTimer.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 31/12/2025.
//

import Foundation

class TrainingTimer {
    var startDate: Date?
    var lastElapse:Float=0
    
    func start() {
        startDate=Date()
    }
        
    func stop() {
        self.lastElapse = getElapse()
        startDate=nil
    }
    
    func getElapse() -> Float {
        if let startDate=startDate {
            let now=Date()
            let elapse=(Float)(now.timeIntervalSince(startDate))+lastElapse
            self.lastElapse=0
            self.startDate=now
            return elapse
        } else {
            let elapse=lastElapse
            self.lastElapse=0
            return elapse
        }
    }
}
