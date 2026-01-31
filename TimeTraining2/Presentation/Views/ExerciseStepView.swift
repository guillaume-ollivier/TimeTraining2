//
//  ExerciseStepView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import SwiftUI

struct ExerciseStepView: View {
    let nbIteration:Int
    @Binding var title: String
    @Binding var duration: Int
    @Binding var enabledFirst: Bool
    @Binding var enabledMiddle: Bool
    @Binding var enabledLast: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Nom de l'étape (ex: Pompe, Repos...)", text: $title)
                .font(.headline)
            
            HStack {
                Image(systemName: "timer")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                
                // Ton DurationPickerView customisé
                DurationPickerView(duration: $duration, stepSecond: 5)
                    .labelsHidden() // Si ton picker supporte l'étiquette masquée
            }
            HStack {
                Image(systemName: "play.circle")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                TimelineSelector(nbIteration: nbIteration,
                                 isFirstActive: $enabledFirst,
                                 isMiddleActive: $enabledMiddle,
                                 isLastActive: $enabledLast)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ExerciseStepView(nbIteration: 1,
                     title: .constant("a title"),
                     duration: .constant(10),
                     enabledFirst: .constant(true),
                     enabledMiddle: .constant(true),
                     enabledLast: .constant(false))
}
