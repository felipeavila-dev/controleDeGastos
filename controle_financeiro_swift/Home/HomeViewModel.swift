//
//  HomeViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 08/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    func logout() {
        try! Auth.auth().signOut()
    }
    
    
}
