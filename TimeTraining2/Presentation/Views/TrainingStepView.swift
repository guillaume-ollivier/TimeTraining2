//
//  TrainingStepView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import SwiftUI

struct TrainingStepView: View {
    let step: TrainingStep
    // Imaginons une variable isActive passée par le parent
    var isActive: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(step.title)
                .font(.headline)
                .foregroundColor(isActive ? .primary : .secondary)
            TimeProgressView(elapseTime: step.elapseTime,
                             remainTime: step.remainTime,
                             progressRate: step.progressRate)
            .frame(height: 60)
        }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: .black.opacity(isActive ? 0.1 : 0), radius: 5, x: 0, y: 5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isActive ? Color.blue : Color.clear, lineWidth: 2)
                )
                .padding(.horizontal)
            }
        }

#Preview {
    TrainingStepView(step: TrainingStep(
        step: ExerciseStep(title: "titre", duration: 4.0),
        progressRate: 0.75))
}
