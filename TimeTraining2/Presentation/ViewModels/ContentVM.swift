//
//  TrainingVM.swift
//  TimeTraining2
//
//  Created by Guillaume OLLIVIER on 24/12/2025.
//

import Foundation
internal import Combine

class ContentVM: ObservableObject {
/*
    @Published var sequenceElapseTime: Float=0
    @Published var sequenceRemainTime: Float=0
    @Published var sequenceTotalDuration: Float=0

    @Published var stepIndex:Int=0
    @Published var stepElapseTime:Float=0
    @Published var stepRemainTime:Float=0
    @Published var stepTitle:String?
    
    @Published var globalSequenceCount:Int=0
    @Published var globalElapseTime:Float=0

    @Published var sequence: ExerciseSequence
    
    let trainingTimer:TrainingTimer
    var timer:Timer?
    
    init() {
        let s=ExerciseSequence(label: "test", steps: [])
        self.sequence = s
        trainingTimer=TrainingTimer(sequence: s)
    }
    
    func addStep(duration:Float=0, title:String="") -> Int {
        let count=trainingTimer.addSequence(duration: duration, title: title)
        updateProperties()
        return count
    }
    
    func updateStep(id:UUID, duration:Float?=nil, title:String?=nil) {
        guard let index=trainingTimer.sequence.steps.firstIndex(where: { $0.id==id }) else { return }
        trainingTimer.updateSequence(index: index, duration: duration, title: title)
        updateProperties()
    }

    func updateStep(index:Int, duration:Float?=nil, title:String?=nil) {
        trainingTimer.updateSequence(index: index, duration: duration, title: title)
        updateProperties()
    }

    func clear() {
        trainingTimer.clearSequences()
        updateProperties()
    }

    func start() {
        trainingTimer.start()
        timer=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.trainingTimer.updateElapse()
            self.updateProperties()
        }
    }
    

    func pause() {
        trainingTimer.pause()
        self.updateProperties()
        if let timer=timer {
            //stop timer
            timer.invalidate()
            self.timer=nil
        }
    }
    
    func reset() {
        trainingTimer.reset()
        self.updateProperties()
        if let timer=timer {
            //stop timer
            timer.invalidate()
            self.timer=nil
        }
    }
    
    private func updateProperties() {
        self.sequence = trainingTimer.sequence
        self.sequenceElapseTime = trainingTimer.sequenceElapseTime
        self.sequenceRemainTime = trainingTimer.sequenceRemainTime
        self.sequenceTotalDuration = trainingTimer.sequenceTotalDuration
        self.stepIndex = trainingTimer.stepIndex
        self.stepElapseTime = trainingTimer.stepElapseTime
        self.stepRemainTime = trainingTimer.stepRemainTime
        self.stepTitle = trainingTimer.stepTitle
        self.globalSequenceCount = trainingTimer.globalSequenceCount
        self.globalElapseTime = trainingTimer.globalElapseTime
    }
    */
}
