//
//  ContentView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 23/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var exercices: [ExerciseSequence] =
        ExerciseStorage.load()
/*    @State var exercices = [
        ExerciseSequence(
            label: "Exo 1",
            steps: [
                ExerciseStep(title: "step 1", duration: 5),
                ExerciseStep(title: "step 2", duration: 5)],
            totalIteration: 1),
        ExerciseSequence(
            label: "Exo 2",
            steps: [
                ExerciseStep(title: "step 1", duration: 5),
                ExerciseStep(title: "step 2", duration: 5)],
            totalIteration: 2),
        ExerciseSequence(
            label: "Exo 3",
            steps: [
                ExerciseStep(title: "step 1", duration: 5),
                ExerciseStep(title: "step 2", duration: 5)],
            totalIteration: 3)
    ]*/
    @State private var isLoaded = false

    var body: some View {
            NavigationStack {
                List {
                    ForEach($exercices) { $exercise in
                        NavigationLink {
                                // Changement : On va directement à l'entraînement
                                TrainingView(
                                    trainingModel: TrainingVM(
                                        trainingSequence: TrainingSequence(exerciseSequence: exercise)
                                    ),
                                    exerciseSource: $exercise // On passe le binding pour pouvoir modifier plus tard
                                )
                            } label: {
                                Text(exercise.label)
                            }
                    }
                    .onDelete(perform: deleteExercise)
                    .onMove(perform: moveExercise)
                }
                .navigationTitle("Exercices")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: addExercise) {
                        Image(systemName: "plus")
                    }
                )
            }.onAppear {
                if !isLoaded {
                    exercices = ExerciseStorage.load()
                    isLoaded = true
                }
            }
            .onChange(of: exercices) {
                if isLoaded {
                    ExerciseStorage.save(exercices)
                }
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
