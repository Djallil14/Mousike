//
//  ChordRecognitionMainView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-06.
//

import SwiftUI

struct ChordRecognitionMainView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ChordRecognitionViewModel()
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            VStack {
                Button(action: {
                    viewModel.playNote(viewModel.correctNote)
                }) {
                    VStack {
                        HStack(spacing: 40) {
                            Spacer()
                            VStack {
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.white)
                                Text("Replay")
                                    .font(.caption)
                                    .bold()
                                    .foregroundStyle(AngularGradient.defaultGradient)
                            }
                            .padding()
                            .clipShape(Capsule())
                            Spacer()
                        }
                        Text("Question: Guess the Chord")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom)
                    }
                }
                .buttonStyle(NoteRecognitionButtonStyle())
                .padding(.horizontal)
                .frame(minHeight: 180, maxHeight: 220)
                LazyVGrid(columns: rows, spacing: 15) {
                    ForEach(viewModel.answerNotes) { note in
                        Button(action: {
                            viewModel.checkAnswer(note)
                        }) {
                            VStack {
                                Text(note.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                if let image = note.chordImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 80, height: 40)
                                        .padding()
                                }
                            }
                        }.padding()
                        .background(handleNoteBackground(note: note))
                        .clipShape(Capsule())
                    }
                    .disabled(viewModel.didAnswer)
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
        }
    }
    
    @ViewBuilder
    private func handleNoteBackground(note: Note) -> some View {
        if viewModel.didAnswer {
            if viewModel.showAnswer {
                if note == viewModel.correctNote {
                    AngularGradient.greenGradient
                } else {
                    AngularGradient.redGradient
                }
            } else {
                if note == viewModel.selectedNote {
                    AngularGradient.purpleGradient
                } else {
                    AngularGradient.blueGradient
                }
            }
        } else {
            AngularGradient.blueGradient
        }
    }
}

struct ChordRecognitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        ChordRecognitionMainView()
            .onAppear {
                AudioEngine.shared.start()
            }
    }
}
