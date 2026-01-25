//
//  TrainingSequenceView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import SwiftUI

struct TrainingSequenceView: View {
    let sequence: TrainingSequence
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(sequence.completedIteration) / \(sequence.totalIteration)")
                Spacer()
            }
            TimeProgressView(elapseTime: sequence.elapseTime,
                             remainTime: sequence.remainTime,
                             progressRate: sequence.progressRate).frame(height: 50)
            ForEach(sequence.steps, id: \.id) { step in
                TrainingStepView(step: step)
            }
        }
    }
}

#Preview {
    TrainingSequenceView(sequence: TrainingSequence(
        exerciseSequence: ExerciseSequence(
            label:"Exercise",
            steps: [
                ExerciseStep(title: "working", duration: 4.0),
                ExerciseStep(title: "pause", duration: 2.0)
            ], totalIteration: 3),
        completedIteration: 1)
    )
}
