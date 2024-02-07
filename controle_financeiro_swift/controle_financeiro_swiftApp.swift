//
//  controle_financeiro_swiftApp.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 04/01/24.
//

import SwiftUI
import FirebaseCore

@main
struct controle_financeiro_swiftApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
