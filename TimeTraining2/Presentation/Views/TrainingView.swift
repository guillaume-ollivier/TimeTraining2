//
//  TrainingView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 20/01/2026.
//

import SwiftUI

struct TrainingView: View {
    @Binding var exercise: ExerciseSequence
    @StateObject private var trainingModel = TrainingVM()
    @State private var isEditing = false
    

    var body: some View {
        VStack {
            if let sequence = trainingModel.trainingSequence {
                TrainingSequenceView(sequence: sequence)
            } else {
                Text("Appuyez sur START pour commencer")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Spacer()
            HStack {
                Button("RESET") { trainingModel.reset() }
                Button("START") { trainingModel.start() }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") { isEditing = true }
            }
        }
        .navigationBarTitle(exercise.label)
        // ✅ Nouvelle façon de faire
        .navigationDestination(isPresented: $isEditing) {
            ExerciseView(sequence: $exercise)
        }
        .onAppear {
            print("TrainingView.onAppear")
            trainingModel.updateExercise(execise: exercise)
        }
        .onChange(of: exercise) {
            print("TrainingView.onChange")
            trainingModel.updateExercise(execise: exercise)
        }
    }
}

#Preview {
    TrainingView(exercise: .constant(ExerciseSequence(
                    label: "Exo",
                    steps: [
                        ExerciseStep(title: "", duration: 3),
                        ExerciseStep(title: "", duration: 2)],
                    totalIteration: 3)))
}
