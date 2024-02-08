//
//  LoginViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 04/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel
: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var loading: Bool = false
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var userHasLogged: Bool = false
    
    private var userId: String? = nil
    
    func doLogin() {
        self.loading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.hasError = true
                self.errorMessage = error!.localizedDescription
                self.loading = false
                return
            }
            
            print("USUARIO LOGADO -> \(result!.user.uid)")
            if let currentUser = result?.user.uid {
                self.userHasLogged = true
            }
        }
    }
    
    func createUser() {
        self.loading = true
        
        if password != confirmPassword {
            self.hasError = true
            self.errorMessage = "As senhas digitadas precisam ser iguais!"
            self.loading = false
            return
        }
                        
        Auth.auth()
            .createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.hasError = true
                    self.errorMessage = error!.localizedDescription
                    self.loading = false
                    return
                }
                
                Firestore.firestore()
                    .collection("user")
                    .document(result!.user.uid)
                    .setData([
                        "name": self.name,
                        "email": self.email,
                    ])
                
                
                self.doLogin()
            }
    }
    
}
