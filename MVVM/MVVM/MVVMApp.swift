//
//  MVVMApp.swift
//  MVVM
//
//  Created by Roel Spruit on 16/06/2021.
//

import SwiftUI

@main
struct MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(viewModel: ContentViewModel())
            }
        }
    }
}
