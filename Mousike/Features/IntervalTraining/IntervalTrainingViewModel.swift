//
//  IntervalTrainingViewModel.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-16.
//

import SwiftUI

class IntervalTrainingViewModel: ObservableObject {
    @Published var answerNotes: [Note] = []
    @Published var correctNote: Note
    @Published var didAnswer: Bool = false
    @Published var selectedNote: Note?
    @Published var showAnswer: Bool = false
    @Published var currentInterval: Interval = .unison
    
    let engine = AudioEngine.shared
    
    init() {
        correctNote = Note.notes.randomElement()!
        generateFirstQuestion()
    }
    
    private func generateFirstQuestion() {
        var proposedNotes: [Note] = []
        if let intervalNote = Interval.getIntervalForNote(correctNote, interval: currentInterval) {
            proposedNotes.append(intervalNote)
        } else {
            correctNote = Note.notes[10]
            let intervalNote = Interval.getIntervalForNote(correctNote, interval: currentInterval)!
            proposedNotes.append(intervalNote)
        }
        while proposedNotes.count < 6 {
            if let randomNote = Note.notes.randomElement(), !proposedNotes.contains(randomNote) {
                proposedNotes.append(randomNote)
            }
        }
        let notes = proposedNotes.shuffled()
        answerNotes = notes
    }
    
    func generateNextQuestion() {
        correctNote = Note.notes.randomElement()!
        withAnimation {
            didAnswer = false
            selectedNote = nil
        }
        var proposedNotes: [Note] = []
        if let intervalNote = Interval.getIntervalForNote(correctNote, interval: currentInterval) {
            proposedNotes.append(intervalNote)
        } else {
            correctNote = Note.notes[10]
            let intervalNote = Interval.getIntervalForNote(correctNote, interval: currentInterval)!
            proposedNotes.append(intervalNote)
        }
        while proposedNotes.count < 6 {
            if let randomNote = Note.notes.randomElement(), !proposedNotes.contains(randomNote) {
                proposedNotes.append(randomNote)
            }
        }
        let notes = proposedNotes.shuffled()
        answerNotes = notes
    }
    
    func checkAnswer(_ selectedNote: Note) {
        withAnimation {
            didAnswer = true
            self.selectedNote = selectedNote
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.showAnswer = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.showAnswer = false
                self.didAnswer = false
            }
                self.generateNextQuestion()
        }
    }
    
    func playNoteAndInterval(_ note: Note, interval: Interval) {
        engine.sampler.startNote(UInt8(note.octave), withVelocity: 64, onChannel: 0)
        switch note.chord {
        case .none:
            switch interval {
            case .unison, .octave:
                if let intervalNote = Interval.getIntervalForNote(note, interval: interval) {
                    self.engine.sampler.startNote(UInt8(intervalNote.octave), withVelocity: 64, onChannel: 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.engine.sampler.stopNote(UInt8(intervalNote.octave), onChannel: 0)
                        self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
                    }
                }
            case .minorSecond, .majorSecond, .minorThird, .majorThird, .perfectFourth, .augmentedFourth, .perfectFifth, .minorSixth, .majorSixth, .majorSeventh, .minorSeventh:
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
                    if let intervalNote = Interval.getIntervalForNote(note, interval: interval) {
                        self.engine.sampler.startNote(UInt8(intervalNote.octave), withVelocity: 64, onChannel: 0)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.engine.sampler.stopNote(UInt8(intervalNote.octave), onChannel: 0)
                        }
                    }
                }
            }
        case .major:
            engine.sampler.startNote(UInt8(note.octave), withVelocity: 64, onChannel: 0)
            engine.sampler.startNote(note.majorChordSecondNote, withVelocity: 64, onChannel: 1)
            engine.sampler.startNote(note.majorChordThirdNote, withVelocity: 64, onChannel: 2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
                self.engine.sampler.stopNote(note.majorChordSecondNote, onChannel: 1)
                self.engine.sampler.stopNote(note.majorChordThirdNote, onChannel: 2)
            }
        case .minor:
            engine.sampler.startNote(UInt8(note.octave), withVelocity: 64, onChannel: 0)
            engine.sampler.startNote(note.minorChordSecondNote, withVelocity: 64, onChannel: 1)
            engine.sampler.startNote(note.minorChordThirdNote, withVelocity: 64, onChannel: 2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
                self.engine.sampler.stopNote(note.minorChordSecondNote, onChannel: 1)
                self.engine.sampler.stopNote(note.minorChordThirdNote, onChannel: 2)
            }
        }
    }
    
    func playNote(_ note: Note) {
        switch note.chord {
        case .none:
            engine.sampler.startNote(UInt8(note.octave), withVelocity: 64, onChannel: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
            }
        case .major:
            engine.sampler.startNote(UInt8(note.octave), withVelocity: 64, onChannel: 0)
            engine.sampler.startNote(note.majorChordSecondNote, withVelocity: 64, onChannel: 1)
            engine.sampler.startNote(note.majorChordThirdNote, withVelocity: 64, onChannel: 2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
                self.engine.sampler.stopNote(note.majorChordSecondNote, onChannel: 1)
                self.engine.sampler.stopNote(note.majorChordThirdNote, onChannel: 2)
            }
        case .minor:
            engine.sampler.startNote(UInt8(note.octave), withVelocity: 64, onChannel: 0)
            engine.sampler.startNote(note.minorChordSecondNote, withVelocity: 64, onChannel: 1)
            engine.sampler.startNote(note.minorChordThirdNote, withVelocity: 64, onChannel: 2)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                self.engine.sampler.stopNote(UInt8(note.octave), onChannel: 0)
                self.engine.sampler.stopNote(note.minorChordSecondNote, onChannel: 1)
                self.engine.sampler.stopNote(note.minorChordThirdNote, onChannel: 2)
            }
        }
    }
}
