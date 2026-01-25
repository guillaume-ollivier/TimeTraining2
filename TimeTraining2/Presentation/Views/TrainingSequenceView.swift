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
        VStack(spacing: 0) {
            // --- HEADER FIXE ---
            VStack(spacing: 12) {
                VStack(spacing: 4) {
                    Text(sequence.label)
                        .font(.title2.bold())
                    
                    Text("Cycle \(sequence.completedIteration) / \(sequence.totalIteration)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                TimeProgressView(
                    elapseTime: sequence.elapseTime,
                    remainTime: sequence.remainTime,
                    progressRate: sequence.progressRate
                )
                .frame(height: 40)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
            .zIndex(1)

            // --- ZONE DÉFILANTE ---
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(sequence.steps, id: \.id) { step in
                            TrainingStepView(
                                step: step,
                                isActive: step.id == sequence.currentStepId
                            )
                            .id(step.id)
                            // La transition s'applique lors de l'apparition/disparition
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                        }
                    }
                    .padding()
                    // REPLACEMENT DE L'ANIMATION ICI :
                    // Elle surveille le changement d'ID pour animer les TrainingStepView
                    .animation(.spring(response: 0.5, dampingFraction: 0.7), value: sequence.currentStepId)
                }
                .onChange(of: sequence.currentStepId) { oldId, newId in
                    withAnimation {
                        proxy.scrollTo(newId, anchor: .center)
                    }
                }
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
