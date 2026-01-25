//
//  ExerciseSequenceView.swift
//  TimeTraining2
//
//  Created by Guillaume } on 22/01/2026.
//

import SwiftUI

struct ExerciseSequenceView: View {
    @Binding var sequence: ExerciseSequence
    
    /// États locaux pour découpler la saisie de la source de vérité
    @State private var localLabel: String
    @State private var localTotalIteration: Int
    
    init(sequence: Binding<ExerciseSequence>) {
        self._sequence = sequence
        self._localLabel = State(initialValue: sequence.wrappedValue.label)
        self._localTotalIteration = State(initialValue: sequence.wrappedValue.totalIteration)
    }
    
    var body: some View {
        VStack {
            /// --- Label ---
            TextField("Titre", text: $localLabel)
                .onChange(of: localLabel) { oldValue, newValue in
                    sequence.label = newValue
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            /// --- Durée totale ---
            Text("Durée totale : \(HMSTime(from: sequence.totalDuration).toString())")
                .padding(.horizontal)

            /// --- Total Iteration ---
            Stepper("Répétition : \(localTotalIteration)",
                    value: $localTotalIteration,
                    in: 0...99)
                .onChange(of: localTotalIteration) { oldValue, newValue in
                    sequence.totalIteration = newValue
                }
                .padding(.horizontal)
            
            /// --- Liste des étapes ---
            List {
                ForEach($sequence.steps) { $step in
                    ExerciseStepView(
                        title: $step.title,
                        duration: $step.durationSeconds
                    )
                }
                .onDelete(perform: deleteStep)
                .onMove(perform: moveStep)
            }
        }
        .onAppear {
            // Resynchronisation si la source a changé pendant la navigation
            localTotalIteration = sequence.totalIteration
            localLabel = sequence.label
        }
        .onChange(of: sequence.totalIteration) { oldValue, newValue in
            // Resynchronisation si la source change ailleurs (ex: TrainingView)
            localTotalIteration = newValue
        }
        .onChange(of: sequence.label) { oldValue, newValue in
            // Resynchronisation si la source change ailleurs (ex: TrainingView)
            localLabel = newValue
        }
        .navigationTitle("Modification")
        .navigationBarItems(
            leading: EditButton(),
            trailing: Button(action: addStep) {
                Image(systemName: "plus")
            }
        )
    }
}
    
extension ExerciseSequenceView {
    func addStep() {
        let newStep = ExerciseStep(
            title: "Nouvelle Etape",
            duration: 5
        )
        sequence.steps.append(newStep)
    }
    
    func deleteStep(at offsets: IndexSet) {
        sequence.steps.remove(atOffsets: offsets)
    }

    func moveStep(from source: IndexSet, to destination: Int) {
        sequence.steps.move(fromOffsets: source, toOffset: destination)
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

    ExerciseSequenceView(sequence: $sequence)
}
