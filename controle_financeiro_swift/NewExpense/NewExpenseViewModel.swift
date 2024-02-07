//
//  NewExpenseViewModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 15/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewExpenseViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var value: String = ""
    @Published var date: Date = Date()
    @Published var expenseType: Int = 0
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""
    @Published var loading: Bool = false
    
    var convertedValue: Double = 0
    
    func formatValue() {
        let formattedValue = value.replacingOccurrences(of: ",", with: ".")
            
        let doubleValue = Double(formattedValue) ?? nil
        if doubleValue == nil {
            hasError = true
            errorMessage = "O valor digitado não é válido!"
            return
        }
        
        convertedValue = doubleValue!
    }
    
    func resetValues() {
        title = ""
        value = ""
        date = Date()
        expenseType = 0
        hasError = false
        convertedValue = 0
        errorMessage = ""
    }
    
    func registerData() {
        if title == "" || value == "" {
            hasError = true
            errorMessage = "Preencha todos os campos!"
            return
        }
        
        formatValue()
        
        do {
            loading = true
            
            if let userId = Auth.auth().currentUser?.uid {
                let type = expenseType == 0 ? "income" : "outcome"
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let formattedDate = formatter.string(from: self.date)
                
                let documentId = UUID().uuidString
                
                Firestore.firestore()
                    .collection("expenses")
                    .document(userId)
                    .collection(type)
                    .document(documentId)
                    .setData([
                        "id": documentId,
                        "title": title,
                        "value": convertedValue,
                        "date": formattedDate,
                        "type": expenseType
                    ])

                resetValues()
                loading = false
            }
        } catch {
            loading = false
            print(error.localizedDescription)
        }
    }
}
