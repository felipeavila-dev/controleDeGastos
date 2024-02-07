//
//  ReportView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 22/01/24.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject var viewModel: ReportViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                FilterArea()
                
                if(viewModel.expenses.isEmpty) {
                    Text("Não há lançamentos para exibir!")
                        .padding(.top, 40)
                        .foregroundColor(Color.white)
                } else {
                    ListArea()
                }
            }
            .padding(.top, 60)
            .padding(.horizontal)
            .background(Color("background"))
        }
    }
}

extension ReportView {
    func FilterArea() -> some View {
        VStack(spacing: 20) {            
            DatePicker("Data inicial:", selection: $viewModel.startDate ,displayedComponents: DatePickerComponents.date)
                .datePickerStyle(.compact)
                .foregroundColor(.white)
                .colorScheme(.dark)
                .environment(\.locale, Locale.init(identifier: "pt_BR"))
            
            DatePicker("Data final:", selection: $viewModel.endDate ,displayedComponents: DatePickerComponents.date)
                .datePickerStyle(.compact)
                .foregroundColor(.white)
                .colorScheme(.dark)
                .environment(\.locale, Locale.init(identifier: "pt_BR"))
            
            HStack(spacing: 8) {
                Button {
                    viewModel.expenseType = 0
                } label: {
                    Text("Receita")
                        .padding(6)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.expenseType == 0 ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(4)
                }

                Spacer()
                
                Button {
                    viewModel.expenseType = 1
                } label: {
                    Text("Despesa")
                        .padding(6)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.expenseType == 1 ? Color.red : Color.gray)
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(4)
                }
            }
            
            Button(action: {
                viewModel.getDateExpenses()
            }, label: {
                Text("Procurar")
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color.orange)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .bold()
            })
        }
    }
    
    func ListArea() -> some View {
        VStack {
            Text("Total: R$ \(viewModel.totalValue, specifier: "%.2f")")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.white)
                .padding(.top, 24)
                .bold()
            
            ForEach(viewModel.expenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.date)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Text(expense.title)
                            .foregroundColor(.white)
                            .bold()
                        
                        Spacer()
                        
                        Text("R$ \(expense.value, specifier: "%.2f")")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color("gray800"))
                .cornerRadius(8)
            }
        }
    }
}

#Preview {
    ReportView(viewModel: ReportViewModel())
}
