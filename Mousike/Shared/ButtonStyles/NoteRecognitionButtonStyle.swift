//
//  NoteRecognitionButtonStyle.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-15.
//

import SwiftUI

struct NoteRecognitionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? AngularGradient.purpleGradient : AngularGradient.blueGradient)
            .clipShape(Capsule())
    }
}
