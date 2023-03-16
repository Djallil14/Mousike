//
//  ExerciceView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI

struct ExerciceView: View {
    @ObservedObject var viewModel: IntervalTrainingViewModel
    let interval: Interval
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack {
            Button(action: {
                viewModel.playNoteAndInterval(viewModel.correctNote, interval: interval)
            }) {
                VStack {
                    HStack(spacing: 40) {
                        Spacer()
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                            Text("Replay")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    Text("Question: Select the \(interval.title) for \(viewModel.correctNote.name)")
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                .padding()
                .background {
                    Capsule()
                        .fill(AngularGradient.blueGradient)
                }
            }
            .buttonStyle(.plain)
            .frame(minHeight: 180, maxHeight: 220)
            .padding(.horizontal)
            LazyVGrid(columns: rows, spacing: 15) {
                ForEach(viewModel.answerNotes) { note in
                    Button(action: {
                        viewModel.checkAnswer(note)
                    }) {
                            Text(note.name)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal)
                    }
                    .padding()
                    .background(handleNoteBackground(note: note, interval: interval))
                    .clipShape(Capsule())
                }
                .disabled(viewModel.didAnswer)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func handleNoteBackground(note: Note, interval: Interval) -> some View {
        if viewModel.didAnswer {
            if viewModel.showAnswer {
                if note == Interval.getIntervalForNote(viewModel.correctNote, interval: interval) {
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

struct ExerciceView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciceView(viewModel: .init(), interval: .majorSixth)
            .onAppear {
                AudioEngine.shared.start()
            }
    }
}
