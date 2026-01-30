import UIKit
import AVFoundation
import AudioToolbox

struct SoundBox {
    // MARK: - Properties
    var isVibration: Bool
    var isSound: Bool
    var maxLastSecond: Int

    // MARK: - Haptic Generators
    // On utilise des constantes pour les générateurs dans la struct
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)

    // MARK: - Initializer
    init(isVibration: Bool = true, isSound: Bool = true, maxLastSecond: Int = 3) {
        self.isVibration = isVibration
        self.isSound = isSound
        self.maxLastSecond = maxLastSecond
        
        // Configuration de la session audio
        SoundBox.setupAudioSession()
    }

    private static func setupAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: .mixWithOthers)
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    // MARK: - Main Function
    func play(event: TimeEvent) {
        switch event {
            
        case .INTERVAL_STEP:
            if isVibration { impactMedium.impactOccurred() }
            if isSound { AudioServicesPlaySystemSound(1105) }

        case .LAST_SECONDS(let seconds):
            if seconds <= maxLastSecond {
                if isVibration { impactLight.impactOccurred() }
                if isSound { AudioServicesPlaySystemSound(1104) }
            } else if seconds == maxLastSecond + 1 && isVibration {
                impactLight.prepare()
            }

        case .END_STEP:
            if isVibration { impactMedium.impactOccurred() }
            if isSound { AudioServicesPlaySystemSound(1106) }

        case .START_SEQUENCE:
            if isVibration { notificationGenerator.notificationOccurred(.success) }
            if isSound { AudioServicesPlaySystemSound(1013) }
            
        case .END_EXERCISE:
            if isVibration { notificationGenerator.notificationOccurred(.success) }
            if isSound { AudioServicesPlaySystemSound(1022) }

        case .NONE:
            break
        }
    }
}
