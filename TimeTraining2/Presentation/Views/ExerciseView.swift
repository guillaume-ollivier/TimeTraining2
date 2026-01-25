//
//  ExerciseView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 22/01/2026.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var sequence: ExerciseSequence

    var body: some View {
            VStack {
                // On garde uniquement le formulaire
                ExerciseSequenceView(sequence: $sequence)
            }
            .navigationTitle("Modification")
        }}

#Preview {
    @Previewable @State var sequence = ExerciseSequence(
        label: "ExerciseView",
        steps: [
            ExerciseStep(title: "working", duration: 5)
        ],
        totalIteration: 2
    )
    
    ExerciseView(sequence: $sequence)
}
