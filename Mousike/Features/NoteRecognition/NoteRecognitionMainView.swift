//
//  NoteRecognitionMainView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-04.
//

import SwiftUI

struct NoteRecognitionMainView: View {
    @Environment(\.dismiss) var dismiss
    let engine = AudioEngine.shared
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.5), .cyan.opacity(0.5), .white, .white], startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            VStack {
                Button(action: {}) {
                    HStack(spacing: 40) {
                        Spacer()
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(AngularGradient.defaultGradient)
                            Text("Replay")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(AngularGradient.defaultGradient)
                        }
                        .padding()
                        .clipShape(Capsule())
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .fill(AngularGradient.blueGradient)
                    }
                }
                .buttonStyle(.plain)
                .frame(height: 120)
                .padding(.horizontal)
                Text("Question: Guess the note")
                    .font(.headline)
                    .padding()
                LazyVGrid(columns: rows, spacing: 15) {
                    ForEach(Note.beginnersNotes.prefix(6)) { note in
                        Button(action: {
                            let interval = Interval.allCases.randomElement()!
                            let invervalNote = Interval.getIntervalForNote(note, interval: interval)
                            playNote(note)
                            print("Current Note - \(note.name)")
                            print("Interval Note - \(Interval.getIntervalForNote(note, interval: interval)?.name)")
                            print("note octave \(note.octave)")
                            
                            print("Interval note octave \(invervalNote?.octave)")
                            print("Interval:")
                            print(interval.title)
                        }) {
                            VStack {
                                Text(note.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                if let image = note.pianoImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 80, height: 40)
                                        .padding()
                                }
                            }
                        }
                        .padding()
                        .background(AngularGradient.blueGradient)
                        .clipShape(Capsule())
                    }
                }
                .padding()
            }
            .navigationTitle("Note Recognition")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action:{dismiss()}) {
                        Image(systemName: "arrow.left")
                            .font(.headline)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(AngularGradient.blueGradient)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .onAppear {
                engine.start()
        }
        }
    }
    
    private func playNote(_ note: Note) {
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

struct NoteRecognitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoteRecognitionMainView()
        }
    }
}
