//
//  ExerciceView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI

struct ExerciceView: View {
    let interval: Interval
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        VStack {
            Text(interval.title)
                .font(.title)
                .bold()
                .padding()
            Button(action: {}) {
                HStack(spacing: 40) {
                    Spacer()
                    VStack (spacing: 10){
                        Text("C5")
                            .bold()
                            .foregroundColor(.white)
                        Image(systemName: "music.note")
                            .bold()
                            .foregroundColor(.white)
                        Text("E5")
                            .bold()
                            .foregroundColor(.white)
                    }
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
                .padding(8)
                .background {
                    Capsule()
                        .fill(AngularGradient.blueGradient)
                }
            }
            .buttonStyle(.plain)
            .frame(height: 150)
            .padding(.horizontal)
            Text("Question: Select the correct interval")
                .font(.headline)
                .padding()
            LazyVGrid(columns: rows, spacing: 15) {
                Button(action: {}) {
                    ZStack {
                        Capsule()
                            .fill(AngularGradient.blueGradient)
                        Text(interval.title)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.vertical)
                    }
                }
                
                ForEach(0..<5) { _ in
                    Button(action: {}) {
                        ZStack {
                            Capsule()
                                .fill(AngularGradient.blueGradient)
                            Text(Interval.allCases.randomElement()!.title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ExerciceView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciceView(interval: .majorSixth)
    }
}
