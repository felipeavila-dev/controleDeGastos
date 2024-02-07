//
//  DashboardView.swift
//  controle_financeiro_swift
//
//  Created by Felipe Avila on 11/01/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                header()
                
                outcomeArea()
                    .onAppear {
                        viewModel.getLastOutcome()
                    }
                
                incomeArea()
                    .onAppear {
                        viewModel.getLastIncome()
                    }
                
                financialBalance()
                    .onAppear {
                        viewModel.getOutcomes()
                        viewModel.getIncomes()
                    }
            }
            .navigationTitle("Dashboard")    
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("background"))
            .onAppear {
                viewModel.getUserData()
                viewModel.getUserImage()
            }
            .sheet(isPresented: $viewModel.showNewExpenseModal) {
                NewExpenseView(viewModel: NewExpenseViewModel())
            }
        }
    }
    
}

extension DashboardView {
    func header() -> some View {
        HStack{
            
            if viewModel.loadingPhoto {
                HStack {
                    ProgressView()
                        .tint(.white)
                }
                .frame(width: 90, height: 90)
                
            } else {
                AsyncImage(url: URL(string: viewModel.userImage)) { image in
                    image.image?.resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                }
            }
            
   
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Bem vindo(a), ")
                    .foregroundColor(.white)
                    .bold()
                
                Text(viewModel.user.name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.top, -60)
        .frame(height: 250)
    }
    
    func outcomeArea() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Saídas")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 8)
                
                Spacer()
                
                Button {
                    viewModel.showExpenseModal()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.orange)
                        .padding(.horizontal, 8)
                }
                
            }
            .padding(8)
            
            Divider()
                .background(Color.gray)
            
            
            VStack {
                if viewModel.loading == true {
                    VStack(alignment: .center) {
                        ProgressView()
                            .tint(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                ForEach(viewModel.lastExpenses) { expense in
                    Button {
                    } label: {
                        HStack {
                            Image(systemName: expense.type == 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(expense.type == 0 ? Color.green : Color.red)
                            
                            Text(expense.title)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("R$ \(expense.value, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .background(Color("background"))
                        .cornerRadius(8)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                    }
                }
            }
            
            NavigationLink {
                ExpensesListView(viewModel: ExpensesListModel(expenseType: 1))
            } label: {
                Text("Ver últimas saídas")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(6)
                    .padding(8)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("gray800"))
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.top, -100)
    }
    
    func incomeArea() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Entradas")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 8)
                
                Spacer()
                
                Button {
                    viewModel.showExpenseModal()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.orange)
                        .padding(.horizontal, 8)
                }
                
            }
            .padding(8)
            
            Divider()
                .background(Color.gray)
            
            
            VStack {
                if viewModel.loading == true {
                    VStack(alignment: .center) {
                        ProgressView()
                            .tint(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                ForEach(viewModel.lastIncomes) { expense in
                    Button {
                    } label: {
                        HStack {
                            Image(systemName: expense.type == 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(expense.type == 0 ? Color.green : Color.red)
                            
                            Text(expense.title)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("R$ \(expense.value, specifier: "%.2f")")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .background(Color("background"))
                        .cornerRadius(8)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                    }
                }
            }
            
            NavigationLink {
                ExpensesListView(viewModel: ExpensesListModel(expenseType: 0))
            } label: {
                Text("Ver últimas entradas")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(6)
                    .padding(8)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("gray800"))
        .cornerRadius(12)
        .padding()
    }
    
    func financialBalance() -> some View {
        VStack(alignment: .leading) {
            Text("Equilíbrio financeiro")
                .padding(8)
                .foregroundColor(.white)
                .bold()
            
            Divider()
                .background(Color.gray)
            
            VStack(spacing: 8) {
                HStack {
                    Text("Entradas: ")
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    Text("R$ \(String(viewModel.incomeValue))")
                        .foregroundColor(.green)
                        .bold()
                }
                
                HStack {
                    Text("Saídas: ")
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                    
                    Text("R$ \(viewModel.outcomeValue, specifier: "%.2f")")
                        .foregroundColor(.red)
                        .bold()
                }
                
                HStack {
                    Text("Resultado: ")
                        .foregroundColor(.white)
                        .bold()
                    
                    
                    Spacer()
                    
                    Text("R$ \(viewModel.incomeValue - viewModel.outcomeValue, specifier: "%.2f")")
                        .foregroundColor(.orange)
                        .bold()
                }
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .background(Color("gray800"))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel())
    }
}
