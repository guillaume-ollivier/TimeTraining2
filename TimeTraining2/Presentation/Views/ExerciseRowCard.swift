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
            // Indicateur visuel
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
                
                // On utilise ViewThatFits pour choisir la meilleure disposition
                ViewThatFits(in: .horizontal) {
                    // 1. Priorité : Tout sur une ligne
                    HStack(spacing: 10) {
                        infoLabels
                    }
                    
                    // 2. Si ça ne rentre pas : En colonne
                    VStack(alignment: .leading, spacing: 2) {
                        infoLabels
                    }
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
    
    // On extrait les labels pour éviter la répétition de code
    @ViewBuilder
    private var infoLabels: some View {
        Text("\(Image(systemName: "list.bullet")) \(exercise.steps.count) étapes   \(Image(systemName: "arrow.clockwise")) \(exercise.totalIteration) fois   \(Image(systemName: "clock")) \(HMSTime(from: Int(exercise.totalDuration)).toString())")
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true) // Empêche le tronquage ("...")
                .multilineTextAlignment(.leading)
                .lineLimit(nil) // Autorise autant de lignes que nécessaire
    }

}

#Preview {
    @Previewable @State var exercice = ExerciseSequence(
        label: "ExerciseSequenceView",
        steps: [
            ExerciseStep(id: UUID(),  title: "working", duration: 5)
        ],
        totalIteration: 2
    )
    
    ExerciseRowCard(exercise: exercice)
}
