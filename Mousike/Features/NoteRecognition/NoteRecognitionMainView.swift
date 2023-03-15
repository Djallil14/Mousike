//
//  NoteRecognitionMainView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-04.
//

import SwiftUI

struct NoteRecognitionMainView: View {
    @StateObject var viewModel = NoteRecognitionViewModel()
    @Environment(\.dismiss) var dismiss
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.5), .cyan.opacity(0.5), .white, .white], startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            VStack {
                Button(action: {
                    viewModel.playNote(viewModel.correctNote)
                }) {
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
                }
                .buttonStyle(NoteRecognitionButtonStyle())
                .frame(height: 120)
                .padding(.horizontal)
                Text("Question: Guess the note")
                    .font(.headline)
                    .padding()
                LazyVGrid(columns: rows, spacing: 15) {
                    ForEach(viewModel.answerNotes) { note in
                        Button(action: {
                            viewModel.checkAnswer(note)
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
            .onAppear {
                viewModel.engine.start()
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

struct NoteRecognitionMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoteRecognitionMainView()
        }
    }
}
