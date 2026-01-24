//
//  SequencesView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 28/12/2025.
//

import SwiftUI

struct ProgressView: View {
    let sequence:ExerciseSequence
    let progress:Float
    let totalDuration:Float
    
    var effectiveProgress:Float {
        max(0, min(progress, totalDuration))
    }
    
    var sequenceIndex:Int {
        sequence.steps.reduce((0, effectiveProgress), { acc, sequence in
            let rest=acc.1-sequence.duration;
            return (rest<=0) ? (acc.0, rest) : (acc.0+1, rest)
        }).0
    }

    init(sequence: ExerciseSequence, progress:Float) {
        self.sequence = sequence
        self.progress = progress
        totalDuration = sequence.steps.reduce(0.0, { $0 + $1.duration })
    }
    
    var body: some View {
        if totalDuration>0 {
            GeometryReader { geometry in
                ZStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(.red)
                            .frame(width: geometry.size.width*((CGFloat)(effectiveProgress)/(CGFloat)(self.totalDuration)),
                                   height: geometry.size.height)
                        HStack(spacing:0) {
                            ForEach(sequence.steps, id:\.self) { sequence in
                                Rectangle()
                                    .stroke(.green)
                                    .strokeBorder(lineWidth: 1)
                                    .frame(width: geometry.size.width*((CGFloat)(sequence.duration)/(CGFloat)(self.totalDuration)),
                                           height: geometry.size.height)
                            }
                        }
                    }
                    Text("Sequence: \(sequenceIndex)")
                }
            }
        }
    }
}

#Preview {
    ProgressView(sequence: ExerciseSequence(label: "Test", steps: [ExerciseStep(title: "Step 1", duration: 2),ExerciseStep(title: "Step 2", duration: 1),ExerciseStep(title: "Step 3", duration: 1)], totalIteration: 3), progress: 2.1)
}
