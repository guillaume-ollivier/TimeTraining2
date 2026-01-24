//
//  DurationPicker.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 28/12/2025.
//

import SwiftUI

struct DurationPickerView: View {
    @Binding var duration:Int
    let stepSecond:Int
    let minutesRange:[Int]
    let secondsRange:[Int]
    
    
    public init(duration: Binding<Int>, stepSecond:Int=1) {
        self._duration=duration
        self.stepSecond = stepSecond
        self.minutesRange = Array(stride(from: 0, to: 60, by: 1))
        self.secondsRange = Array(stride(from: 0, to: 59, by: stepSecond))
    }
    
    var body: some View {
            HStack(spacing: 0) {
                // Picker pour } minutes
                Picker("Minutes", selection: Binding<Int>(
                    get: { return duration/60 },
                    set: { duration =  $0*60 + duration%60 }
                )) {
                    ForEach(minutesRange, id: \.self) { minute in
                        Text("\(minute)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 50)
                .clipped()
                .labelsHidden()
                Text("min")

                // Picker pour les secondes
                Picker("Secondes", selection: Binding<Int>(
                    get: { return duration%60 },
                    set: { duration = (duration/60)*60 + $0 } )
                ) {
                    ForEach(secondsRange, id: \.self) { second in
                        Text("\(second)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 50)
                .clipped()
                .labelsHidden()
                Text("sec")
            }
    }
}

// Aperçu
struct DurationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DurationPickerView(duration:.constant(65),
                           stepSecond: 5)
    }
}
