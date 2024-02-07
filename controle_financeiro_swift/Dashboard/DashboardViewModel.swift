//
//  DashboardViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 15/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class DashboardViewModel: ObservableObject {
    @Published var user: UserModel = UserModel(name: "", email: "")
    @Published var showNewExpenseModal: Bool = false
    @Published var expenses: [ExpenseModel] = []
    @Published var lastExpenses: [ExpenseModel] = []
    @Published var lastIncomes: [ExpenseModel] = []
    @Published var outcomeValue: Double = 0.0
    @Published var incomeValue: Double = 0.0
    @Published var loading: Bool = false
    @Published var loadingPhoto: Bool = false
    @Published var userImage: String = ""
    
    func showExpenseModal() {
        self.showNewExpenseModal.toggle()
    }
    
    func getUserData() {
        let userId = Auth.auth().currentUser?.uid
        
        if userId != nil {
            Firestore.firestore().collection("user").document(userId!).getDocument { document, err in
                if err != nil {
                    print("Erro ao buscar dados do usuario - \(err?.localizedDescription)")
                    return
                }
                
                let currentUser = UserModel(name: document?.data()!["name"] as! String,
                                            email:  document?.data()!["email"] as! String)
                
                self.user = currentUser
            }
        }
        
    }
    
    func getOutcomes() {
        self.loading = true
        self.expenses.removeAll()
        self.outcomeValue = 0
        
        let userId = Auth.auth().currentUser?.uid
        
        if(userId != nil) {
            Firestore.firestore().collection("expenses").document(userId!).collection("outcome").getDocuments { querySnapshot, err in
                if err != nil {
                    self.loading = false
                    print("Erro ao buscar documentos => \(err?.localizedDescription)")
                    return
                }
                
                
                for document in querySnapshot!.documents {
                    let newDocument = ExpenseModel(id:document.data()["id"] as! String,
                                                   date: document.data()["date"] as! String,
                                                   title: document.data()["title"] as! String,
                                                   type: document.data()["type"] as! Int,
                                                   value: document.data()["value"] as! Double)
                    
                    self.expenses.append(newDocument)
                    self.outcomeValue += document.data()["value"] as! Double
                }
                
                self.loading = false
            }
            
            self.loading = false
        }
    }
    
    func getIncomes() {
        self.loading = true
        self.expenses.removeAll()
        self.incomeValue = 0
        
        let userId = Auth.auth().currentUser?.uid
        
        if(userId != nil) {
            Firestore.firestore().collection("expenses").document(userId!).collection("income").getDocuments { querySnapshot, err in
                if err != nil {
                    self.loading = false
                    print("Erro ao buscar documentos => \(err?.localizedDescription)")
                    return
                }
                
                
                for document in querySnapshot!.documents {
                    print(document.data())
                    let newDocument = ExpenseModel(id:document.data()["id"] as! String,
                                                   date: document.data()["date"] as! String,
                                                   title: document.data()["title"] as! String,
                                                   type: document.data()["type"] as! Int,
                                                   value: document.data()["value"] as! Double)
                    
                    self.expenses.append(newDocument)
                    self.incomeValue += document.data()["value"] as! Double
                }
                
                self.loading = false
            }
            
            self.loading = false
        }
    }
    
    func getLastOutcome() {
        self.loading = true
        self.lastExpenses.removeAll()
        
        let userId = Auth.auth().currentUser?.uid
        
        if(userId != nil) {
            Firestore.firestore().collection("expenses").document(userId!).collection("outcome").limit(to: 5).getDocuments { querySnapshot, err in
                if err != nil {
                    self.loading = false
                    print("Erro ao buscar documentos => \(err?.localizedDescription)")
                    return
                }
                
                for document in querySnapshot!.documents {
                    let newDocument = ExpenseModel(id:document.data()["id"] as! String,
                                                   date: document.data()["date"] as! String,
                                                   title: document.data()["title"] as! String,
                                                   type: document.data()["type"] as! Int,
                                                   value: document.data()["value"] as! Double)
                    
                    self.lastExpenses.append(newDocument)
                }
                
                self.loading = false
            }
            self.loading = false
        }
    }
    
    func getUserImage() {
        self.loadingPhoto = true
        
        let userId = Auth.auth().currentUser?.uid
    
        let ref = Storage.storage().reference(withPath: "images").listAll { StorageListResult, Error in
            for photo in StorageListResult!.items {
                if photo.name == "\(userId!).jpg" {
                    photo.downloadURL { url, err in
                        self.userImage = url!.absoluteString
                        self.loadingPhoto = false
                    }
                }
            }
        }
    }
    
    func getLastIncome() {
        self.loading = true
        self.lastIncomes.removeAll()
        
        let userId = Auth.auth().currentUser?.uid
        
        if(userId != nil) {
            Firestore.firestore().collection("expenses").document(userId!).collection("income").limit(to: 5).getDocuments { querySnapshot, err in
                if err != nil {
                    self.loading = false
                    print("Erro ao buscar documentos => \(err?.localizedDescription)")
                    return
                }
                
                for document in querySnapshot!.documents {
                    let newDocument = ExpenseModel(id:document.data()["id"] as! String,
                                                   date: document.data()["date"] as! String,
                                                   title: document.data()["title"] as! String,
                                                   type: document.data()["type"] as! Int,
                                                   value: document.data()["value"] as! Double)
                    
                    self.lastIncomes.append(newDocument)
                }
                
                self.loading = false
            }
            self.loading = false
        }
    }
    
}
