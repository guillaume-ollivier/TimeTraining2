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
            // Préparation des valeurs textuelles
        let stepCount = "\(exercise.steps.count) étape\(exercise.steps.count>=2 ? "s" : "")"
            let iterCount = "\(exercise.totalIteration) fois"
            let duration = HMSTime(from: Int(exercise.totalDuration)).toString()
            
            // Construction d'un SEUL Text via interpolation.
            // \u{00A0} = Espace insécable (colle l'icône au texte)
            // Les espaces normaux entre les groupes permettront le retour à la ligne.
            Text("\(Image(systemName: "list.bullet"))\u{00A0}\(stepCount)   \(Image(systemName: "arrow.clockwise"))\u{00A0}\(iterCount)   \(Image(systemName: "clock"))\u{00A0}\(duration)")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
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
