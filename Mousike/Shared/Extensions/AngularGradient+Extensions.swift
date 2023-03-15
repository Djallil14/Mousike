//
//  AngularGradient+Extensions.swift
//  Mousike
//
//  Created by Djallil Elkebir on 2023-03-15.
//

import SwiftUI

extension AngularGradient {
    static let defaultGradient = AngularGradient(colors: [.white, .cyan, .blue, .cyan], center: .zero)
    static let inversedGradient = AngularGradient(colors: [.cyan, .blue, .cyan, .white], center: .zero)
    static let purpleGradient = AngularGradient(colors: [.purple, .cyan, .blue, .purple], center: .zero)
    static let blueGradient = AngularGradient(colors: [.blue, .cyan, .blue, .cyan], center: .zero)
}
