//
//  DetectCarApp.swift
//  DetectCar
//
//  Created by Ekaterina Khudzhamkulova on 20.3.2022.
//

import SwiftUI

@main
struct DetectCarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ChooseFileViewModel())
        }
    }
}
