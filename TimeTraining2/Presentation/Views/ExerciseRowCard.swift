//
//  ExerciseRowCard.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 25/01/2026.
//

import SwiftUI

struct ExerciseRowCard: View {
    let exercise: ExerciseSequence
    
    var body: some View {
        HStack(spacing: 15) {
            // Un petit indicateur visuel (ex: chronomètre ou cercle)
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 50, height: 50)
                Image(systemName: "figure.run")
                    .foregroundColor(.blue)
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.label)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack(spacing: 10) {
                    Label("\(exercise.steps.count) étapes", systemImage: "list.bullet")
                    // On pourrait calculer la durée totale ici
                    Label("\(HMSTime(from: exercise.totalDuration).toString())", systemImage: "clock")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.footnote.bold())
                .foregroundStyle(.tertiary)
             
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    @Previewable @State var exercice = ExerciseSequence(
        label: "ExerciseSequenceView",
        steps: [
            ExerciseStep(title: "working", duration: 5)
        ],
        totalIteration: 2
    )
    
    ExerciseRowCard(exercise: exercice)
}
