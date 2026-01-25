//
//  ExerciseStepView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import SwiftUI

struct ExerciseStepView: View {
    @Binding var title: String
    @Binding var duration: Int
    
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
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ExerciseStepView(title: .constant("a title"), duration: .constant(10))
}
