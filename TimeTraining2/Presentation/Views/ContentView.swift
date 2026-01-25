//
//  ContentView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 23/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var exercices: [ExerciseSequence] = ExerciseStorage.load()
    @State private var isLoaded = false

    var body: some View {
        NavigationStack {
            ScrollView { // On remplace List par ScrollView pour plus de liberté
                LazyVStack(spacing: 16) {
                    ForEach($exercices) { $exercise in
                        NavigationLink(destination:
                            TrainingView(
                                trainingModel: TrainingVM(trainingSequence: TrainingSequence(exerciseSequence: exercise)),
                                exerciseSource: $exercise
                            )
                        ) {
                            ExerciseRowCard(exercise: exercise)
                        }
                        .buttonStyle(PlainButtonStyle()) // Enlève le style bleu par défaut
                        .contextMenu { // Optionnel : menu au appui long
                            Button(role: .destructive) {
                                if let index = exercices.firstIndex(where: { $0.id == exercise.id }) {
                                    exercices.remove(at: index)
                                }
                            } label: {
                                Label("Supprimer", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete(perform: deleteExercise) // Toujours possible si on est dans une List, sinon gérer manuellement
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Mes Séances")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addExercise) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                    }
                }
            }
        }
        .onAppear {
            if !isLoaded {
                exercices = ExerciseStorage.load()
                isLoaded = true
            }
        }
        .onChange(of: exercices) {
            if isLoaded { ExerciseStorage.save(exercices) }
        }
    }
}
extension ContentView {
    func addExercise() {
        let newExercise = ExerciseSequence(
            label: "Nouvel Exercice",
            steps: [
                ExerciseStep(title: "Step 1", duration: 5)
            ],
            totalIteration: 1
        )
        exercices.append(newExercise)
        ExerciseStorage.save(exercices)
    }
    
    func deleteExercise(at offsets: IndexSet) {
        exercices.remove(atOffsets: offsets)
        ExerciseStorage.save(exercices)
    }
    
    func moveExercise(from source: IndexSet, to destination: Int) {
        exercices.move(fromOffsets: source, toOffset: destination)
        ExerciseStorage.save(exercices)
    }
}

#Preview {
    ContentView()
}
