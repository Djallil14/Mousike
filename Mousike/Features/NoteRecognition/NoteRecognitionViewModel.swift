//
//  NoteRecognitionViewModel.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-15.
//

import SwiftUI

class NoteRecognitionViewModel: ObservableObject {
    @Published var answerNotes: [Note] = []
    @Published var correctNote: Note
    @Published var didAnswer: Bool = false
    @Published var selectedNote: Note?
    @Published var showAnswer: Bool = false
    
    let engine = AudioEngine.shared
    
    init() {
        correctNote = Note.beginnersNotes.randomElement()!
        generateFirstQuestion()
    }
    
    private func generateFirstQuestion() {
        var proposedNotes: [Note] = []
        proposedNotes.append(correctNote)
        while proposedNotes.count < 6 {
            if let randomNote = Note.beginnersNotes.randomElement(), !proposedNotes.contains(randomNote) {
                proposedNotes.append(randomNote)
            }
        }
        let notes = proposedNotes.shuffled()
        withAnimation(.spring()) {
            answerNotes = notes
        }
    }
    
    private func generateNextQuestion() {
        correctNote = Note.beginnersNotes.randomElement()!
        withAnimation {
            didAnswer = false
            selectedNote = nil
        }
        var proposedNotes: [Note] = []
        proposedNotes.append(correctNote)
        while proposedNotes.count < 6 {
            if let randomNote = Note.beginnersNotes.randomElement(), !proposedNotes.contains(randomNote) {
                proposedNotes.append(randomNote)
            }
        }
        let notes = proposedNotes.shuffled()
        withAnimation(.spring()) {
            answerNotes = notes
        }
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
                self.generateNextQuestion()
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
