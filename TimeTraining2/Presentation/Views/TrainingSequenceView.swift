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
            Text(sequence.label)
                .font(Font.largeTitle)
            HStack {
                Spacer()
                Text("cycle \(sequence.completedIteration) / \(sequence.totalIteration)")
                    .font(.title)
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
    @Previewable @State var sequence = ExerciseSequence(
        label: "Exercise",
        steps: [
            ExerciseStep(title: "working", duration: 4.0),
            ExerciseStep(title: "pause", duration: 2.0)
        ],
        totalIteration: 3
    )
    
    TrainingSequenceView(sequence: TrainingSequence(
        exerciseSequence: sequence,
        completedIteration: 1)
    )
}
