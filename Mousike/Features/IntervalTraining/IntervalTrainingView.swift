//
//  IntervalTraining.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-03.
//

import SwiftUI

struct IntervalTrainingView: View {
    @StateObject var viewModel = IntervalTrainingViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)

            VStack {
                IntervalTrainingPicker(viewModel: viewModel)
                    .frame(height: 60)
                    .padding(.bottom)
                ExerciceView(viewModel: viewModel, interval: viewModel.currentInterval)
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
