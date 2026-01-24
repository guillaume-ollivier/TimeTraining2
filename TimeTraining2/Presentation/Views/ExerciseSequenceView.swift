//
//  ExerciseSequenceView.swift
//  TimeTraining2
//
//  Created by Guillaume } on 22/01/2026.
//

import SwiftUI

struct ExerciseSequenceView: View {
    @Binding var sequence: ExerciseSequence
    
    var body: some View {
        VStack {
            TextField("Titre", text: $sequence.label)
            Text("Durée totale : \(HMSTime(from:sequence.totalDuration).toString())")
            Stepper("Répétition : \(sequence.totalIteration)",
                    value: $sequence.totalIteration,
                    in: 0...99)
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
        .navigationTitle("Exercices")
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
