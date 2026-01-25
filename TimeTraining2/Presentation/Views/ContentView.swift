//
//  ContentView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 23/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var exercices: [ExerciseSequence] = ExerciseStorage.load()
    @State private var selectedExercise: Binding<ExerciseSequence>? = nil
    @State private var isShowingTraining = false

    @State private var isLoaded = false

    var body: some View {
            NavigationStack {
                List {
                    ForEach($exercices) { $exercise in
                        Button {
                            selectedExercise = $exercise
                            isShowingTraining = true
                        } label: {
                            Text(exercise.label)
                        }
                    }
                    .onDelete(perform: deleteExercise)
                    .onMove(perform: moveExercise)
                }
                .navigationBarTitle("Exercices")
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: addExercise) {
                        Image(systemName: "plus")
                    }
                )
                // Navigation vers TrainingView avec Binding
                .navigationDestination(isPresented: $isShowingTraining) {
                    if let selectedExercise = selectedExercise {
                        TrainingView(exercise: selectedExercise)
                    }
                }
            }.onAppear {
                print("ContentView.onAppear - isLoaded=\(isLoaded)")
                if !isLoaded {
                    exercices = ExerciseStorage.load()
                    isLoaded = true
                }
            }
            .onChange(of: exercices) {
                print("ContentView.onChange - isLoaded=\(isLoaded)")
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
