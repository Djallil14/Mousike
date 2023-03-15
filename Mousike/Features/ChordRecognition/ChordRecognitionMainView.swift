//
//  ChordRecognitionMainView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-06.
//

import SwiftUI

struct ChordRecognitionMainView: View {
    @Environment(\.dismiss) var dismiss
    let engine = AudioEngine.shared
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack {
            Button(action: {}) {
                HStack(spacing: 40) {
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(AngularGradient.blueGradient)
                        Text("Replay")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(AngularGradient.blueGradient)
                    }
                    .padding()
                    .background(Color.white.blendMode(.overlay))
                    .clipShape(Capsule())
                    Spacer()
                }
                .padding(.vertical, 8)
                .background {
                    Capsule()
                        .fill(AngularGradient.defaultGradient)
                }
            }
            .buttonStyle(.plain)
            .frame(height: 120)
            .padding(.horizontal)
            Text("Question: Guess the Chord")
                .font(.headline)
                .padding()
            LazyVGrid(columns: rows, spacing: 15) {
                ForEach(Note.randomChords.shuffled().prefix(6)) { note in
                    Button(action: {
                        playNote(note)
                    }) {
                        VStack {
                            if let image = note.chordImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 50)
                                    .padding()
                            }
                            Text(note.name)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(AngularGradient.defaultGradient)
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

struct ChordRecognitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        ChordRecognitionMainView()
    }
}
