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
            HStack {
                Button("RESET") { trainingModel.reset() }
                Button("START") { trainingModel.start() }
            }
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
