//
//  LoginViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 04/01/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var loading: Bool = false
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    func doLogin() {
        self.loading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.hasError = true
                self.errorMessage = error!.localizedDescription
                self.loading = false
                return
            }
        }    
    }
}
