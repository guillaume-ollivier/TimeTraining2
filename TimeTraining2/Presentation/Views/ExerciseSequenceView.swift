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
        Form {
            // SECTION 1 : Infos Générales
            Section(header: Text("Informations Générales")) {
                HStack {
                    Image(systemName: "tag")
                        .foregroundStyle(.blue)
                    TextField("Nom de la séance", text: $sequence.label)
                }
                
                Stepper(value: $sequence.totalIteration, in: 1...99) {
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                            .foregroundStyle(.orange)
                        Text("Répétitions : ")
                        Text("\(sequence.totalIteration)").bold()
                    }
                }
            }
            
            // SECTION 2 : Résumé
            Section {
                HStack {
                    Label("Durée totale", systemImage: "clock.fill")
                    Spacer()
                    Text(HMSTime(from: Int(sequence.totalDuration)).toString())
                        .fontWeight(.semibold)
                        .monospacedDigit()
                }
                .foregroundStyle(.secondary)
            }
            
            // SECTION 3 : Liste des Étapes
            Section(header: HStack {
                Text("Étapes de l'exercice")
                Spacer()
                Button(action: addStep) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
            }) {
                List {
                    ForEach($sequence.steps) { $step in
                        ExerciseStepView(title: $step.title,
                                         duration: $step.durationSeconds,
                                         enabledFirst: $step.enabledFisrt,
                                         enabledLast: $step.enabledLast)
                    }
                    .onDelete(perform: deleteStep)
                    .onMove(perform: moveStep)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) { EditButton() }
        }
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
