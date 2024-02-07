//
//  ReportViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 22/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ReportViewModel: ObservableObject {
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var loading: Bool = false
    @Published var expenses: [ExpenseModel] = []
    @Published var expenseType: Int = 1
    @Published var totalValue: Double = 0.0
    
    var helpers = Helpers()
    
    func getDateExpenses() {
        self.totalValue = 0.0
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
                    let documentDate = self.helpers.formatStringToDate(date: document.data()["date"] as! String)                                        
                    
                    if documentDate >= self.startDate && documentDate <= self.endDate {
                        self.totalValue += document.data()["value"] as! Double
                        
                        let newDocument = ExpenseModel(id:document.data()["id"] as! String,
                                                       date: self.helpers.formatDateToString(date: document.data()["date"] as! String),
                                                       title: document.data()["title"] as! String,
                                                       type: document.data()["type"] as! Int,
                                                       value: document.data()["value"] as! Double)
                        
                        self.expenses.append(newDocument)
                        
                    }
                }
                
                self.loading = false
            }
            
            self.loading = false
        }
    }
}
