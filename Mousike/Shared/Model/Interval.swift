//
//  Interval.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-07.
//

import Foundation

enum Interval: Int, Identifiable, CaseIterable {
    var id: String {
        title
    }
    case unison = 0
    case minorSecond = 1
    case majorSecond = 2
    case minorThird = 3
    case majorThird = 4
    case perfectFourth = 5
    case augmentedFourth = 6
    case perfectFifth = 7
    case minorSixth = 8
    case majorSixth = 9
    case minorSeventh = 10
    case majorSeventh = 11
    case octave = 12
    
    var title: String {
        switch self {
        case .unison:
            return "Unison"
        case .minorThird:
            return "Minor Third"
        case .majorThird:
            return "Major Third"
        case .perfectFourth:
            return "Perfect Fourth"
        case .minorSixth:
            return "Minor sixth"
        case .majorSixth:
            return "Major sixth"
        case .octave:
            return "Octave"
        case .minorSecond:
            return "Minor Second"
        case .majorSecond:
            return "Major Second"
        case .augmentedFourth:
            return "Augmented Fourth"
        case .perfectFifth:
            return "Perfect Fifth"
        case .majorSeventh:
            return "Major Seventh"
        case .minorSeventh:
            return "Minor Seventh"
        }
    }
    
    static func getIntervalForNote(_ note: Note, interval: Interval) -> Note? {
        return Note.notes.first(where: {$0.octave == (note.octave + interval.rawValue)})
    }
}
