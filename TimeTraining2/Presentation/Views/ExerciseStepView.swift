//
//  ExerciseStepView.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import SwiftUI

struct ExerciseStepView: View {
    @Binding var title: String
    @Binding var duration: Int
    
    var body: some View {
        VStack {
            TextField("Titre", text: $title)
            DurationPickerView(duration: $duration, stepSecond: 5)
        }.frame(alignment: .center)
    }
}

#Preview {
    ExerciseStepView(title: .constant("a title"), duration: .constant(10))
}
