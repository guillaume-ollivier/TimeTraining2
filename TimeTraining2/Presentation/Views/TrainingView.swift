//
//  TrainingView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import SwiftUI

struct TrainingView: View {
    @StateObject var trainingModel:TrainingVM
    
    var body: some View {
        VStack {
            TrainingSequenceView(sequence: trainingModel.trainingSequence)
            Spacer()
            HStack {
                Button("RESET") {
                    trainingModel.reset()
                }
                Button("START") {
                    trainingModel.start()
                }

            }
        }
    }
}

#Preview {
    TrainingView(
        trainingModel:TrainingVM(
            trainingSequence:TrainingSequence(
                exerciseSequence: ExerciseSequence(
                    label: "Exo",
                    steps: [
                        ExerciseStep(title: "", duration: 3),
                        ExerciseStep(title: "", duration: 2)],
                    totalIteration: 3))))
}
