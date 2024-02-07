//
//  ExpensesListView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 17/01/24.
//

import SwiftUI

struct ExpensesListView: View {
    @ObservedObject var viewModel: ExpensesListModel
        
    
    var body: some View {
            ScrollView {
                ForEach(viewModel.expenses) { expense in
                    HStack {
                        VStack {
                            HStack {
                                Text(expense.title)
                                    .foregroundColor(Color.white)
                                Spacer()
                                Text("R$ \(expense.value, specifier: "%.2f")")
                                    .foregroundColor(Color.white)
                            }
                            
                            HStack {
                                Spacer()
                                Text("\(expense.date)")
                                    .foregroundColor(Color.white)
                            }
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("gray800"))
                        .cornerRadius(8.0)
                        
//                        Button {
//                            viewModel.deleteExpense(documentId: expense.id)
//                        } label: {
//                            Image(systemName: "trash.circle.fill")
//                                .resizable()
//                                .frame(width: 25, height: 25)
//                                .foregroundColor(Color.red)
//                                .padding(.horizontal, 8)
//                        }                        
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("background"))
            .onAppear {
                viewModel.getExpenses()
            }
    }
}

#Preview {
    ExpensesListView(viewModel: ExpensesListModel(expenseType: 0))
}
