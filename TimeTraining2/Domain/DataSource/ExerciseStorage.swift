//
//  ExerciseStorage.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 24/01/2026.
//

import Foundation

final class ExerciseStorage {
    private static let key = "exercise_sequences"

    static func save(_ exercises: [ExerciseSequence]) {
        do {
            let data = try JSONEncoder().encode(exercises)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("❌ Erreur sauvegarde:", error)
        }
    }

    static func load() -> [ExerciseSequence] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }

        do {
            return try JSONDecoder().decode([ExerciseSequence].self, from: data)
        } catch {
            print("❌ Erreur chargement:", error)
            return []
        }
    }
}
