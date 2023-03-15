//
//  IntervalTrainingExercice.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI

struct IntervalTrainingExercice: View {
    @State var interval: Interval = .majorSixth
    var body: some View {
        IntervalTrainingPicker(selectedInterval: $interval)
    }
}

struct IntervalTrainingExercice_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTrainingExercice()
    }
}

struct IntervalTrainingPicker: View {
    let invervals = Interval.allCases
    @Binding var selectedInterval: Interval
    let rows = [GridItem(.flexible())]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 10) {
                ForEach(invervals) { interval in
                    Button(action: {
                        withAnimation {
                            selectedInterval = interval
                        }
                    }) {
                        ZStack {
                            if selectedInterval == interval {
                                Capsule()
                                    .fill(AngularGradient.blueGradient)
                            } else {
                                Capsule()
                                    .stroke(lineWidth: 2)
                                    .fill(AngularGradient(colors: [.blue, .blue,.blue.opacity(0.5), .blue, .purple], center: .center))
                            }
                            Text(interval.title)
                                .font(.headline)
                                .foregroundStyle(selectedInterval == interval ? AngularGradient(colors: [.white], center: .center) : AngularGradient.blueGradient)
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

