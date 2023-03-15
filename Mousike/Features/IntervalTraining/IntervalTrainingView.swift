//
//  IntervalTraining.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI

struct IntervalTrainingView: View {
    @State var selectedInterval: Interval = .majorSixth
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.5), .cyan.opacity(0.5), .white, .white], startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            VStack {
                IntervalTrainingPicker(selectedInterval: $selectedInterval)
                    .frame(height: 60)
                    .padding(.bottom)
                ExerciceView(interval: selectedInterval)
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Interval Training")
            .navigationBarTitleDisplayMode(.inline)
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
}

struct IntervalTraining_Previews: PreviewProvider {
    static var previews: some View {
        IntervalTrainingView()
    }
}
