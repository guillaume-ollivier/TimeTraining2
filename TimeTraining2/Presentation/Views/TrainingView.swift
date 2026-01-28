//
//  TrainingView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import SwiftUI

struct TrainingView: View {
    @StateObject var trainingModel: TrainingVM
    @Binding var exerciseSource: ExerciseSequence // Reçu de ContentView
    @State private var isShowingEdit = false // Contrôle la modale

    var body: some View {
        VStack {
            TrainingSequenceView(sequence: trainingModel.trainingSequence)
            Spacer()
            HStack(spacing: 40) {
                Button(action: { trainingModel.reset() }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title)
                        .padding()
                        .background(Circle().fill(.gray.opacity(0.2)))
                }
                
                // Bouton Dynamique Start / Pause
                    if trainingModel.isRunning {
                        // Mode PAUSE
                        Button(action: { trainingModel.stop() }) {
                            HStack {
                                Image(systemName: "pause.fill")
                                Text("PAUSE")
                            }
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Capsule().fill(.orange)) // Orange pour la pause
                            .foregroundColor(.white)
                        }
                    } else {
                        // Mode START
                        Button(action: { trainingModel.start() }) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("START")
                            }
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Capsule().fill(.green)) // Vert pour le départ
                            .foregroundColor(.white)
                        }
                    }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Modifier") {
                    isShowingEdit = true
                }
            }
        }
        // Ouverture de la vue de modification en superposition
        .sheet(isPresented: $isShowingEdit, onDismiss: {
            // ACTION LORS DE LA FERMETURE :
            // On demande au ViewModel de se mettre à jour avec les nouvelles données du Binding
            trainingModel.refresh(from: exerciseSource)
        }) {
            NavigationStack {
                ExerciseView(sequence: $exerciseSource)
                    .toolbar {
                        Button("Fermer") { isShowingEdit = false }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var sequence = ExerciseSequence(
        label: "ExerciseSequenceView",
        steps: [
            ExerciseStep(title: "working", duration: 5)
        ],
        totalIteration: 2
    )
    TrainingView(
        trainingModel:TrainingVM(
            trainingSequence:TrainingSequence(
                exerciseSequence: sequence)
        ),
        exerciseSource: $sequence
        )
}
