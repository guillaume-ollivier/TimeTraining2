//
//  TrainingViewModel.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import Foundation
internal import Combine

class TrainingVM: ObservableObject {
    @Published var trainingSequence:TrainingSequence?
    
    let trainingTimer = TrainingTimer()
    var timer:Timer?

    
    func updateExercise(execise: ExerciseSequence) {
        let sequenceCompleted = trainingSequence?.sequenceCompleted ?? true
        let elapseDuration = sequenceCompleted ? (trainingSequence?.totalDuration ?? 0) : trainingSequence!.elapseDuration
        trainingSequence = TrainingSequence(exerciseSequence: execise)
        _ = trainingSequence!.addDuration(duration: elapseDuration)
            
    }
    
    func start() {
        trainingTimer.start()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            _ = self.trainingSequence?.addDuration(duration: self.trainingTimer.getElapse())
        }
    }
   
    
    func stop() {
         trainingTimer.stop()
        timer?.invalidate()
        timer = nil
     }
    
    func reset() {
        trainingSequence?.reset()
        trainingTimer.stop()
        timer?.invalidate()
        timer = nil
    }
}
