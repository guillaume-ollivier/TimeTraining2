//
//  HMSDuration.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 19/01/2026.
//

import Foundation

struct HMSTime {
    let hour: String
    let minute: String
    let second: String

    init(from duration: Float) {
        let totalSeconds = Int(duration)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        self.hour = String(format: "%02d", hours)
        self.minute = String(format: "%02d", minutes)
        self.second = String(format: "%02d", seconds)
    }

    func toSeconds() -> Float {
        let h = Int(hour) ?? 0
        let m = Int(minute) ?? 0
        let s = Int(second) ?? 0
        return Float(h * 3600 + m * 60 + s)
    }
    
    func toString() -> String {
        if(hour == "00"){
            return "\(minute):\(second)"
        } else {
            return "\(hour):\(minute):\(second)"
        }
    }
}
