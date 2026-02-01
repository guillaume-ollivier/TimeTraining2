import CoreHaptics
import UIKit

class HapticManager {
    private var engine: CHHapticEngine?

    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        engine = try? CHHapticEngine()
        try? engine?.start()
    }

    func playDeepVibration(duration: Double) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        // Intensité max, mais Sharpness bas (0.1) pour être discret au sol
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
        
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: duration)

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Erreur haptique: \(error)")
        }
    }
    
    func playMultiPulse(count: Int, interval: Double = 0.15) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var events: [CHHapticEvent] = []

        for i in 0..<count {
            // Calcul du timing de chaque impulsion
            let relativeTime = Double(i) * interval
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0) // Un peu plus sec pour bien séparer les coups
            
            // .hapticTransient est une impulsion courte (un "tap")
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: relativeTime)
            events.append(event)
        }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Erreur pattern: \(error)")
        }
    }
}
