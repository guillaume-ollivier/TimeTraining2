//
//  TrainingViewModel.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import Foundation
internal import Combine
import UIKit

class TrainingVM: ObservableObject {
    @Published var trainingSequence:TrainingSequence
    
    let trainingTimer = TrainingTimer()
    var timer:Timer?

    init(trainingSequence: TrainingSequence) {
        self.trainingSequence = trainingSequence
    }
    
    // Nouvelle fonction pour mettre à jour les données
    func refresh(from exercise: ExerciseSequence) {
        // On recrée une nouvelle séquence d'entraînement à partir de l'exercice modifié
        // tout en gardant l'état actuel si vous le souhaitez,
        // ou en réinitialisant pour prendre en compte les nouveaux temps.
        self.trainingSequence = TrainingSequence(exerciseSequence: exercise)
    }

    func start() {
        UIApplication.shared.isIdleTimerDisabled = true
        trainingTimer.start()
        timer=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let status = self.trainingSequence.addDuration(duration: self.trainingTimer.getElapse())
            switch status.event {
            case .NONE:
                break
            default:
                print("Event: \(status.event) at duration: \(status.duration) seconds")
            }


            if(self.trainingSequence.sequenceCompleted) {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
        }
    }
    
    func stop() {
        UIApplication.shared.isIdleTimerDisabled = false
        trainingTimer.stop()
        timer?.invalidate()
        timer = nil
     }
    
    func reset() {
        UIApplication.shared.isIdleTimerDisabled = false
        trainingSequence.reset()
        trainingTimer.stop()
        timer?.invalidate()
        timer = nil
    }
}
