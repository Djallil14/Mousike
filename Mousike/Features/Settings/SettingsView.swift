//
//  SettingsView.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-04.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Settings")
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action:{dismiss()}) {
                    Image(systemName: "arrow.left")
                        .font(.headline)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(AngularGradient.defaultGradient)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
