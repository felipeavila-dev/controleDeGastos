//
//  ExpensesListModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 17/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ExpensesListModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var expenses: [ExpenseModel] = []
    @Published var expenseType: Int
    
    var helpers = Helpers()
    
    init(expenseType: Int) {
        self.expenseType = expenseType
    }
    
    func getExpenses() {
        self.loading = true
        self.expenses.removeAll()
        
        let expenseType = self.expenseType == 0 ? "income" : "outcome"
        let userId = Auth.auth().currentUser?.uid
        
        if(userId != nil) {
            Firestore.firestore().collection("expenses").document(userId!).collection(expenseType).getDocuments { querySnapshot, err in
                if err != nil {
                    self.loading = false
                    print("Erro ao buscar documentos => \(err?.localizedDescription)")
                    return
                }
                
                
                for document in querySnapshot!.documents {
                    let newDocument = ExpenseModel(id:document.data()["id"] as! String,
                                                   date: self.helpers.formatDateToString(date: document.data()["date"] as! String),
                                                   title: document.data()["title"] as! String,
                                                   type: document.data()["type"] as! Int,
                                                   value: document.data()["value"] as! Double)
                    
                    self.expenses.append(newDocument)
                }
                
                self.loading = false
            }
            
            self.loading = false
        }
    }
    
    
    func deleteExpense(documentId: String) {
        let expenseType = self.expenseType == 0 ? "income" : "outcome"
        let userId = Auth.auth().currentUser?.uid
        
 
        Firestore.firestore().collection("expense").document(userId!).collection(expenseType).document(documentId).delete()        
    }
}
