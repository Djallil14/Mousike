//
//  IntervalTrainingExercice.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI
struct IntervalTrainingPicker: View {
    @ObservedObject var viewModel: IntervalTrainingViewModel
    let invervals = Interval.allCases
    let rows = [GridItem(.flexible())]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(invervals) { interval in
                    Button(action: {
                        withAnimation {
                            viewModel.currentInterval = interval
                        }
                        viewModel.generateNextQuestion()
                    }) {
                        ZStack {
                            if viewModel.currentInterval == interval {
                                Capsule()
                                    .fill(AngularGradient.blueGradient)
                            } else {
                                Capsule()
                                    .stroke(lineWidth: 2)
                                    .fill(AngularGradient(colors: [.blue, .blue,.blue.opacity(0.5), .blue, .purple], center: .center))
                            }
                            Text(interval.title)
                                .font(.headline)
                                .foregroundStyle(viewModel.currentInterval == interval ? AngularGradient(colors: [.white], center: .center) : AngularGradient.blueGradient)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct IntervalTrainingExercice_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTrainingPicker(viewModel: .init())
    }
}
