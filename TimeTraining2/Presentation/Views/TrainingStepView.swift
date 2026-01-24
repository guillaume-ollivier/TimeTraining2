//
//  TrainingStepView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import SwiftUI

struct TrainingStepView: View {
    let step: TrainingStep
    
    var body: some View {
        VStack {
            Text(step.title).font(.title2)
            TimeProgressView(elapseTime: step.elapseTime,
                             remainTime: step.remainTime,
                             progressRate: step.progressRate)
            .frame(height: 50)
        }
    }
}

#Preview {
    TrainingStepView(step: TrainingStep(
        elapseDuration: 3.0,
        remainDuration: 1.0,
        title: "titre"))
}
