//
//  TimeEvent.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 26/01/2026.
//

import Foundation

enum TimeEvent {
    case NONE
    case INTERVAL_STEP
    case LAST_SECONDS(seconds:Int)
    case END_STEP
    case START_SEQUENCE
    case END_EXERCISE
    
    var priority: Int {
        switch self {
        case .NONE: return 0
        case .INTERVAL_STEP: return 1
        case .LAST_SECONDS: return 3
        case .END_STEP: return 4
        case .START_SEQUENCE: return 5
        case .END_EXERCISE: return 6
        }
    }
}
