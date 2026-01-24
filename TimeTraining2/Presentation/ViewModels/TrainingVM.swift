//
//  TrainingViewModel.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import Foundation
internal import Combine

class TrainingVM: ObservableObject {
    @Published var trainingSequence:TrainingSequence
    
    let trainingTimer = TrainingTimer()
    var timer:Timer?

    init(trainingSequence: TrainingSequence) {
        self.trainingSequence = trainingSequence
    }
    
    func start() {
        trainingTimer.start()
        timer=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            _ = self.trainingSequence.addDuration(duration: self.trainingTimer.getElapse())
            
        }
    }
    
    func stop() {
         trainingTimer.stop()
        timer?.invalidate()
        timer = nil
     }
    
    func reset() {
        trainingSequence.reset()
        trainingTimer.stop()
        timer?.invalidate()
        timer = nil
    }
}
