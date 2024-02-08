//
//  NewExpenseModel.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 15/01/24.
//

import Foundation

struct ExpenseModel: Codable, Identifiable, Hashable {
    var id: String
    var date: String
    var title: String
    var type: Int
    var value: Double
}
