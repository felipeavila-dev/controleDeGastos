//
//  SplashViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 08/01/24.
//

import Foundation
import FirebaseAuth

class SplashViewModel: ObservableObject {
    @Published var isLogged = Auth.auth().currentUser != nil
    
    func checkLoggedUser() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.isLogged = user != nil
        }
    }
}
