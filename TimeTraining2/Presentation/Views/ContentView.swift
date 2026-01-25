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
    @Environment(
        \.editMode
    ) private var editMode // Pour surveiller l'état d'édition

    var body: some View {
        NavigationStack {
            List {
                ForEach($exercices) { $exercise in
                    ZStack {
                        // Le déclencheur invisible qui prend toute la place
                        NavigationLink(destination:
                                        TrainingView(
                                            trainingModel: TrainingVM(
                                                trainingSequence: TrainingSequence(
                                                    exerciseSequence: exercise
                                                )
                                            ),
                                            exerciseSource: $exercise
                                        )
                        ) {
                            EmptyView()
                        }
                        .buttonStyle(.plain)
                        .opacity(0) // On cache absolument tout l'élément natif
                            
                        // Ta carte personnalisée (l'UI visible)
                        ExerciseRowCard(exercise: exercise)
                        // On désactive l'interaction sur la carte pour que
                        // le clic passe à travers vers le NavigationLink
                            .allowsHitTesting(false)
                    }
                    // Désactive le lien si on est en train d'éditer
                    .disabled(editMode?.wrappedValue.isEditing ?? false)
                    .listRowSeparator(.hidden) // Cache les lignes
                    .listRowBackground(
                        Color.clear
                    ) // Fond transparent pour voir le fond global
                    .listRowInsets(
                        EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
                    )
                    .contextMenu {
                        Button(role: .destructive) {
                            if let index = exercices.firstIndex(
                                where: { $0.id == exercise.id
                                }) {
                                exercices.remove(at: index)
                            }
                        } label: { Label("Supprimer", systemImage: "trash") }
                    }
                }
                .onDelete(perform: deleteExercise)
                .onMove(perform: moveExercise)
            }
            .listStyle(.plain) // Enlève le style par défaut
            .background(Color(UIColor.systemGroupedBackground))
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
        .onChange(of: exercices) { oldVal, newVal in
            if isLoaded { ExerciseStorage.save(newVal) }
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
