//
//  Notes.swift
//  Melomania Proto without firebase
//
//  Created by Djallil Elkebir on 2021-06-07.
//

import UIKit

enum ChordType: Codable {
    case major
    case minor
    
    static var randomElement: ChordType {
        if Bool.random() {
            return .major
        } else {
            return .minor
        }
    }
}

struct Note: Identifiable, Codable ,Equatable, Hashable {
    var id: Int
    var name: String
    var soundURL: String
    var alternativeName: String
    var octave: Int
    var pianoImage: UIImage? {
        let nameString = "\(name.uppercased().components(separatedBy: .decimalDigits).joined())"
        return UIImage(named: nameString)
    }
    
    var chordImage: UIImage? {
        switch chord {
        case .none:
            return nil
        case .major:
            let nameString = "\(name.uppercased().components(separatedBy: .decimalDigits).joined())MajorChord"
            return UIImage(named: nameString)
        case .minor:
            let nameString = "\(name.uppercased().components(separatedBy: .decimalDigits).joined())MinorChord"
            return UIImage(named: nameString)
        }
    }
    var chord: ChordType?
    
    var majorChordSecondNote: UInt8 {
        let int = octave + 4
        return UInt8(int)
    }
    
    var majorChordThirdNote: UInt8 {
        let int = majorChordSecondNote + 3
        return UInt8(int)
    }
    
    var minorChordSecondNote: UInt8 {
        let int = octave + 3
        return UInt8(int)
    }
    
    var minorChordThirdNote: UInt8 {
        let int = minorChordSecondNote + 4
        return UInt8(int)
    }
    
    var chordTitle: String {
        if let chord = chord {
            switch chord {
            case .major:
                return "Major Chord \(name.uppercased())"
            case .minor:
                return "Minor Chord \(name.uppercased())"
            }
        } else {
            return "Major Chord \(name.uppercased())"
        }
    }
    
    var alternativeChordTitle: String {
        if let chord = chord {
            switch chord {
            case .major:
                return "Major Chord \(alternativeName)"
            case .minor:
                return "Minor Chord \(alternativeName)"
            }
        } else {
            return "Major Chord \(alternativeName)"
        }
    }
    
    var regularTitle: String {
        return name.uppercased()
    }
}

// Notes
extension Note {
    static let notes: [Note] = [
        Note(id: 1, name: "C3", soundURL: "c3", alternativeName: "Do3", octave: 48),
        Note(id: 2, name: "C#3", soundURL: "c-3", alternativeName: "Do#3", octave: 49),
        Note(id: 3, name: "D3", soundURL: "d3", alternativeName: "Ré3", octave: 50),
        Note(id: 4, name: "D#3", soundURL: "d-3", alternativeName: "Ré#3", octave: 51),
        Note(id: 5, name: "E3", soundURL: "e3", alternativeName: "Mi3", octave: 52),
        Note(id: 6, name: "F3", soundURL: "f3", alternativeName: "Fa3", octave: 53),
        Note(id: 7, name: "F#3", soundURL: "f-3", alternativeName: "Fa#3", octave: 54),
        Note(id: 8, name: "G3", soundURL: "g3", alternativeName: "Sol3", octave: 55),
        Note(id: 9, name: "G#3", soundURL: "g-3", alternativeName: "Sol#3", octave: 56),
        Note(id: 10, name: "A4", soundURL: "a4", alternativeName: "La4", octave: 57),
        Note(id: 11, name: "A#4", soundURL: "a-4", alternativeName: "La#4", octave: 58),
        Note(id: 12, name: "B4", soundURL: "b4", alternativeName: "Si4", octave: 59),
        Note(id: 13, name: "C4", soundURL: "c4", alternativeName: "Do4", octave: 60), // C
        Note(id: 14, name: "C#4", soundURL: "c-4", alternativeName: "Do#4", octave: 61),
        Note(id: 15, name: "D4", soundURL: "d4", alternativeName: "Ré4", octave: 62),
        Note(id: 16, name: "D#4", soundURL: "d-4", alternativeName: "Ré#4", octave: 63),// minor third
        Note(id: 17, name: "E4", soundURL: "e4", alternativeName: "Mi4", octave: 64), // major Third 64 - 60
        Note(id: 18, name: "F4", soundURL: "f4", alternativeName: "Fa4", octave: 65),
        Note(id: 19, name: "F#4", soundURL: "f-4", alternativeName: "Fa#4", octave: 66),
        Note(id: 20, name: "G4", soundURL: "g4", alternativeName: "Sol4", octave: 67),
        Note(id: 21, name: "G#4", soundURL: "g-4", alternativeName: "Sol#4", octave: 68),
        Note(id: 22, name: "A5", soundURL: "a5", alternativeName: "La5", octave: 69),
        Note(id: 23, name: "A#5", soundURL: "a-5", alternativeName: "La#5", octave: 70),
        Note(id: 24, name: "B5", soundURL: "b5", alternativeName: "Si5", octave: 71),
        Note(id: 25, name: "C5", soundURL: "c5", alternativeName: "Do5", octave: 72),
        Note(id: 26, name: "C#5", soundURL: "c-5", alternativeName: "Do#5", octave: 73),
        Note(id: 27, name: "D5", soundURL: "d5", alternativeName: "Ré5", octave: 74),
        Note(id: 28, name: "D#5", soundURL: "d-5", alternativeName: "Ré#5", octave: 75),
        Note(id: 29, name: "E5", soundURL: "e5", alternativeName: "Mi5", octave: 76),
        Note(id: 30, name: "F5", soundURL: "f5", alternativeName: "Fa5", octave: 77),
        Note(id: 31, name: "F#5", soundURL: "f-5", alternativeName: "Fa#5", octave: 78),
        Note(id: 32, name: "G5", soundURL: "g5", alternativeName: "Sol5", octave: 79),
        Note(id: 33, name: "G#5", soundURL: "g-5", alternativeName: "Sol#5", octave: 80),
        Note(id: 34, name: "A6", soundURL: "a5", alternativeName: "La5", octave: 81),
        Note(id: 35, name: "A#6", soundURL: "a-5", alternativeName: "La#5", octave: 82),
        Note(id: 36, name: "B6", soundURL: "b5", alternativeName: "Si5", octave: 83),
        Note(id: 37, name: "C6", soundURL: "c6", alternativeName: "Do6", octave: 84),
        Note(id: 38, name: "C#6", soundURL: "c-5", alternativeName: "Do#5", octave: 85),
        Note(id: 39, name: "D6", soundURL: "d5", alternativeName: "Ré5", octave: 86),
        Note(id: 40, name: "D#6", soundURL: "d-5", alternativeName: "Ré#5", octave: 87),
        Note(id: 41, name: "E6", soundURL: "e5", alternativeName: "Mi5", octave: 88),
        Note(id: 42, name: "F6", soundURL: "f5", alternativeName: "Fa5", octave: 89),
        Note(id: 43, name: "F#6", soundURL: "f-5", alternativeName: "Fa#5", octave: 90),
        Note(id: 44, name: "G6", soundURL: "g5", alternativeName: "Sol5", octave: 91),
        Note(id: 45, name: "G#6", soundURL: "g-5", alternativeName: "Sol#5", octave: 92),
        Note(id: 46, name: "A7", soundURL: "a7", alternativeName: "La5", octave: 93),
        Note(id: 47, name: "A#7", soundURL: "a-7", alternativeName: "La#5", octave: 94),
        Note(id: 48, name: "B7", soundURL: "b7", alternativeName: "Si5", octave: 95),
        Note(id: 49, name: "C7", soundURL: "c6", alternativeName: "Do6", octave: 96)
        ]
    
    static var beginnersNotes: [Note] {
        notes.filter({(13...34).contains($0.id)})
    }
    
    static var randomChords: [Note] {
        var notes: [Note] = []
        Note.notes.forEach({
            var note = $0
            note.chord = ChordType.randomElement
            notes.append(note)
        })
        return notes
    }
}
