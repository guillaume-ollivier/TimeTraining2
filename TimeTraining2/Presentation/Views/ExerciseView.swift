//
//  ExerciseView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 22/01/2026.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var sequence: ExerciseSequence
    @State private var isShowingThirdView = false


    var body: some View {
        VStack {
            ExerciseSequenceView(sequence: $sequence)
            Spacer()
            NavigationLink {
                TrainingView(
                    trainingModel: TrainingVM(
                        trainingSequence: TrainingSequence(
                            exerciseSequence: sequence
                        )
                    )
                )
            } label: {
                Text("Aller à la troisième vue")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle(sequence.label)
    }
}

#Preview {
    ExerciseView(sequence: .constant(ExerciseSequence(
                label: "ExerciseView",
                steps: [
                    ExerciseStep(title: "Working", duration: 3.0)],
                totalIteration: 2)))
}
